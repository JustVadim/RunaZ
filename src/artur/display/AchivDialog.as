package artur.display  {
	import artur.App;
	import flash.events.MouseEvent;
	
	
	public class AchivDialog extends dialogAchiv {
		private var btn:BaseButton = new BaseButton(33);
		
		
		public function AchivDialog()  {
			this.addChild(btn);
			btn.x = 400; btn.y = 375;
			//btn.addEventListener(MouseEvent.CLICK, hanler);
			stop();
		}
	
		public function init(frameGift:int, text:String = ""):void {
			App.spr.addChild(this);
	        this.gotoAndStop(frameGift);
			App.sound.playSound('achiv', App.sound.onVoice, 1);
		}
		
		
	}

}