package artur.display.battle {
	import Utils.Functions;
	import artur.App;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	public class BattleTimer extends Sprite {
		
		private var textText:TextField   = Functions.getTitledTextfield(-25, -19, 50, 35, new Art().fontName, 25, 0xFFFFFF, TextFormatAlign.CENTER, "32", 0.9);
		private var timerMc:mcTimer = new mcTimer();
		private var curTime:Number = 0;
		private var timer:Timer = new Timer(250);
		
		public function BattleTimer() {
			Functions.SetPriteAtributs(this, false, false, 255, 25);
			this.timerMc.stop();
			this.scaleX = this.scaleY = 0.7;
			this.addChild(this.timerMc = new mcTimer)
			this.addChild(this.textText);
			this.timer.addEventListener(TimerEvent.TIMER, this.onTIc);
		}
		
		private function onTIc(e:TimerEvent):void {
			if(curTime > 0.25) {
				curTime-= 0.25;
			} else {
				curTime = 0;
			}
			this.textText.text = int(curTime) < 10? "0" + int(curTime):int(curTime).toString();
			this.timerMc.gotoAndStop(101 - int(int(curTime) * 101 / 30));
		}
		
		public function init():void {
			App.spr.addChild(this);
			this.timer.start();
		}
		
		public function setTimer(time:int):void 
		{
			this.curTime = time;
		}
		
		public function frees():void 
		{
			if(this.parent) {
				this.parent.removeChild(this);
				this.timer.stop();
			}
		}
	}
}