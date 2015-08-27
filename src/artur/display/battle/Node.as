package artur.display.battle 
{
	import adobe.utils.CustomActions;
	import artur.App;
	import artur.display.RasterMovie;
	import artur.win.WinBattle;
	import flash.display.IBitmapDrawable;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
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
		private static var unit_info_timer:Timer = null;
		private static var unit:Object;
		private static var x_:int = 0;
		private static var y_:int = 0;
		private var is_mouse_over:Boolean = false;
		
		public function Node() 
		{
			this.mouseChildren = false;
		   	txt.width = mc.width;
			txt.height = 40;
			txt.x = - txt.width / 2;
			txt.y = - txt.height / 2;
			txt.alpha = 0.5;
			this.addEventListener(MouseEvent.ROLL_OVER, this.onOver1);
			this.addEventListener(MouseEvent.ROLL_OVER, this.onOver2);
			this.addEventListener(MouseEvent.ROLL_OUT, this.onOut2);
			this.addEventListener(MouseEvent.ROLL_OUT, this.onOut1);
			if (unit_info_timer == null)
			{
				Node.unit_info_timer = new Timer(1000);
				Node.unit_info_timer.addEventListener(TimerEvent.TIMER, Node.onInfoTimer);
			}
		}
		
		private function onOut2(e:MouseEvent):void 
		{
			this.is_mouse_over = false;
		}
		
		private function onOver2(e:MouseEvent):void 
		{
			this.is_mouse_over = true;
		}
		
		private static function onInfoTimer(e:TimerEvent):void 
		{
			Node.unit_info_timer.stop();
			WinBattle.hero_inv.init1(unit, false, Node.x_, Node.y_);
		}
		public function init(xp:int,yp:int,walcable:int):void
		{
			this.is_mouse_over = false;
			this.addChild(mc); 
			this.mc.gotoAndStop(1);
			this.xp = xp; this.yp = yp;
			this.x = xp*this.width + 44 +(yp%2)*int(this.width/2);
			this.y = yp*49 + 80;
			this.walcable = walcable;
			this.mc.visible = (walcable == 0 || walcable == 1)
			this.txt.text = xp.toString() + ":" + yp.toString();
			this.addChild(this.txt);
			WinBattle.spr.addChild(this);
			if (!mc.visible) 
			{
				var st:RasterMovie = BattleGrid.getStone();
				st.gotoAndStop(1);
				WinBattle.spr.addChild(st);
				st.x = this.x; st.y = this.y;
				WinBattle.sortArr.push(st);
			}
		}
		
		public function onOut1(e:MouseEvent = null):void 
		{
			WinBattle.hero_inv.frees();
			if (Node.unit_info_timer.running)
			{
				Node.unit_info_timer.stop();
			}
		}
		
		public function onOver1(e:MouseEvent = null):void 
		{
			if (this.walcable == 1)
			{
				var key:Object;
				var unit_local:Object;
				for (key in WinBattle.bat.t1_locs)
				{
					if (WinBattle.bat.t1_locs[key].x == this.xp && WinBattle.bat.t1_locs[key].y == this.yp)
					{
						unit_local = WinBattle.bat.t1_u[key];
						break;
					}
				}
				if (unit_local == null)
				{
					for (key in WinBattle.bat.t2_locs)
					{
						if (WinBattle.bat.t2_locs[key].x == this.xp && WinBattle.bat.t2_locs[key].y == this.yp)
						{
							unit_local = WinBattle.bat.t2_u[key];
							break;
						}
					}
				}
				if (unit_local != null)
				{
					Node.unit = unit_local;
					Node.unit_info_timer.start();
					Node.x_ = (this.x < 410)?this.x + 30:this.x - WinBattle.hero_inv.width + this.width / 2;
					Node.y_ = (this.y < 200)? this.y - 50:120;
				}
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
			this.addEventListener(MouseEvent.ROLL_OVER, onOver);
			this.addEventListener(MouseEvent.ROLL_OUT, onOut);
		}
		
		public function setAttack():void
		{
			this.cur_fr = 6;
			this.mc.gotoAndStop(this.cur_fr);
			this.addEventListener(MouseEvent.ROLL_OVER, onOver);
			if (this.is_mouse_over)
			{
					this.onOver();
			}
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
		
		public function onOut(e:MouseEvent = null):void 
		{
			this.mc.gotoAndStop(cur_fr);
			this.is_mouse_over = false;
		}
		
		private function onOver(e:MouseEvent = null):void 
		{
			if (cur_fr == 6)
			{
				if (WinBattle.atackNode.currNode != this)
					WinBattle.atackNode.init(this);
			}
			this.mc.gotoAndStop(3);
			this.is_mouse_over = true;
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
			if (this.hasEventListener(MouseEvent.ROLL_OVER))
			{
				this.removeEventListener(MouseEvent.CLICK, moveNode);
				this.removeEventListener(MouseEvent.ROLL_OUT, onOut);
				this.removeEventListener(MouseEvent.ROLL_OVER, onOver);
				this.buttonMode = false;
			}
			this.mc.gotoAndStop(1);
			this.onOut1();
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
		
		public function makeUlt():void 
		{
			this.buttonMode = true;
			this.mc.gotoAndStop(2);
			this.addEventListener(MouseEvent.CLICK, onUltClick);
		}
		
		public function dismakeUlt():void 
		{
			this.buttonMode = false;
			this.mc.gotoAndStop(1);
			this.removeEventListener(MouseEvent.CLICK, onUltClick);
		}
		
		private function onUltClick(e:MouseEvent):void 
		{
			var key:int;
			var bat:Object = WinBattle.bat;
			for (var i:int = 0; i < 4; i ++ )
			{
				if (bat.t1_locs[i] != null && bat.t1_hp[i] > 0)
				{
					Node(WinBattle.inst.grid.nodes[bat.t1_locs[i].x][bat.t1_locs[i].y]).dismakeUlt()
					if (bat.t1_locs[i].x == this.xp && bat.t1_locs[i].y == this.yp)
					{
						key = i;
					}
				}
				
				if (bat.t2_locs[i] != null && bat.t2_hp[i] > 0)
				{
					Node(WinBattle.inst.grid.nodes[bat.t2_locs[i].x][bat.t2_locs[i].y]).dismakeUlt()
					if (bat.t2_locs[i].x == this.xp && bat.t2_locs[i].y == this.yp)
					{
						key = i;
					}
				}
			}
			WinBattle.makeUltimate(key);
		}
		
	}

}