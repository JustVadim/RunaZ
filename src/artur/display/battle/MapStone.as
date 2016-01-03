package artur.display.battle {
	import artur.PrepareGr;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import report.Report;
	public class MapStone extends Sprite {
		public var id:int;
		public var free:Boolean = false;
		private static var sonesVector:Stone1 = new Stone1();
		public static var stonesArr:Array = [];
		
		
		public function MapStone(id:int) {
			Report.addMassage("create stone ID: " + id);
			this.id = id;
			this.getImage(this.id);
		}
		
		public static function getStone(id:int):MapStone {
			var stone:MapStone;
			for (var i:int = 0; i < MapStone.stonesArr.length; i++) {
				stone = MapStone(MapStone.stonesArr[i]);
				if (stone.free && stone.id == id) {
					stone.free = false;
					return stone;
				}
			}
			stone = new MapStone(id);
			MapStone.stonesArr.push(stone);
			return stone;
		}
		
		public function getImage(frame:int):void {
			var rect:Rectangle = new Rectangle();
			var cont:Sprite = new Sprite();
			var bmd:BitmapData;
			var mtx:Matrix = new Matrix();
			var bm:Bitmap;
			sonesVector.gotoAndStop(frame);
			if(sonesVector.scaleX != PrepareGr.scaleFactor) {
				sonesVector.scaleX = PrepareGr.scaleFactor;
				sonesVector.scaleY = PrepareGr.scaleFactor;
			}
			cont.addChild(sonesVector);
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
		
		public function frees():void 
		{
			this.free = true;
			if(this.parent) {
				this.parent.removeChild(this);
			}
		}
	}

}