package artur.display 
{
	import artur.App;
	import flash.display.MovieClip;
	import flash.display.StageDisplayState;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import report.Report;
	import Utils.Functions;
	public class PropExtended extends mcProperties {
		
		public function PropExtended() {
			Functions.SetPriteAtributs(this, false, true, 0, 0);
			this.setBtn(this.full);
			this.setBtn(this.muz);
			this.setBtn(this.sound);
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
			switch(mc) {
				case this.full:
					if(mc.currentFrame == 2) {
						stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
					} else {
						stage.displayState = StageDisplayState.NORMAL;
					}
					break;
				case this.muz:
					break;
				case this.sound:
					App.sound.onVoice = (mc.currentFrame==2)?0:0.6
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
			
		}
		
		private function onOver(e:MouseEvent):void {
			var mc:MovieClip = MovieClip(e.target);
			mc.scaleX = mc.scaleY = 0.75;
		}
	}

}