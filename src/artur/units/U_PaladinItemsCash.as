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
	public class U_PaladinItemsCash extends Bitmap{
		
		private var free:Boolean = false;
		private var type:int;
		private var id:int;
		private static var itemsArray:Array = [];
		private static var itemsVector:Array = [new ItemHeadPall(), new ItemBodyPall(), new ItemGun1Pall(), new ItemUpArmPall(), new ItemHand1LPall(), new ItemHand1RPall(), new ItemHand2RPall(), new ItemHand2LPall(), new ItemLeg1RPall(), new ItemLeg2RPall(), new ItemLeg3RPall(), new ItemLeg1LPall(), new ItemLeg2LPall(), new ItemLeg3LPall(), new ItemShildPall()];
		
		public function U_PaladinItemsCash(type:int, id:int) {
			this.type = type;
			this.id = id;
			this.getImage(type, id+1);
		}
		
		private function getImage(type:int, frame:int):void {
			UnitCache.getItem(this, itemsVector, type, frame);
		}
		
		public static function getItem(type:int, id:int):U_PaladinItemsCash {
			for (var i:int = 0; i < itemsArray.length; i++) {
				var item_:U_PaladinItemsCash = U_PaladinItemsCash(U_PaladinItemsCash.itemsArray[i]);
				if(item_.free && item_.id == id && item_.type == type) {
					item_.free = false;
					return item_;
				}
			}
			var item:U_PaladinItemsCash = new U_PaladinItemsCash(type, id);
			U_PaladinItemsCash.itemsArray.push(item);
			return item;
		}
		
		public function frees():void {
			if(this.parent) {
				this.parent.removeChild(this);
				this.free = true;
			}
		}
		
		public function get getId():int {
			return this.id;
		}
	}
}