package artur.units 
{
	import flash.display.Bitmap;
	public class B_MagItemsCash extends Bitmap {
		private var free:Boolean = false;
		private var type:int;
		private var id:int;
		private static var itemsArray:Array = [];
		private static var itemsVector:Array = [new ItemHeadMagBot(), new ItemBodyMagBot(), new ItemGun1MagBot(), new ItemUpArmMagBot(), new ItemHand1LMagBot(), new ItemHand1RMagBot(), new ItemHand2RMagBot(), new ItemHand2LMagBot(), new ItemLeg1RMagBot(), new ItemLeg2RMagBot(), new ItemLeg3RMagBot(), new ItemLeg1LMagBot(), new ItemLeg2LMagBot(), new ItemLeg3LMagBot(), new ItemPlaschMagBot()];
		
		public function B_MagItemsCash(type:int, id:int) {
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
		
		public static function getItem(type:int, id:int):B_MagItemsCash {
			for (var i:int = 0; i < itemsArray.length; i++) {
				var item_:B_MagItemsCash = B_MagItemsCash(B_MagItemsCash.itemsArray[i]);
				if(item_.free && item_.id == id && item_.type == type) {
					item_.free = false;
					return item_;
				}
			}
			var item:B_MagItemsCash = new B_MagItemsCash(type, id);
			B_MagItemsCash.itemsArray.push(item);
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