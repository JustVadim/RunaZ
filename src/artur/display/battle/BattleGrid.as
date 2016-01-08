package artur.display.battle 
{
	import artur.App;
	import artur.display.battle.eff.EffManajer;
	import artur.display.RasterMovie;
	import artur.display.Slot;
	import artur.units.UnitCache;
	import artur.win.WinBattle;
	import flash.display.IBitmapDrawable;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.ui.Mouse;
	
	
	public class BattleGrid 
	{
		public var nodes:Array = new Array();
		public static var wd:int = 13;
		public static var hg:int = 9;
		//private static var stones:Array = [];
		
		
		
		
		
		public function BattleGrid() 
		{
			for (var i:int = 0; i < wd; i++) 
			{
				nodes[i] = new Array();
				for (var j:int = 0; j < hg; j++) 
					nodes[i][j] = new Node(); 
			}
		}
		public function init(arr:Array = null):void
		{
			var mbat:Object = WinBattle.bat;
			for (var i:int = 0; i < wd; i++) 
			{
				for (var j:int = 0; j < hg; j++) 
					Node(nodes[i][j]).init(i, j, mbat.map.grid[i][j].id);
			}
			this.setUnitsOnScreen(mbat.locs[0], mbat.u[0], WinBattle.units[0],LifeManajer.un_Data[0], mbat.hps[0], mbat.mps[0]);
			this.setUnitsOnScreen(mbat.locs[1], mbat.u[1], WinBattle.units[1], LifeManajer.un_Data[1], mbat.hps[1], mbat.mps[1], -1);
		}
		
		public function frees():void
		{
			for (var i:int = 0; i < wd; i++) 
			{
				for (var j:int = 0; j < hg; j++) 
					Node(nodes[i][j]).frees();
			}
			/*for (var key:Object in MapStone.stonesArr) {
				var ms:MapStone = MapStone.stonesArr[key];
				if(!ms.free) {
					ms.frees();
				}
			}*/
		}
		
		private function setUnitsOnScreen(unit_locs:Object, units:Object, sc_array:Array, life_array:Array, hp:Object, mp:Object, scalse:int = 1):void 
		{
			for (var key:Object in unit_locs) 
			{		
				var loc:Object = unit_locs[key];
				if (hp[loc.pos] > 0)
				{
					var i:int = int(units[loc.pos].t);
					var unit:Object = UnitCache.getUnit(Slot.namesUnit[i]);
					var node:Node = nodes[loc.x][loc.y];
					unit.x = node.x;
					unit.y = node.y + 10;
					unit.init(WinBattle.spr,units[loc.pos].lvl);
					WinBattle.sortArr.push(unit);
					if(scalse)
						unit.scaleX = unit.normScale;
					else
						unit.scaleX = -unit.normScale;
					unit.itemUpdate(Slot.getUnitItemsArray(units[loc.pos]));
					sc_array[loc.pos] = unit
					var life_data:Object = {unit:unit,maxLife:units[loc.pos].hp, currLife:hp[loc.pos], maxMana:units[loc.pos].mp,currMana:mp[loc.pos]}
					life_array[loc.pos] = life_data;
				}
				else
				{
					sc_array[loc.pos] = null;
					life_array[loc.pos] = null;
				}
			}
		}
		
		public function showAvailableCells(s_x:int, s_y:int, range:int, is_arr:int):void
		{
			var node:Node;
			var dist:int;
			var arr:Array;
			var can_attack:Boolean = true;
			for (var i:int = 0; i < wd; i++) 
				for (var j:int = 0; j < hg; j++) 
				{
					dist = BattleGrid.getDistance(i, j, s_x, s_y);
					if (dist <= range)
					{
						arr = this.findPath(nodes[s_x][s_y], nodes[i][j]);
						if (arr != null && arr.length <= range + 1)
						{
							node = nodes[i][j];
							if (node.walcable == 0)
								node.setMove();
						}
					}
				}
			;
			
			var team:int = WinBattle.inverseTeam(WinBattle.myTeam);
			var enemy_locs:Object = WinBattle.bat.locs[team];
			var enemy_hp:Object = WinBattle.bat.hps[team];
			if (is_arr == 1)
			{
				for (var key1:Object in enemy_locs)
				{
					if (enemy_hp[key1] != 0)
					{
						dist = BattleGrid.getDistance(enemy_locs[key1].x, enemy_locs[key1].y, s_x, s_y);
						if (dist == 1)
						{
							can_attack = false;
							break;
						}
					}
				}
			}
			for (var key:Object in enemy_locs)
				if (enemy_hp[key] > 0)
				{
					node = Node(nodes[enemy_locs[key].x][enemy_locs[key].y]);
					if (is_arr == 1)
					{
						if(can_attack)
							node.setAttack();
					}
					else
					{
						dist = BattleGrid.getDistance(node.xp, node.yp, s_x, s_y);
						if (dist <= range + 1)
							node.setAttack();
					}
				}
				
		}
		public function clearNodesControl():void
		{
			for (var i:int = 0; i < wd; i++) 
				for (var j:int = 0; j < hg; j++) 
					Node(nodes[i][j]).clearControl()
		}
		public static function getDistance(x1:int, y1:int, x2:int, y2:int):int
		{
			var dx:int = x2 - x1 - Math.floor(y2 / 2) + Math.floor(y1 / 2);
			var dy:int = y2 - y1;
			if ((dx < 0 && dy < 0 ) || ( dx >= 0 && dy >= 0 ))
				return Math.abs(dx) + Math.abs(dy);
			else
				return Math.max(Math.abs(dx), Math.abs(dy));
		}
		
		public function findPath(startPoint:Node, endPoint:Node, is_bot:Boolean = false):Array
		{
			this.resetFPMap();
			var temp_node:Node;
			var arr:Array = new Array();
			startPoint.rad = 0;
			startPoint.checked = true;
			arr.push(startPoint);
			if (is_bot)
			{
				endPoint.walcable = 0;
			}
			do
			{
				temp_node = arr.shift();
				this.addUncheckedNeighborsToArray(temp_node, arr);
			}
			while (arr.length != 0);
			if (!endPoint.checked)
			{
				if (is_bot) endPoint.walcable = 0;
				return null;
			}
			else
			{
				
				arr[0] = startPoint;
				temp_node = endPoint;
				arr[temp_node.rad] = endPoint;
				for (var i:int = temp_node.rad - 1; i > 0 ; i--)
				{
					arr[i] = this.getPathNode(Node(arr[i + 1]), i);
				}
				if (is_bot) endPoint.walcable = 0;
				return arr;
			}
		}
		
		public function lightUnits(locs:Object, hps:Object, team:int):void 
		{
			var key:Object;
			for (key in locs)
			{
				if (hps[key] > 0)
				{
					var unit:MovieClip = WinBattle.units[team][key];
					var unit_data:Object = WinBattle.bat.u[team][key];
					if (unit_data.b[5] != null)
						unit.showBuff(1);
					if (team == WinBattle.myTeam)
						{Node(this.nodes[locs[key].x][locs[key].y]).mc.gotoAndStop(4);}
					else
						{Node(this.nodes[locs[key].x][locs[key].y]).mc.gotoAndStop(5);}
					if(unit.currentLabel == "idle"|| unit.currentLabel =="hurt")
					{
						unit.scaleX = (team == 0)? 1: -1;
						if(unit.scaleX<0) unit.scaleX = -unit.normScale else unit.scaleX = unit.normScale  
						unit.rotation = 0;
						unit.shawdow.visible = true;
					}
				}
				
			}
		}
		
		private function resetFPMap():void
		{
			var node:Node;
			for (var i:int = 0; i < wd; i++) 
			{
				for (var j:int = 0; j < hg; j++) 
				{
					node = nodes[i][j];
					node.resetFP();
				}
			}
		}
		
		private function addUncheckedNeighborsToArray(node:Node, arr:Array):void 
		{
			var radius:int = node.rad + 1;
			var node_x:int = node.xp;
			var node_y:int = node.yp;
			var node_dy:int = node_y % 2;
			this.addNeibor(node_x - 1 + node_dy, node_y - 1, radius, arr);
			this.addNeibor(node_x + node_dy, node_y - 1, radius, arr);
			this.addNeibor(node_x - 1 + node_dy, node_y + 1, radius, arr);
			this.addNeibor(node_x + node_dy, node_y + 1, radius, arr);
			this.addNeibor(node_x - 1, node_y, radius, arr);
			this.addNeibor(node_x + 1, node_y, radius, arr);
		}
		
		private function addNeibor(node_x:int, node_y:int, radius:int, arr:Array):void 
		{
			if (nodes[node_x] != null)
				if (nodes[node_x][node_y] != null)
				{
					var node:Node = nodes[node_x][node_y];
					if (node.walcable == 0)
					{
						node.setRadius(radius);
						if (!node.checked)
						{
							node.checked = true;
							arr.push(node);
						}
					}
				}
		}
		
		
		
		private function getPathNode(node_p:Node, rad:int):Node 
		{
			var node_x:int = node_p.xp;
			var node_y:int = node_p.yp;
			var node_dy:int = node_y % 2;
			var node:Node;
			var grid:Array = this.nodes;
			switch(true)
			{
				case (BattleGrid.isInMap(node_x - 1, node_y) && Node(grid[node_x - 1][node_y]).rad == rad):
					node = Node(grid[node_x - 1][node_y]);
					break;
				case (BattleGrid.isInMap(node_x + 1, node_y) &&Node(grid[node_x + 1][node_y]).rad == rad):
					node = Node(grid[node_x + 1][node_y]);
					break;
				case (BattleGrid.isInMap(node_x - 1 + node_dy, node_y - 1) && Node(grid[node_x - 1 + node_dy][node_y - 1]).rad == rad):
					node = grid[node_x - 1 + node_dy][node_y - 1];
					break;
				case (BattleGrid.isInMap(node_x + node_dy, node_y - 1) && Node(grid[node_x + node_dy][node_y - 1]).rad == rad):
					node = grid[node_x + node_dy][node_y - 1];
					break;
				case (BattleGrid.isInMap(node_x - 1 + node_dy, node_y + 1) && Node(grid[node_x - 1 + node_dy][node_y + 1]).rad == rad):
					node = grid[node_x - 1 + node_dy][node_y + 1];
					break;
				case (BattleGrid.isInMap(node_x + node_dy, node_y + 1) && Node(grid[node_x + node_dy][node_y + 1]).rad == rad):
					node = grid[node_x + node_dy][node_y + 1];
					break;
			}
			return node;
		}
		
		public static function isInMap(xx:int, yy:int):Boolean
		{
			return (xx >= 0 && xx < BattleGrid.wd && yy >= 0 && yy < BattleGrid.hg);
		}
		
		
		
		
		
		public function highLightUltCells(unit_type:int):void 
		{
			switch(unit_type)
			{
				case 0:
					WinBattle.makeUltimate(0);
					break;
				case 1:
					this.UltCells(true);
					break;
				case 2:
					this.UltCells(false);
					break;
				case 3:
					this.UltCells(false);
					break;
			}
		}
		
		public function disLightUltCells(unit_type:int):void {
			switch(unit_type) {
				case 1:
					this.disUltCells(true);
					break;
				case 2:
					this.disUltCells(false);
					break;
				case 3:
					this.disUltCells(false);
					break;
			}
		}
		
		private function disUltCells(is_fr:Boolean):void {
			var team:int = (is_fr)? WinBattle.myTeam:WinBattle.inverseTeam(WinBattle.myTeam);
			var locs:Object = WinBattle.bat.locs[team];
			var hps:Object = WinBattle.bat.hps[team];
			for (var key:Object in locs) {
				if (hps[key]) {
					Node(nodes[locs[key].x][locs[key].y]).dismakeUlt();
				}
			}
		}
		
		private function UltCells(is_fr:Boolean):void {
			var team:int = (is_fr)? WinBattle.myTeam:WinBattle.inverseTeam(WinBattle.myTeam);
			var locs:Object = WinBattle.bat.locs[team];
			var hps:Object = WinBattle.bat.hps[team];
			for (var key:Object in locs) {
				if (hps[key] > 0) {
					Node(nodes[locs[key].x][locs[key].y]).makeUlt();
				}
			}
		}
		
		private function DisMakeUltCells(is_fr:Boolean):void {
			var team:int = (is_fr)? WinBattle.myTeam:WinBattle.inverseTeam(WinBattle.myTeam);
			var locs:Object = WinBattle.bat.locs[team];
			var hps:Object = WinBattle.bat.hps[team];
			for (var key:Object in locs) {
				if (hps[key] > 0) {
					Node(nodes[locs[key].x][locs[key].y]).dismakeUlt();
				}
			}
		}
		
	}

}