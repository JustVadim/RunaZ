package artur.display 
{
	import Server.Lang;
	import artur.App;
	import artur.PrepareGr;
	import artur.RasterClip;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	
	public class Achiv extends Sprite {
		private static var frames:Array = RasterClip.getAnimationBitmaps(new mcAchivs());//PrepareGr.creatBms(new mcAchivs, false);
		private static var OVER_FILTRE:Array = [new GlowFilter(0xFFFFFF, 1, 4, 4)];
		private var index:int;
		private var star1:Bitmap = RasterClip.getMovedBitmap(new mcStarAchiv());//PrepareGr.creatBms(new mcStarAchiv, false)[0];
		private var star2:Bitmap = RasterClip.getMovedBitmap(new mcStarAchiv());
		private var star3:Bitmap = RasterClip.getMovedBitmap(new mcStarAchiv());
		
		public function Achiv(index:int, xx:Number, yy:Number){
			this.index = index;
			this.addChild(frames[index]);
			this.doStar(this.star1, 0.6, 36);
			this.doStar(this.star2, 17.4, 42.45);
			this.doStar(this.star3, 34.35, 36);
			this.x = xx;
			this.y = yy;
			this.buttonMode = true;
			this.mouseChildren = false;
			this.addEventListener(Event.ADDED_TO_STAGE, this.onAdded);
		}
		
		private function onAdded(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, this.onAdded);
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
			this.addEventListener(MouseEvent.ROLL_OVER, this.onOver);
			this.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
		}
		
		private function onOut(e:MouseEvent):void {
			this.filters = [];
			App.info.frees();
		}
		
		private function onOver(e:MouseEvent):void {
			App.sound.playSound('over1', App.sound.onVoice, 1);
			this.filters = Achiv.OVER_FILTRE;
			App.info.init( this.x + 80, this.y - 10, {txtInfo_w:300, txtInfo_h:37, txtInfo_t:Lang.getMyAchieveText(this.index), type:0 });
		}
		
		private function onRemoved(e:Event):void {
			this.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
			this.addEventListener(Event.ADDED_TO_STAGE, this.onAdded);
		}
		
		private function doStar(star:Bitmap, xx:Number, yy:Number):void {
			this.addChild(star);
			star.x = xx;
			star.y = yy;
			star.width = 16.4;
			star.height = 15.6;
		}
		
		public function init(state:int):void {
			this.star1.visible = state >= 1;
			this.star2.visible = state >= 2;
			this.star3.visible = state >= 3;
		}
		
	}

}