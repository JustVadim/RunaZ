package artur.display  {
	import artur.App;
	import flash.events.MouseEvent;
	
	
	public class GiftDialog extends dialogGift {
		private var btn:BaseButton = new BaseButton(33);
		private var mc:mcGifts = new mcGifts();
		
		public function GiftDialog(hanler:Function)  {
			this.addChild(btn);
			btn.x = 410.15; btn.y = 347.15;
			btn.addEventListener(MouseEvent.CLICK, hanler);
			mc.x = 411.15; mc.y = 284.3;
			this.addChild(mc);
		}
	
		public function init(frameGift:int, text:String = ""):void {
			App.spr.addChild(this);
			if (frameGift == -1) {
				if (mc.visible) {
					mc.visible = false;
				}
				//this.txt.text = text;
			} else {
				if(!mc.visible) {
					mc.visible = true;
				}
				mc.gotoAndStop(frameGift);
			}
		}
		
		
	}

}