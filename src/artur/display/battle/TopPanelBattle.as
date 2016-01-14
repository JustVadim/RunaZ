package artur.display.battle {
	import artur.App;
	import artur.PrepareGr;
	import artur.win.WinBattle;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.PerspectiveProjection;
	import report.Report;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Utils.json.JSON2;
	
	public class TopPanelBattle extends Sprite {
		private var bg:Bitmap  = PrepareGr.creatBms(new mcBgTopPanelBatle(), false)[0];
		private var bmAutoFight :Bitmap = PrepareGr.creatBms(new mcActiveAuto(), false)[0];
		private var bmHold        :Bitmap = PrepareGr.creatBms(new mcBtnsTopPanelBattle(), false)[0];
		private var mcBtns:mcBtnTopPanelBatle = new mcBtnTopPanelBatle();
		
		private var winBattle:WinBattle;
		
		public function TopPanelBattle(winBattle:WinBattle) {
			this.winBattle = winBattle;
			this.tabEnabled = this.mouseEnabled = this.tabChildren = false;
			this.x = 400;
			this.addChild(bg);
			this.addChild(bmAutoFight);
			this.addChild(bmHold);
			this.addChild(mcBtns);
			for (var i:int = 0; i < mcBtns.numChildren; i++) {
				var mc:MovieClip = MovieClip(this.mcBtns.getChildAt(i));
				mc.buttonMode = true;
				mc.mouseChildren = mc.tabEnabled = mc.tabChildren = false;
			}
			mcBtns.over.mouseChildren = mcBtns.over.mouseEnabled = false;
			mcBtns.over.gotoAndStop(1);
			this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
			this.bmAutoFight.visible = true;
		}
		
		private function onAddedToStage(e:Event):void {	
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
			this.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
			for (var i:int = 0; i < mcBtns.numChildren; i++) {
				this.btnsEventsAdd(MovieClip(this.mcBtns.getChildAt(i)));
			}
		}
		
		private function onRemovedFromStage(e:Event):void {
			this.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
			this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
			for (var i:int = 0; i < mcBtns.numChildren; i++) {
				this.btnsEventsRemove(MovieClip(this.mcBtns.getChildAt(i)));
			}
		}
		
		private function btnsEventsAdd(mc:MovieClip):void {
			mc.addEventListener(MouseEvent.CLICK, this.onBtn);
			mc.addEventListener(MouseEvent.ROLL_OVER, this.over);
			mc.addEventListener(MouseEvent.ROLL_OUT, this.out);
			mc.addEventListener(MouseEvent.MOUSE_DOWN, this.down);
			mc.addEventListener(MouseEvent.MOUSE_UP, this.up);
		}
		
		private function btnsEventsRemove(mc:MovieClip):void {
			mc.removeEventListener(MouseEvent.CLICK, this.onBtn);
			mc.removeEventListener(MouseEvent.ROLL_OVER, this.over);
			mc.removeEventListener(MouseEvent.ROLL_OUT, this.out);
			mc.removeEventListener(MouseEvent.MOUSE_DOWN, this.down);
			mc.removeEventListener(MouseEvent.MOUSE_UP, this.up);
		}
		
		public function init():void 
		{
			App.spr.addChild(this);
			this.mcBtns.over.gotoAndStop(1);
			this.bmAutoFight.visible = false;
			this.bmHold.visible = true;
			this.btnsEventsAdd(this.mcBtns.btnFree);
		}
		
		private function up(e:MouseEvent):void {
			mcBtns.over.gotoAndStop(1);
		}
		
		private function down(e:MouseEvent):void {
			mcBtns.over.gotoAndStop(2);
		}
	
		private function out(e:MouseEvent):void {
			mcBtns.over.y = -200;
			mcBtns.over.gotoAndStop(1);
			App.info.frees();
		}
		
		private function over(e:MouseEvent):void {
			App.sound.playSound('over1', App.sound.onVoice, 1);
			var mc:MovieClip = MovieClip(e.target);
			this.mcBtns.over.x = mc.x;
			this.mcBtns.over.y = mc.y;
			var tetx:String;
			switch(mc) {
				case this.mcBtns.btnHold:
					tetx = "Удерживание";
					break;
				case this.mcBtns.btnAuto:
					tetx = "Автобой";
					break;
				case this.mcBtns.btnFree:
					tetx = "Сдаться";
					break;
			
			}
			App.info.init(mc.x + this.x + 40, mc.y + 60, { txtInfo_w:110, txtInfo_h:37, txtInfo_t:tetx, type:0 } );
		}
		
		public function isAuto():Boolean {
			return this.bmAutoFight.visible;
		}
		
		private function onBtn(e:MouseEvent):void {
			App.info.frees();
			App.sound.playSound('click1', App.sound.onVoice, 1);
			var mc:MovieClip = MovieClip(e.target);
			switch(mc) {
				case this.mcBtns.btnHold:
					WinBattle.inst.grid.clearNodesControl();
					var loc:Object = WinBattle.bat.locs[WinBattle.myTeam][WinBattle.bat["set"][WinBattle.bat.cus].p];
					var obj:Object = new Object();
					obj.a = 0;
					obj.x = loc.x;
					obj.y = loc.y;
					WinBattle.atackNode.frees();
					Node(winBattle.grid.nodes[0][0]).sendStep(obj);//this.sendStep(obj);
					break;
				case this.mcBtns.btnAuto:
					this.bmAutoFight.visible = !this.bmAutoFight.visible;
					this.mcBtns.btnHold.visible = false;
					this.bmHold.visible = false;
					if (bmAutoFight.visible && this.isOurStep()) {
						Node(this.winBattle.grid.nodes[0][0]).sendStep();
						return
					}
					break;
				case this.mcBtns.btnFree:
					App.lock.init();
					var data:DataExchange = new DataExchange();
					data.addEventListener(DataExchangeEvent.ON_RESULT, this.onSurrenderRes);
					data.sendData(COMMANDS.SURRENDER, "", true);
					this.btnsEventsRemove(this.mcBtns.btnFree);
					this.out(e);
					break;
			
			}
			
		}
		
		private function onSurrenderRes(e:DataExchangeEvent):void {
			DataExchange(e.target).removeEventListener(e.type, this.onSurrenderRes);
			var res:Object = JSON2.decode(e.result);
			App.lock.frees();
		}
		
		private function isOurStep():Boolean {
			return WinBattle.bat['set'][WinBattle.bat.cus].t == WinBattle.myTeam && WinBattle.anim.length == 0;
		}
		
		public function setDefence(state:Boolean):void  {
			if (!this.isAuto()) {
				this.mcBtns.btnHold.visible = state;
				this.bmHold.visible = state;
			}
		}
	}

}