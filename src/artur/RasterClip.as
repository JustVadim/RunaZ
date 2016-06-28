package artur 
{
	import Chat.FindUser;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import report.Report;
	
	public class RasterClip  {	
		//public static var scaleFactor:Number = 1;
		private static var drawSpr:Sprite;
		public static var defaultScale:Number = 1.2;
		public static var unitItemsScale:Number = 1.2;
		public static var PrepareGrScale:Number = 2;
		
		public function RasterClip() {
			
		}
		
		public static function getBitmap(clip:MovieClip, frame:int = 1, wd:Number = -1, hg:Number = -1, filter:Array = null, scalef:Number = 1):Bitmap {
			clip.gotoAndStop(frame);
			var bmd:BitmapData = RasterClip.getBitmapData(clip, frame, wd, hg, filter, scalef);
			var bm:Bitmap= new Bitmap(bmd, PixelSnapping.AUTO, true);
			if(scalef == 1) {
				scalef = defaultScale;
			}
			
			if(wd == -1) {
				bm.scaleX /= scalef;
			}
			if(hg == -1) {
				bm.scaleY /= scalef;
			}
			return bm;
		}
		
		public static function getBitmapFromBmd(bmd:BitmapData, scaleF:Number = 3):Bitmap {
			var bm:Bitmap = new Bitmap(bmd, PixelSnapping.AUTO, true);
			bm.scaleX = bm.scaleY = 1 / RasterClip.PrepareGrScale;
			return bm;
		}
		
		public static function getBitmapData(clip:DisplayObject, frame:int, ww:int = -1, hh:int = -1, filter:Array = null, scaleF:Number = 1):BitmapData {
			if(scaleF == 1) {
				scaleF = defaultScale;
			}
			if (RasterClip.drawSpr == null) {
				RasterClip.drawSpr = new Sprite();
			}
			if(filter != null) {
				clip.filters = filter;
			}
			if (ww == -1) {
				clip.scaleX *= scaleF;
			} else {
				clip.width = ww;
			}
			if (hh == -1) {
				clip.scaleY *= scaleF;
			} else {
				clip.height = hh;
			}
			if(clip.width>5) {
				RasterClip.drawSpr.addChild(clip);
				var bmd:BitmapData = new BitmapData(clip.width, clip.height, true, 0);
				bmd.draw(RasterClip.drawSpr);
				RasterClip.drawSpr.removeChild(clip);
				return bmd;
			} else {
				return new BitmapData(10, 10);
			}
		}
		
		public static function getMovedBitmap(clip:MovieClip, frame:int = 1, ww:int = -1, hh:int = -1, filter:Array = null, scaleF:Number = 1):Bitmap {
			if(scaleF == 1) {
				scaleF = defaultScale;
			}
			if(filter) {
				clip.filters = filter;
			}
			clip.gotoAndStop(frame);
			if (clip.width > 4)
			{
				for (var j:int = 0; j < clip.numChildren; j++) {
					if (clip.getChildAt(j) is MovieClip) {
						MovieClip(clip.getChildAt(j)).gotoAndStop(frame);
					}
				}
				clip.scaleX *= scaleF;
				clip.scaleY *= scaleF;
				RasterClip.drawSpr.addChild(clip);
				var rect:Rectangle = RasterClip.drawSpr.getBounds(RasterClip.drawSpr);
				clip.x = -rect.x;
				clip.y = -rect.y;
				var bmd:BitmapData = new BitmapData(clip.width, clip.height, true, 0);
				bmd.draw(RasterClip.drawSpr);
				var bm:Bitmap = new Bitmap(bmd, PixelSnapping.AUTO, true);
				bm.scaleX = bm.scaleY = 1 / scaleF;
				bm.x = rect.x/scaleF;
				bm.y = rect.y/scaleF;
				RasterClip.drawSpr.removeChild(clip);
				return bm;
			}else {
				return new Bitmap;
			}
		}
		
		public static function getAnimationBitmaps(clip:MovieClip, filter:Array = null, scaleF:Number = 1):Array {
			if(scaleF == 1) {
				scaleF = defaultScale;
			}
			var arr:Array = new Array();
			if(filter) {
				clip.filters = filter;
			}
			clip.gotoAndStop(1);
			clip.scaleX *= scaleF;
			clip.scaleY *= scaleF;
			RasterClip.drawSpr.addChild(clip);
			for (var i:int = 1; i <= clip.totalFrames; i++) {
				clip.gotoAndStop(i);
				var rect:Rectangle = RasterClip.drawSpr.getBounds(RasterClip.drawSpr);
				clip.x = -rect.x;
				clip.y = -rect.y;
				var bmd:BitmapData = new BitmapData(clip.width, clip.height, true, 0);
				bmd.draw(RasterClip.drawSpr);
				var bm:Bitmap = new Bitmap(bmd, PixelSnapping.AUTO, true);
				bm.scaleX = bm.scaleY = 1 / scaleF;
				bm.x = rect.x/scaleF;
				bm.y = rect.y / scaleF;
				arr[i - 1] = bm;
				clip.x = 0;
				clip.y = 0;
				if (clip.currentLabel) {
					bm.name = clip.currentLabel;
				} else {
					bm.name = String(clip.currentFrame);
				}
			}
			RasterClip.drawSpr.removeChild(clip);
			return arr;
		}
		
		
		
		
		
		
		
	}

}