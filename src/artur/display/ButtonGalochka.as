package artur.display {
	import Utils.Functions;
	import artur.RasterClip;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	public class ButtonGalochka extends Sprite {
		private var free:Boolean = false;
		private static var arr:Array = [];
		
		public function ButtonGalochka() {
			Functions.SetPriteAtributs(this, false, false);
			var mc:MovieClip = new SprTrue();
			this.addChild(RasterClip.getBitmap(mc, 1, mc.width, mc.height));
			this.y = -30;
			this.scaleX = this.scaleY = 0.6;
		}
		
		public static function getGalochka(parr:Sprite, xx:Number):ButtonGalochka {
			var gal:ButtonGalochka;
			for (var i:int = 0; i < arr.length; i++) {
				gal= ButtonGalochka(arr[i]);
				if(gal.free == true) {
					gal.free = false;
					parr.addChild(gal);
					gal.x = xx;
					return gal;
				}
			}
			parr.addChild(gal = new ButtonGalochka());
			arr.push(gal);
			gal.x = xx;
			return gal;
		}
		
		public function frees():void {
			if(this.parent != null) {
				this.parent.removeChild(this);
				this.free = true;
			}
		}
	}
}