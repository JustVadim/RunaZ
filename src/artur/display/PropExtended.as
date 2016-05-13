package artur.display 
{
	import artur.App;
	import flash.display.MovieClip;
	import flash.display.StageDisplayState;
	import flash.events.FullScreenEvent;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import report.Report;
	import Server.Lang;
	import Utils.Functions;
	public class PropExtended extends mcProperties {
		
		public function PropExtended() {
			Functions.SetPriteAtributs(this, false, true, 0, 0);
			if (UserStaticData.data.data.s == null) {
				UserStaticData.data.data.s = true;
				UserStaticData.data.data.m = true;
				UserStaticData.data.flush();
			}
			this.setBtn(this.full);
			this.setBtn(this.muz);
			this.setBtn(this.sound);
			Report.addMassage(JSON.stringify(UserStaticData.data.data));
			if (!UserStaticData.data.data.s) {
				this.sound.gotoAndStop(2);
				App.sound.onVoice = 0;
			}
			if(!UserStaticData.data.data.m) {
				this.muz.gotoAndStop(2);
				App.sound.onSound = 0;
			}
			
			Main.THIS.stage.addEventListener(FullScreenEvent.FULL_SCREEN, onFull);
		}
		
		private function onFull(e:FullScreenEvent):void 
		{
			if(stage.displayState == StageDisplayState.NORMAL && this.full.currentFrame != 1){
				this.full.gotoAndStop(1);
			}
		}
		
		private function setBtn(mc:MovieClip):void {
			mc.gotoAndStop(1);
			mc.buttonMode = true;
			mc.addEventListener(MouseEvent.ROLL_OVER, this.onOver);
			mc.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
			mc.addEventListener(MouseEvent.MOUSE_DOWN, this.onDown);
			mc.addEventListener(MouseEvent.MOUSE_UP, this.onUp);
			mc.addEventListener(MouseEvent.CLICK, this.onCick);
			Functions.SetPriteAtributs(mc, true, false);
		}
		
		private function onCick(e:MouseEvent):void {
			var mc:MovieClip = MovieClip(e.target);
			if (mc.currentFrame == 1) {
				mc.gotoAndStop(2);
			} else {
				mc.gotoAndStop(1);
			}
			App.info.frees();
			switch(mc) {
				case this.full:
					if(mc.currentFrame == 2) {
						stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
					} else {
						stage.displayState = StageDisplayState.NORMAL;
					}
					break;
				case this.muz:
					if (mc.currentFrame == 2) {
						App.sound.stopSound(App.currMuzPlay);
						App.sound.onSound = 0;
						UserStaticData.data.data.m = false;
						
					} else {
						App.sound.onSound = 0.4;
						App.sound.playSound(App.currMuzPlay, App.sound.onSound);
						UserStaticData.data.data.m = true;
					}
					UserStaticData.data.flush();
					break;
				case this.sound:
					if(mc.currentFrame == 2) {
						App.sound.onVoice = 0;
						UserStaticData.data.data.s = false;
					} else {
						App.sound.onVoice = 0.6;
						UserStaticData.data.data.s = true;
					}
					UserStaticData.data.flush();
					break;
			}
		}
		
		private function onUp(e:MouseEvent):void 
		{
			var mc:MovieClip = MovieClip(e.target);
			mc.filters = [];
		}
		
		private function onDown(e:MouseEvent):void 
		{
			var mc:MovieClip = MovieClip(e.target);
			mc.filters = [new GlowFilter(0xFFFFFF)];
		}
		
		
		private function onOut(e:MouseEvent):void {
			var mc:MovieClip = MovieClip(e.target);
			mc.scaleX = mc.scaleY = 0.684;
			this.onUp(e);
			App.info.frees();
		}
		
		private function onOver(e:MouseEvent):void {
			var mc:MovieClip = MovieClip(e.target);
			mc.scaleX = mc.scaleY = 0.75;
			App.sound.playSound("over1", App.sound.onVoice, 1);
			var yy:int
			if(this.y == 0) {
				yy = mc.y - mc.height;
			} else {
				yy = this.y + mc.y + mc.height + 15;
			}
			switch(mc) {
				case this.muz:
					if(this.muz.currentFrame == 1) {
						App.info.init(mc.x - 150, yy, { txtInfo_w:150, txtInfo_h:37, txtInfo_t:Lang.getTitle(88), type:0 } );
					} else {
						App.info.init(mc.x - 150, yy, { txtInfo_w:150, txtInfo_h:37, txtInfo_t:Lang.getTitle(89), type:0 } );
					}
					break;
				case this.sound:
					if(this.muz.currentFrame == 1) {
						App.info.init(mc.x - 150, yy, { txtInfo_w:150, txtInfo_h:37, txtInfo_t:Lang.getTitle(90), type:0 } );
					} else {
						App.info.init(mc.x - 150, yy, { txtInfo_w:150, txtInfo_h:37, txtInfo_t:Lang.getTitle(91), type:0 } );
					}
					break;
				case this.full:
					if(this.muz.currentFrame == 1) {
						App.info.init(mc.x - 150, yy, { txtInfo_w:150, txtInfo_h:37, txtInfo_t:Lang.getTitle(92), type:0 } );
					} else {
						App.info.init(mc.x - 150, yy, { txtInfo_w:150, txtInfo_h:37, txtInfo_t:Lang.getTitle(93), type:0 } );
					}
					break;
			}
		}
	}

}