package artur.display 
{
	import artur.App;
	import artur.RasterClip;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Som911
	 */
	public class SprVip extends Sprite
	{
		private var bg:Bitmap = RasterClip.getBitmap(new mcWinVip());
		private var btnClose:BaseButton 
		private var btnBye:BaseButton
		public function SprVip() 
		{
			this.addChild(bg);
			btnClose = new BaseButton(87);
			btnBye = new BaseButton(88);
			this.addChild(btnClose);
			this.addChild(btnBye);
			btnClose.x = 687.5;
			btnClose.y = 49.65;
			btnBye.x  = 418.5;
			btnBye.y = 403.7;
		}
		public function init():void
		{
			App.spr.addChild(this);
		}
		public function frees():void
		{
			App.spr.removeChild(this);
		}
		
	}

}