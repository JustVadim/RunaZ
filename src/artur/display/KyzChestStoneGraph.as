package artur.display {
	import artur.RasterClip;
	import flash.display.Sprite;
	import report.Report;
	public class KyzChestStoneGraph extends Sprite {
		private static var stones:Array = [];
		private var id:int;
		private var free:Boolean = false;
		
		public function KyzChestStoneGraph(id:int, xx:Number, yy:Number, scale:Number) {
			this.id = id;
			this.x = xx;
			this.y = yy;
			this.scaleX *= scale;
			this.scaleY *= scale;
			this.addChild(RasterClip.getMovedBitmap(new mcStones(), id + 1, -1, -1, null, 2));
		}
		
		public static function getStone(id:int, xx:Number, yy:Number, scale:Number):KyzChestStoneGraph {
			var stone:KyzChestStoneGraph
			for (var i:int = 0; i < KyzChestStoneGraph.stones.length; i++) {
				stone = KyzChestStoneGraph.stones[i];
				if (stone.free && stone.id == id) {
					stone.free = false;
					stone.x = xx;
					stone.y = yy;
					stone.scaleX *= scale;
					stone.scaleY *= scale;
					return stone;
				}
			}
			stone = new KyzChestStoneGraph(id, xx, yy, scale);
			KyzChestStoneGraph.stones.push(stone);
			return stone;
		}
		
		public function frees():void {
			if(this.parent) {
				this.parent.removeChild(this);
				this.free = true;
			}
		}
	}
}