package artur.display 
{
	import artur.PrepareGr;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	
	public class ItemCallImage extends Sprite {
		public var unitType:int;
		public var itemType:int;
		public var itemId:int;
		public var free:Boolean = false;
		
		
		public static var ITEMS_CASH:Array = [];
		
		public static var itemsClasses:Array = [Cell_Heads, Cell_Bodys, Cell_Boots, Cell_TopHands, Cell_DownHands, [Cell_Guns, Cell_Swords, Cell_Bows, Cell_Totem, ], [Cell_Guns, Cell_Shilds], Cell_Inv];
		
		public function ItemCallImage(unitType:int, itemType:int, itemId:int) {
			this.unitType = unitType;
			this.itemType = itemType;
			this.itemId = itemId;
			this.tabEnabled = false;
			this.tabChildren = false;
			this.mouseEnabled = false;
			if (itemType != 5 && itemType != 6) {
				this.getImage(new ItemCallImage.itemsClasses[itemType], itemId);
			} else {
				this.getImage(new ItemCallImage.itemsClasses[itemType][unitType], itemId);
			}
			
		}
		
		
		public static function getItemCallImage(unitType:int, itemType:int, itemId:int):ItemCallImage {
			var i:int = 0;
			var ici:ItemCallImage
			if (itemType != 5 && itemType!= 6) {
				for (i = 0; i < ITEMS_CASH.length; i++) {
					ici = ITEMS_CASH[i];
					if (ici.free && ici.itemType == itemType && ici.itemId == itemId) {
						ici.free = false;
						return ici;
					}
				}
				ici = new ItemCallImage(0, itemType, itemId);
				ITEMS_CASH.push(ici);
				return ici; 
			}
			for (i = 0; i < ITEMS_CASH.length; i++) {
				ici = ITEMS_CASH[i];
				if (ici.free && ici.unitType == unitType && ici.itemType == itemType && ici.itemId == itemId) {
					ici.free = false;
					return ici;
				}
			}
			ici = new ItemCallImage(unitType, itemType, itemId);
			ITEMS_CASH.push(ici);
			return ici; 
		}
		
		public function getImage(mc:MovieClip, frame:int):void {
			var rect:Rectangle = new Rectangle();
			var cont:Sprite = new Sprite();
			var bmd:BitmapData;
			var mtx:Matrix = new Matrix();
			var bm:Bitmap;
			mc.gotoAndStop(frame);
			mc.width *= PrepareGr.scaleFactor;
			mc.height *= PrepareGr.scaleFactor;
			cont.addChild(mc);
			rect = cont.getBounds(cont);
			mtx.tx = -rect.x;
			mtx.ty = -rect.y;
			bmd = new BitmapData(cont.width, cont.height, true, 0);
			bmd.draw(cont, mtx);
			bm = new Bitmap(bmd, PixelSnapping.AUTO, true);
			bm.width /= PrepareGr.scaleFactor; 
			bm.height /= PrepareGr.scaleFactor;
			bm.x -= mtx.tx/PrepareGr.scaleFactor;
			bm.y -= mtx.ty / PrepareGr.scaleFactor;
			this.addChild(bm)
		}
		
	}

}