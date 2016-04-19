package artur.display 
{
	import artur.PrepareGr;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	public class Achiv extends Sprite {
		private static var frames:Array = PrepareGr.creatBms(new mcAchivs, false);
		private static var OVER_FILTRE:Array = [new GlowFilter(0xFFFFFF, 1, 2, 2)];
		private var index:int;
		private var star1:Bitmap = PrepareGr.creatBms(new mcStarAchiv, false)[0];
		private var star2:Bitmap = PrepareGr.creatBms(new mcStarAchiv, false)[0];
		private var star3:Bitmap = PrepareGr.creatBms(new mcStarAchiv, false)[0];
		
		public function Achiv(index:int, xx:Number, yy:Number){
			this.index = index;
			this.addChild(frames[index]);
			this.doStar(this.star1, 0.6, 36);
			this.doStar(this.star2, 17.4, 42.45);
			this.doStar(this.star3, 34.35, 36);
			this.x = xx;
			this.y = yy;
			this.buttonMode = true;
			this.mouseChildren = false;
		}
		
		private function doStar(star:Bitmap, xx:Number, yy:Number):void {
			this.addChild(star);
			star.x = xx;
			star.y = yy;
			star.width = 16.4;
			star.height = 15.6;
		}
		
		public function init(index:int = 0, xp:int = 0, yp:int = 0, st1:Boolean = false, st2:Boolean = false, st3:Boolean = false):void {
			removeChild(frames[this.index]);
			this.index = index;
			addChild(frames[index]);
			this.addChild(star1);
			this.addChild(star2);
			this.addChild(star3);
			star1.visible = st1;
			star2.visible = st2;
			star3.visible = st3;
			this.x = xp;
			this.y = yp;
		}
		
	}

}