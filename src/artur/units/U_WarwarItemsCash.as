package artur.units {
	import artur.PrepareGr;
	import artur.RasterClip;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import report.Report;
	
	public class U_WarwarItemsCash extends Bitmap {
		
		private var free:Boolean = false;
		private var type:int;
		private var id:int;
		private static var itemsArray:Array = [];
		private static var itemsVector:Array = [new itemHead(), new itemBody(), new itemSikir(), new itemAppArm(), new itemHend1R(), new itemHend2R(), new itemHend3R(), new itemAppArm2(), new itemHend1L(), new itemHend2L(), new itemHend3L(), new itemLeg1R(), new itemLeg2R(), new itemLeg3R(), new itemLeg1L(), new itemLeg2L(), new itemLeg3L()];
		
		public function U_WarwarItemsCash(type:int, id:int) {
			this.type = type;
			this.id = id;
			this.getImage(type, id + 1);
		}
		
		public function get getId():int {
			return this.id;
		}
		
		private function getImage(type:int, frame:int):void {
			UnitCache.getItem(this, itemsVector, type, frame);
		}
		
		public static function getItem(type:int, id:int):U_WarwarItemsCash {
			for (var i:int = 0; i < itemsArray.length; i++) {
				var item_:U_WarwarItemsCash = U_WarwarItemsCash(U_WarwarItemsCash.itemsArray[i]);
				if(item_.free && item_.id == id && item_.type == type) {
					item_.free = false;
					return item_;
				}
			}
			var item:U_WarwarItemsCash = new U_WarwarItemsCash(type, id);
			U_WarwarItemsCash.itemsArray.push(item);
			return item;
		}
		
		public function frees():void {
			if(this.parent) {
				this.parent.removeChild(this);
				this.free = true;
			}
		}
	}
}