package artur.win {
	import artur.App;
	import flash.display.Sprite;
	import artur.RasterClip;
	import flash.display.Bitmap;
	public class WinCave extends Sprite {
		public var bin:Boolean;
		private var bg:Bitmap;
		public function WinCave() {
			this.bin = false;
			//this.bg = RasterClip.getBitmap(new mcHeroWin);
			/*this.addChild(this.bg);*/
			//this.addChild();
			//new mcHeroWin();
		}
		
		public function init():void {
			this.bin = true;
			App.spr.addChild(this);
			App.topMenu.init(true, true);
			App.topPanel.init(this);
		}
		
		public function frees():void {
			if(this.bin) {
				this.bin = false;
				App.spr.removeChild(this);
			}
		}
		
		public function update():void {
			if(this.bin) {
				
			}
		}
	}

}