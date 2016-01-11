package artur.display {
	import adobe.utils.CustomActions;
	import artur.PrepareGr;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	public class KyzStone extends Sprite {
		private static var st:mcStones = new mcStones();
		private static var kyzStones:Array = new Array();
		private var free:Boolean = false;
		private var id:int;
		
		public function KyzStone(id:int) {
			this.id = id;
			this.getImage();
		}
		
		public function getImage():void {
			var rect:Rectangle = new Rectangle();
			var cont:Sprite = new Sprite();
			var bmd:BitmapData;
			var mtx:Matrix = new Matrix();
			var bm:Bitmap;
			st.gotoAndStop(this.id);
			if(st.scaleX != PrepareGr.scaleFactor) {
				st.scaleX = PrepareGr.scaleFactor;
				st.scaleY = PrepareGr.scaleFactor;
			}
			cont.addChild(st);
			rect = cont.getBounds(cont);
			mtx.tx = -rect.x;
			mtx.ty = -rect.y;
			bmd = new BitmapData(cont.width, cont.height, true, 0);
			bmd.draw(cont, mtx);
			bm = new Bitmap(bmd, PixelSnapping.AUTO, true);
			bm.scaleX /= PrepareGr.scaleFactor; 
			bm.scaleY /= PrepareGr.scaleFactor;
			bm.x -= mtx.tx/PrepareGr.scaleFactor;
			bm.y -= mtx.ty / PrepareGr.scaleFactor;
			this.addChild(bm)
		}
		
		public static function getStone(id:int):KyzStone {
			var stone:KyzStone;
			for (var i:int = 0; i < KyzStone.kyzStones.length; i++) {
				stone = KyzStone(KyzStone.kyzStones[i]);
				if (stone.free && stone.id == id) {
					stone.free = false;
					return stone;
				}
			}
			stone = new KyzStone(id);
			KyzStone.kyzStones.push(stone);
			return stone;
		}
		
		public function frees():void 
		{
			this.free = true;
			this.scaleX = this.scaleY = 1;
			if(this.parent) {
				this.parent.removeChild(this);
			}
		}
	}
}