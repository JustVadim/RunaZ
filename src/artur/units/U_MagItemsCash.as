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
	public class U_MagItemsCash extends Bitmap{
		
		private var free:Boolean = false;
		private var type:int;
		private var id:int;
		private static var itemsArray:Array = [];
		private static var itemsVector:Array = [new ItemHeadMag(), new ItemBodyMag(), new ItemGun1Mag(), new ItemUpArmMag(), new ItemHand1LMag(), new ItemHand1RMag(), new ItemHand2RMag(), new ItemHand2LMag(), new ItemLeg1RMag(), new ItemLeg2RMag(), new ItemLeg3RMag(), new ItemLeg1LMag(), new ItemLeg2LMag(), new ItemLeg3LMag(), new ItemPlaschMag()];
		
		public function U_MagItemsCash(type:int, id:int) {
			this.type = type;
			this.id = id;
			this.getImage(type, id+1);
		}
		
		public function get getId():int {
			return this.id;
		}
		
		private function getImage(type:int, frame:int):void {
			UnitCache.getItem(this, itemsVector, type, frame);
		}
		
		public static function getItem(type:int, id:int):U_MagItemsCash {
			for (var i:int = 0; i < itemsArray.length; i++) {
				var item_:U_MagItemsCash = U_MagItemsCash(U_MagItemsCash.itemsArray[i]);
				if(item_.free && item_.id == id && item_.type == type) {
					item_.free = false;
					return item_;
				}
			}
			var item:U_MagItemsCash = new U_MagItemsCash(type, id);
			U_MagItemsCash.itemsArray.push(item);
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