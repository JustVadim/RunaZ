package artur.display {
	import artur.RasterClip;
	import artur.win.WinKyz;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	public class KyzChestStone extends Sprite {
		private var id:int;
		public function KyzChestStone(id:int) {
			this.id = id;
			var st:MovieClip = new mcStones();
			this.addChild(RasterClip.getMovedBitmap(st, id + 1, -1, -1));
			this.buttonMode = true;
			this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
			this.addEventListener(MouseEvent.CLICK, this.onClick);
			this.addEventListener(MouseEvent.ROLL_OVER, this.onOver);
			this.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
		}
		
		private function onOut(e:MouseEvent):void {
			this.filters = [];
		}
		
		private function onOver(e:MouseEvent):void {
			this.filters = [new GlowFilter(0xFFFFFF, 1, 4, 4)];
		}
		
		private function onClick(e:MouseEvent):void {
			KyzStone(WinKyz.inst.zakazBtns[this.id + 1]).onAddCraftClick();
		}
		
		private function onRemovedFromStage(e:Event):void {
			this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			this.removeEventListener(MouseEvent.CLICK, this.onClick);
			this.removeEventListener(MouseEvent.ROLL_OVER, this.onOver);
			this.removeEventListener(MouseEvent.ROLL_OUT, this.onOut);
			this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
		}
		
	}

}