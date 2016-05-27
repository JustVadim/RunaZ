package artur.display {
	import artur.RasterClip;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import report.Report;
	public class KyzProgress extends Sprite {
		private var bg:Bitmap;
		private var progress:MovieClip;
		private var stone:Bitmap;
		private var st:KyzChestStoneGraph;
		
		public function KyzProgress() {
			this.tabEnabled = false;
			this.tabChildren = false;
			this.mouseChildren = false;
			this.mouseEnabled = false;
			this.bg = RasterClip.getBitmap(new mcKyzBarBg());
			this.bg.x = 68.6;
			this.bg.y = 227.25;
			this.addChild(this.bg);
			this.progress = new mcKyzBarLoader();
			this.addChild(this.progress);
			this.progress.x = 68.65;
			this.progress.y = 355.1;
			this.progress.gotoAndStop(1);
		}
		
		
		public function setTo(dt:int):void {
			this.progress.gotoAndStop(101 - int(100 * dt / 35));
		}
		
		public function init(id:int, boss:Sprite):void {
			this.st = KyzChestStoneGraph.getStone(id, 246, 258, 2);
			this.addChild(this.st);
			boss.addChild(this);
		}
		
		public function frees():void {
			if(this.st != null) {
				this.st.frees();
				this.st = null;
			}
			if(this.parent) {
				this.parent.removeChild(this);
			}
		}
	}

}