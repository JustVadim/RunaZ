package 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.text.TextField;
	import flash.utils.getDefinitionByName;
	
	public class Preloader extends MovieClip {
		public static var loader:mcLoader = new mcLoader();
		
		public function Preloader() {
			this.addEventListener(Event.ENTER_FRAME, this.checkFrame);
			this.loaderInfo.addEventListener(ProgressEvent.PROGRESS, this.progress);
			this.loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.ioError);
			this.addChild(Preloader.loader);
		}
		
		private function ioError(e:IOErrorEvent):void {
			trace(e.text);
		}
		
		private function progress(e:ProgressEvent):void {
			var pers:int = int(e.bytesLoaded / e.bytesTotal * 100);
			Preloader.loader.mc.txt.text = this.getPers(pers);
			Preloader.loader.mc.gotoAndStop(pers);
			//textf.text = );
		}
		
		private function getPers(per:int):String {
			if (per < 10) {
				return "0" + per;
			}
			return per.toString();
		}
		
		private function checkFrame(e:Event):void {
			if (this.currentFrame == this.totalFrames) {
				this.stop();
				this.loadingFinished();
			}
		}
		
		private function loadingFinished():void {
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			startup();
		}
		
		private function startup():void 
		{
			var mainClass:Class = getDefinitionByName("Main") as Class;
			Preloader.loader.mc.txt.text = "Connection to server ... ";
			addChild(new mainClass() as DisplayObject);
		}
		
	}
	
}