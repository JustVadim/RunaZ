package artur.display.battle 
{
	import artur.App;
	import artur.win.WinBattle;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import report.Report;
	
	public class AttackNode extends AtackNode
	{
		private var mouseClip:MouseAtackNode = new MouseAtackNode();
		public var currNode:Node;
		public var neib_nodes:Array;
		public var grid:Array;
		public var is_arrow:int
		public var h_x:int;
		public var h_y:int;
		public var ax:int;
		public var ay:int;
		
		public function AttackNode() 
		{
			var objs:Array = [null, b1, b2, b3, b4, b5, b6];
			for (var i:int = 1; i < objs.length; i++) 
			{
				objs[i].addEventListener(MouseEvent.ROLL_OVER, over);
				objs[i].addEventListener(MouseEvent.CLICK, click);
				objs[i].addEventListener(MouseEvent.ROLL_OUT, out);
				objs[i].buttonMode = true;
			}
			this.mouseClip.gotoAndStop(1);
			this.mouseClip.mouseChildren = false;
			this.mouseClip.mouseEnabled = false;
			this.alpha = 0;
			this.grid = WinBattle.inst.grid.nodes;
			this.buttonMode = true;
		}
		
		private function over(e:MouseEvent):void 
		{
			App.spr.addChild(mouseClip);
			if (is_arrow == 0)
			{
				var f:int = int(String(e.currentTarget.name).charAt(1));
				var neib_x:int;
				var neib_y:int;
				var node_dy:int = currNode.yp % 2;
				switch(f)
				{
					case 1:
						neib_x = currNode.xp + node_dy;
						neib_y = currNode.yp + 1;
						break;
					case 2:
						neib_x = currNode.xp + node_dy - 1;
						neib_y = currNode.yp + 1;
						break;
					case 3:
						neib_x = currNode.xp - 1;
						neib_y = currNode.yp;
						break;
					case 4:
						neib_x = currNode.xp - 1 + node_dy;
						neib_y = currNode.yp - 1;
						break;
					case 5:
						neib_x = currNode.xp + node_dy;
						neib_y = currNode.yp - 1;
						break;
					case 6:
						neib_x = currNode.xp + 1;
						neib_y = currNode.yp;
						break;
				}
				mouseClip.gotoAndStop(f);
				if (neib_nodes[neib_x] != null && neib_nodes[neib_x][neib_y] != null)
				{
					mouseClip.denie.visible = false;
					this.ax = neib_x;
					this.ay = neib_y;
				}
				else
					mouseClip.denie.visible = true
			}
			else
			{
				if (BattleGrid.getDistance(h_x, h_y, currNode.xp, currNode.yp) < 7)
					mouseClip.gotoAndStop(7);
				else
					mouseClip.gotoAndStop(8);
			}
			this.currNode.onOver1();
			this.currNode.mc.gotoAndStop(3);
			
		}
	    private function click(e:MouseEvent):void 
		{
			var obj:Object;
			if (this.is_arrow == 1 || (this.is_arrow == 0 && !mouseClip.denie.visible))
			{
				if(this.is_arrow == 0)
					obj = { x:this.ax, y:this.ay, ax:currNode.xp, ay:currNode.yp, a:1 };
				else
					obj = { x:this.h_x, y:this.h_y, ax:currNode.xp, ay:currNode.yp, a:1 };
				this.currNode.onOut1();
				currNode.sendStep(obj);
				this.frees();
			}
		}
	    
		private function out(e:MouseEvent):void 
		{
			Mouse.show();
			if (App.spr.contains(mouseClip)) 
				App.spr.removeChild(mouseClip)
			if (this.currNode != null)
			{
				this.currNode.onOut1();
				this.currNode.onOut();
			}	
		}
		public function init(currNode:Node):void
		{
			this.x = currNode.x;
			this.y = currNode.y;
			this.currNode = currNode;
			App.spr.addChild(this);
			mouseClip.x = this.x;
			mouseClip.y = this.y;
			var bat:Object = WinBattle.bat;
			var pos:int = bat["set"][bat.cus].p;
			this.initHeroVars(bat.u[WinBattle.myTeam][pos], bat.locs[WinBattle.myTeam][pos]);
			if (is_arrow == 0)
			{
				this.neib_nodes = new Array();
				var node_dy:int = currNode.yp % 2;
				this.addNode(currNode.xp - 1, currNode.yp);
				this.addNode(currNode.xp + 1, currNode.yp);
				this.addNode(currNode.xp - 1 + node_dy, currNode.yp - 1);
				this.addNode(currNode.xp + node_dy, currNode.yp - 1);
				this.addNode(currNode.xp - 1 + node_dy, currNode.yp + 1);
				this.addNode(currNode.xp + node_dy, currNode.yp + 1);
			}
		}
		
		private function initHeroVars(t_u:Object, t_locs:Object):void 
		{
			this.is_arrow = t_u.t_d;
			this.h_x = t_locs.x;
			this.h_y = t_locs.y;
		}
		
		private function addNode(xx:int, yy:int):void 
		{
			if (BattleGrid.isInMap(xx, yy) && (Node(this.grid[xx][yy]).mc.currentFrame == 2 || (xx ==  h_x && yy == h_y)))
			{
				if (this.neib_nodes[xx] == null)
					this.neib_nodes[xx] = new Array();
				neib_nodes[xx][yy] = Node(this.grid[xx][yy]);
			}	
		}
		public function frees():void
		{
			if(parent)
				this.parent.removeChild(this)
			if (App.spr.contains(mouseClip)) 
				App.spr.removeChild(mouseClip)
			this.currNode = null;
			for (var key:Object in neib_nodes)
			{
				delete(neib_nodes[key]);
			}
			Mouse.show();
		}
		
		
	}

}