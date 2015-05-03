package artur.display.battle 
{
	import adobe.utils.CustomActions;
	import artur.App;
	import artur.display.RasterMovie;
	import artur.win.WinBattle;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import report.Report;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Utils.json.JSON2;
	
	public class Node extends Sprite
	{
		 public var xp:uint;
		 public var yp:uint;
		 public var walcable:int;
		 public var mc:mcNode = new mcNode();
		 private var txt:TextField = new TextField();
		 private var cur_fr:int;
		 
		 public var rad:int;
		 public var checked:Boolean;
		 
		public function Node() 
		{
			this.mouseChildren = false;
		   	txt.width = mc.width;
			txt.height = 40;
			//this.addChild(txt);
			txt.x = - txt.width / 2;
			txt.y = - txt.height / 2;
			txt.alpha = 0.5;
		}
		public function init(xp:int,yp:int,walcable:int):void
		{
			this.addChild(mc); mc.gotoAndStop(1);
			this.xp = xp; this.yp = yp;
			this.x = xp*this.width + 44 +(yp%2)*int(this.width/2);
			this.y = yp*49 + 80;
			this.walcable = walcable;
			mc.visible = (walcable == 0||walcable ==1)
			WinBattle.spr.addChild(this);
			txt.text = String('xp:' + xp + '\n yp:' + yp)
			if (!mc.visible) 
			{
				var st:RasterMovie = BattleGrid.getStone();
				st.gotoAndStop(1);
				WinBattle.spr.addChild(st);
				st.x = this.x; st.y = this.y;
				WinBattle.sortArr.push(st);
			}
			this.addEventListener(MouseEvent.MOUSE_OVER, this.onOver1);
			this.addEventListener(MouseEvent.MOUSE_OUT, this.onOut1);
		}
		
		private function onOut1(e:MouseEvent):void 
		{
			WinBattle.hero_inv.frees();
		}
		
		private function onOver1(e:MouseEvent):void 
		{
				var key:Object;
				var unit:Object;
				for (key in WinBattle.bat.t1_locs)
				{
					if (WinBattle.bat.t1_locs[key].x == this.xp && WinBattle.bat.t1_locs[key].y == this.yp)
					{
						unit = WinBattle.bat.t1_u[key];
						break;
					}
				}
				if (unit == null && String(WinBattle.bat.t2_id).substr(0,3)!="bot")
				{
					for (key in WinBattle.bat.t2_locs)
					{
						if (WinBattle.bat.t2_locs[key].x == this.xp && WinBattle.bat.t2_locs[key].y == this.yp)
						{
							unit = WinBattle.bat.t2_u[key];
							break;
						}
					}
				}
				if (unit != null)
				{
					Report.addMassage(unit);
					WinBattle.hero_inv.init1(unit);
				}
		}
		
		public function frees():void
		{
			WinBattle.spr.removeChild(this);
			this.removeEventListener(MouseEvent.CLICK, moveNode);
			this.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
			this.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
		}
		public function setMove():void
		{
			this.buttonMode = true;
			this.cur_fr = int(2);
			this.mc.gotoAndStop(cur_fr);
			this.addEventListener(MouseEvent.CLICK, moveNode);
			this.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onOut);
		}
		
		public function setAttack():void
		{
			this.mc.gotoAndStop(this.cur_fr = 6);
			this.addEventListener(MouseEvent.MOUSE_OVER, onOver);
		}
		
		private function moveNode(e:MouseEvent):void 
		{
			WinBattle.inst.grid.clearNodesControl();
			var obj:Object = new Object();
			obj.a = 0;
			obj.x = this.xp;
			obj.y = this.yp;
			WinBattle.atackNode.frees();
			this.sendStep(obj);
		}
		
		private function onOut(e:MouseEvent):void 
		{
			this.mc.gotoAndStop(cur_fr);
		}
		
		private function onOver(e:MouseEvent):void 
		{
			if (cur_fr == 6)
			{
				if (WinBattle.atackNode.currNode != this)
					WinBattle.atackNode.init(this);
			}
			this.mc.gotoAndStop(3);
		}
		
		public function sendStep(obj:Object = null):void 
		{
			WinBattle.arrow.visible = false; WinBattle.arrow.stop();
			WinBattle.inst.grid.clearNodesControl();
			App.lock.init();
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, getRess);
			var str:String;
			if (obj != null) str = JSON2.encode(obj);
			else str = "";
			if (UserStaticData.hero.bat > -1)
			{
				if(UserStaticData.hero.bat < 1000)
					data.sendData(COMMANDS.SEND_MISS_STEP, str, true);
				else
					data.sendData(COMMANDS.BATTLE_STEP, str, true);
			}
		}
		
		private function getRess(e:DataExchangeEvent):void 
		{
			DataExchange(e.target).removeEventListener(e.type, getRess);
			var obj:Object = JSON2.decode(e.result);
			if (obj.error== null) 
			{
				App.lock.frees();
			}
			else
			{
				App.lock.init(obj.error);
			}
		}
		public function clearControl():void
		{
			if (this.walcable == 0 || this.walcable ==1) 
			{
				if (this.hasEventListener(MouseEvent.CLICK))
				{
					this.removeEventListener(MouseEvent.CLICK, moveNode);
					this.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
					this.buttonMode = false;
				}
				this.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
				this.mc.gotoAndStop(1);
			}
		}
		
		
		
		public function resetFP():void
		{
			this.checked = false;
			this.rad = 1000;
		}
		
		public function setRadius(radius:int):void 
		{
			if (this.rad > radius)
			{
				this.rad = radius;
			}
		}
		
	}

}