package artur 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	
	public class RasterClip  {	
		private static var bmd:BitmapData
		public static var scaleFactor:Number = 2;
		private static var drawSpr:Sprite = new Sprite();
		private static var bm:Bitmap;
		public static var num:int = 0;
		
		public function RasterClip() 
		{
			
		}
		
		public static function raster(clip:MovieClip,wd:Number,hg:Number):Bitmap {	 
			clip.scaleX = scaleFactor;
			clip.scaleY = scaleFactor;
			clip.gotoAndStop(1);
			drawSpr.addChild(clip);
			bmd = new BitmapData(wd*scaleFactor, hg*scaleFactor, true, 0);
			bmd.draw(drawSpr);
			bm = new Bitmap(bmd, PixelSnapping.AUTO, true);
			bm.scaleX = 1 / scaleFactor;
			bm.scaleY = 1 / scaleFactor;
			drawSpr.removeChild(clip);
			clip = null;
			return bm;
		}
		
	}

}