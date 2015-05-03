package artur.win 
{
	import artur.App;
	import artur.display.battle.AttackNode;
	import artur.display.battle.BattleGrid;
	import artur.display.battle.eff.EffManajer;
	import artur.display.battle.LifeManajer;
	import artur.display.battle.MoveUnit;
	import artur.display.battle.Node;
	import artur.display.HeroInventar;
	import artur.display.Slot;
	import artur.RasterClip;
	import artur.units.UnitCache;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import report.Report;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Utils.json.JSON2;

	public class WinBattle 
	{
		private var bgs:Array = [RasterClip.raster(new Bg_Battle_1(),820,420)];
		public var grid:BattleGrid = new BattleGrid();
		public static var units:Array;
		public static var myTeam:int;
		public static var arrow:mcArrow = new mcArrow();
		public static var spr:Sprite = new Sprite();
		public static var bat:Object;
		public static var inst:WinBattle;
		public var mover:MoveUnit = new MoveUnit();
		public static var currUnit:Object; 
		public static var anim:Array = new Array();
		static public var sortArr:Array = new Array();
		public static var atackNode:AttackNode;
		public static var effManajer:EffManajer = new EffManajer();
		public var lifeManajer:LifeManajer  = new LifeManajer();
		public  var chekLifeBar:CheckLife = new CheckLife();
		public  var chekAvtoboi:ChecAvtoboi = new ChecAvtoboi();
		public var bin:Boolean = false;
		private var unitsInWin:Array = [];
		public static var winAfterBattle:mcAfterBattle = new mcAfterBattle();
		public static var looseAfterBattle:mcAfterBattleLose = new mcAfterBattleLose();
		public static var inv_bg:mcBgBatleInventar = new mcBgBatleInventar();
		public static var hero_inv:HeroInventar;
		
		
		
		public function WinBattle() 
		{
			WinBattle.winAfterBattle.btn.addEventListener(MouseEvent.CLICK, this.onCloseWin);
			WinBattle.looseAfterBattle.btn.addEventListener(MouseEvent.CLICK, this.onCloseWin);
			WinBattle.hero_inv = new HeroInventar(true);
			inst = this;
			arrow.gotoAndStop(1);
			atackNode = new AttackNode();
			chekAvtoboi.y = 14;
			this.chekAvtoboi.buttonMode = this.chekLifeBar.buttonMode = true;
		}
		
		private function onCloseWin(e:MouseEvent):void 
		{
			App.winManajer.swapWin(2);
		}
		
		private function checkCLick(e:MouseEvent):void 
		{
			if (MovieClip(e.currentTarget).currentFrame == 1)
			{
				e.currentTarget.gotoAndStop(2);
				if (e.currentTarget is CheckLife) {this.lifeManajer.showLB(true);}
				else if(bat.set[bat.cus].t == myTeam) {Node(this.grid.nodes[0][0]).sendStep();}
				
			}
			else
			{
				e.currentTarget.gotoAndStop(1);
				if (e.currentTarget is CheckLife) {this.lifeManajer.hideLb();}
			}
		}
		
		private function outCheck(e:MouseEvent):void 
		{
			e.currentTarget.bg.alpha = 0.0;
		}
		
		private function overCheck(e:MouseEvent):void 
		{
			e.currentTarget.bg.alpha = 0.5;
		}
		
		public function init():void
		{
			this.unitsInWin = [];
			this.bin = true;
			WinBattle.units = [[], []];
			this.getMyTeam();
			App.spr.addChild(bgs[0]);
			App.spr.addChild(spr);
			this.addListenersToChekboks(this.chekAvtoboi, 1);
			this.addListenersToChekboks(this.chekLifeBar, 2);
			this.grid.init();
			this.lifeManajer.init();
			this.setCurrStep();
			DataExchange.socket.addEventListener(DataExchangeEvent.BATTLE_MASSAGE, this.onBattleMassage);
			
		 }
		 
		 private function addListenersToChekboks(mc:MovieClip, frame:int, is_add:Boolean = true):void 
		 {
			if (is_add)
			{
				mc.gotoAndStop(frame);
				mc.addEventListener(MouseEvent.MOUSE_OVER, overCheck);
				mc.addEventListener(MouseEvent.MOUSE_OUT, outCheck);
				mc.addEventListener(MouseEvent.CLICK, checkCLick);
				App.spr.addChild(mc);
			}
			else
			{
				mc.removeEventListener(MouseEvent.MOUSE_OVER, overCheck);
				mc.removeEventListener(MouseEvent.MOUSE_OUT, outCheck);
				mc.removeEventListener(MouseEvent.CLICK, checkCLick);
				
			}
		 }
		 
		 public function onBattleMassage(e:DataExchangeEvent):void 
		 {
			var obj:Object = JSON2.decode(e.result);
			Report.addMassage(e.result);
			WinBattle.anim.push(obj);
		 }
		 
		public function makeStep():void
		{
			var obj:Object = anim.shift();
			if (obj.m != null)
			{
				var loc:Object = (obj.m.u.t == 0)?WinBattle.bat.t1_locs[obj.m.u.p]:WinBattle.bat.t2_locs[obj.m.u.p];
				var is_r:Boolean;
				var type:int;
				if (obj.m.u.t == 0)
				{
					 loc = WinBattle.bat.t1_locs[obj.m.u.p];
					 is_r = (WinBattle.bat.t1_u[obj.m.u.p].t_d == 1);
					 type = WinBattle.bat.t1_u[obj.m.u.p].t
				}
				else
				{
					 loc = WinBattle.bat.t2_locs[obj.m.u.p];
					 is_r = (WinBattle.bat.t2_u[obj.m.u.p].t_d == 1);
					 type = WinBattle.bat.t2_u[obj.m.u.p].t;
				}
				var path:Array = WinBattle.inst.grid.findPath(WinBattle.inst.grid.nodes[loc.x][loc.y], WinBattle.inst.grid.nodes[obj.m.x][obj.m.y]);
				WinBattle.inst.mover.init(path, obj, is_r, type);
				Node(this.grid.nodes[loc.x][loc.y]).walcable = 0;
				Node(this.grid.nodes[obj.m.x][obj.m.y]).walcable = 1;
				loc.x = obj.m.x;
				loc.y = obj.m.y;
				bat.cus = obj.n;
			}
			else if(obj.is_w != null)
			{
				this.endBattle(obj)
			}
		}
		
		private function endBattle(obj:Object):void 
		{
			Report.addMassage(JSON2.encode(obj));
			var mc:MovieClip;
			if (obj.is_w)
			{
				mc = WinBattle.winAfterBattle;
				App.sound.playSound('win', App.sound.onVoice, 1);
			}
			else
			{
				mc = WinBattle.looseAfterBattle;
			}
			mc.gotoAndPlay(1);
			App.spr.addChild(mc);
			for (var i:int = 0; i < 4; i++) 
			{
				var blank:mcBlankWinn = mc[String("k" + i)];
				if (UserStaticData.hero.units[i] != null)
				{
					blank.txt1.visible = true;
					blank.txt2.visible = true;
					var unit_data:Object = UserStaticData.hero.units[i];
					var unit:Object = UnitCache.getUnit(Slot.namesUnit[unit_data.t]);
					var living:Boolean = (obj.st[i].d == 0);
					unit.init(blank);
					unit.x = 25; unit.y = 50;
					this.unitsInWin.push(unit);
					blank.txt1.text = "Убито: " + obj.st[i].k;
					if (living) 
					{
						blank.txt2.textColor = 0x62F523; 
						blank.txt2.text = "+" + obj.exp +" опыта";
						unit_data.exp += obj.exp;
					}
					else
					{
						blank.txt2.textColor = 0xF52323 ; 
						blank.txt2.text = "Умер";
						unit_data.l+=obj.st[i].d;
					}
					unit_data.k += obj.st[i].k;
				}
				else
				{
					blank.txt1.visible = false;
					blank.txt2.visible = false;
				}
			}
		}
		
		private function isAlive(ul:Object, user_pos:int):Boolean 
		{
			for (var key:Object in ul)
			{
				if (ul[key] == user_pos)
					return true;
			}
			return false;
		}
		 
		public function setCurrStep():void 
		{
			WinBattle.sortSpr();
			var cus:Object = WinBattle.bat['set'][WinBattle.bat.cus];
			if (currUnit) {currUnit.filters = []; currUnit.shawdow.alpha = 1;} 
			currUnit = WinBattle.units[cus.t][cus.p]; 
			App.btnOverFilter.color = 0xFFFFFF;
			MovieClip(currUnit).filters = [App.btnOverFilter]; currUnit.shawdow.alpha = 0;
			WinBattle.showCurrUnit(cus.t);
			grid.clearNodesControl();
			grid.lightUnits(bat.t1_locs, bat.t1_hp, 0);
			grid.lightUnits(bat.t2_locs, bat.t2_hp, 1);
			if (cus.t == myTeam)
			{
				var loc:Object;
				var r:int;
				var is_arr:int;
				if (myTeam == 0)
				{
					loc = WinBattle.bat.t1_locs[cus.p];
					r = WinBattle.bat.t1_u[cus.p].sp;
					is_arr = WinBattle.bat.t1_u[cus.p].t_d;
				}
				else
				{
					loc = WinBattle.bat.t2_locs[cus.p];
					r = WinBattle.bat.t2_u[cus.p].sp;
					is_arr = WinBattle.bat.t2_u[cus.p].t_d;
				}
				if (WinBattle.anim.length == 0)
				{
					if (this.chekAvtoboi.currentFrame == 1)
					{
						grid.showAvailableCells(loc.x, loc.y, r, is_arr);
					}
					else
					{
						Node(this.grid.nodes[0][0]).sendStep();
					}
				}
			}
			
		 }
		 
		public function update():void
		{
			mover.update();
			effManajer.update();
		}
		
		public function frees():void
		{
			    DataExchange.socket.removeEventListener(DataExchangeEvent.BATTLE_MASSAGE, this.onBattleMassage);
				this.grid.clearNodesControl();
				this.freeUnits(units[0]);
				this.freeUnits(units[1]);
				
				WinBattle.units = null;
				this.lifeManajer.frees();
				WinBattle.atackNode.frees();
				this.grid.frees();
				this.addListenersToChekboks(this.chekAvtoboi, 1, false);
				this.addListenersToChekboks(this.chekLifeBar, 2, false);
			
			    this.mover.unit = null;
				this.mover.cur_obj = null;
				WinBattle.currUnit = null;
				UserStaticData.hero.bat = -1;
				UserStaticData.hero.mbat = null;
				effManajer.frees();
				for (var i:int = 0; i < unitsInWin.length; i++) 
				{
					unitsInWin[i].frees();
				}
				
		}
		
		private function freeUnits(unit:Object):void 
		{
			for (var key:Object in unit)
			{
				if (unit[key] != null)
				{
					unit[key].frees();
					delete(unit[key]);
				}
			}
		}
		 
		private function getMyTeam():void
		{
			myTeam = - 1;
			var id:String = UserStaticData.from + UserStaticData.id;
			if (UserStaticData.hero.bat > -1)
			{WinBattle.bat= UserStaticData.hero.mbat; }
			if (WinBattle.bat.t1_id == id)
			{myTeam = 0;}
			else if (WinBattle.bat.t2_id == id)
			{myTeam = 1;}
		}
		
		public static function showCurrUnit(team_n:int):void
		{
			WinBattle.arrow.x = WinBattle.currUnit.x;
			WinBattle.arrow.y = WinBattle.currUnit.y + WinBattle.currUnit._head.y - WinBattle.currUnit._head.height/2;
			if (WinBattle.myTeam == team_n)
				WinBattle.arrow.mc.gotoAndStop(1);
			else
				WinBattle.arrow.mc.gotoAndStop(2);
			App.spr.addChild(arrow);
			WinBattle.arrow.visible = true; 
			WinBattle.arrow.play();
		}
		 
		static public function sortSpr():void 
		{
			var newArr:Array = sortArr.sortOn('y', Array.NUMERIC);
			for (var j:int = 0; j < newArr.length; j++) 
				spr.addChild(newArr[j]); 
		}
		
	}

}