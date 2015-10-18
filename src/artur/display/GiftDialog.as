package artur.display 
{
	import artur.App;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Som911
	 */
	public class GiftDialog extends dialogGift
	{
		private var btn:BaseButton = new BaseButton(33);
		private var mc:mcGifts = new mcGifts();
		public function GiftDialog() 
		{
			this.addChild(btn);
			btn.x = 410.15; btn.y = 347.15;
			btn.addEventListener(MouseEvent.CLICK, obBtnTakes);
			mc.x = 411.15; mc.y = 284.3;
			this.addChild(mc);
		}
		public function init(frameGift:int,text:String=''):void
		{
			App.spr.addChild(this);
			mc.gotoAndStop(frameGift);
			this.txt.text = text;
		}
	
		private function obBtnTakes(e:MouseEvent):void 
		{
			
		}
		
	}

}