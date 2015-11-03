package artur.display.battle {
	import artur.App;
	import artur.PrepareGr;
	import artur.win.WinBattle;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class TopPanelBattle extends Sprite {
		private var bg:Bitmap  = PrepareGr.creatBms(new mcBgTopPanelBatle(), false)[0];
		private var bmActive:Bitmap = PrepareGr.creatBms(new mcActiveAuto(), false)[0];
		private var bmActive2:Bitmap = PrepareGr.creatBms(new mcBtnsTopPanelBattle(), false)[0];
		private var mcBtns:mcBtnTopPanelBatle = new mcBtnTopPanelBatle();
		
		private var winBattle:WinBattle;
		
		public function TopPanelBattle(winBattle:WinBattle) {
			this.winBattle = winBattle;
			this.tabEnabled = this.mouseEnabled = this.tabChildren = false;
			this.x = 400;
			this.addChild(bg);
			this.addChild(bmActive);
			this.addChild(bmActive2);
			this.addChild(mcBtns);
			for (var i:int = 0; i < mcBtns.numChildren; i++) {
				var mc:MovieClip = MovieClip(this.mcBtns.getChildAt(i));
				mc.buttonMode = true;
				mc.mouseChildren = mc.tabEnabled = mc.tabChildren = false;
			}
			mcBtns.over.mouseChildren = mcBtns.over.mouseEnabled = false;
			mcBtns.over.gotoAndStop(1);
			this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
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
		
		public function init():void {
			App.spr.addChild(this);
			this.mcBtns.over.gotoAndStop(1);
			this.bmActive.visible = false;
			this.bmActive2.visible = this.mcBtns.btnFree.visible = this.mcBtns.btnHold.visible = false;
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
			return this.bmActive.visible;
		}
		
		private function onBtn(e:MouseEvent):void {
			App.sound.playSound('click1', App.sound.onVoice, 1);
			var mc:MovieClip = MovieClip(e.target);
			switch(mc) {
				case this.mcBtns.btnHold:
					break;
				case this.mcBtns.btnAuto:
					bmActive.visible = !bmActive.visible;
					if (bmActive.visible && this.isOurStep()) {
						Node(this.winBattle.grid.nodes[0][0]).sendStep();
						return
					}
					this.setDefence(this.isOurStep());
					break;
				case this.mcBtns.btnFree:
					break;
			
			}
			
		}
		
		private function isOurStep():Boolean {
			return WinBattle.bat['set'][WinBattle.bat.cus].t == WinBattle.myTeam && WinBattle.anim.length == 0;
		}
		
		private function setDefence(state:Boolean):void  {
			if(this.isAuto()) {
				mcBtns.btnHold.visible = state;
			}
		}
	}

}