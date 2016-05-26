package artur.display {
	import Utils.Functions;
	import adobe.utils.CustomActions;
	import artur.PrepareGr;
	import artur.RasterClip;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.text.engine.Kerning;
	
	public class KyzStone extends Sprite {
		private static var vector:MovieClip = new KyzStones();
		private var id:int;
		private var getBtn:BaseButton;
		private var askFriend:BaseButton;
		private var sendToCrafter:BaseButton;
		private var text:TextField;
		
		public function KyzStone(id:int, xx:Number, yy:Number) {
			var bm:Bitmap = RasterClip.getMovedBitmap(new KyzStones(), id);
			this.addChild(bm);
			this.x = xx;
			this.y = yy;
			this.tabEnabled = false;
			this.tabChildren = false;
			this.id = id;
			this.buttonMode = true;
			this.getBtn = new BaseButton(69);
			this.addChild(getBtn);
			this.getBtn.x = -40.5;
			this.getBtn.y = 0;
			this.askFriend = new BaseButton(70);
			this.askFriend.x = -40.5 - getBtn.width - 5;
			this.addChild(this.askFriend);
			this.sendToCrafter = new BaseButton(41);
			this.sendToCrafter.x = 125;
			this.sendToCrafter.y = 0;
			this.addChild(this.sendToCrafter);
			this.text = Functions.getTitledTextfield(20, -10, 85, 25, new Art().fontName, 18, 0xFFFFFF, TextFormatAlign.CENTER, "12", 1, Kerning.ON, 1, true);
			this.text.filters = [new GlowFilter(0x0, 1, 3, 3)];
			this.addChild(text);
		}
		
	}
}