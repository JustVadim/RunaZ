package artur.display {
	import adobe.utils.CustomActions;
	import artur.App;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Server.Lang;
	import Utils.Functions;
	public class Tutor extends mcTutorial {
		private var txt:TextField = Functions.getTitledTextfield(0,0, 300, 0, new Art().fontName, 15, 0xFFFFFF, TextFormatAlign.CENTER, "", 0.9);
		private var coordX:Array = [0, 250, 170, 0, 270];
		private var coordY:Array = [0, 300, 45, 0, 250];
		
		public function Tutor() {
			this.addChild(this.txt);
			this.txt.borderColor = 0x008040;
			this.txt.border = true;
			this.txt.height = 20;
			this.txt.wordWrap = true;
			this.addFrameScript(0, onFrame);
			this.addFrameScript(1, onFrame);
			this.addFrameScript(2, onFrame);
			this.addFrameScript(3, onFrame);
			this.addFrameScript(4, onFrame);
			this.addFrameScript(5, onFrame);
		}
		
		private function onFrame():void 
		{
			if(this.txt.parent) {
				this.removeChild(this.txt);
			}
			if (Lang.getTitle(60, this.currentFrame) != "") {
				this.addChild(this.txt);
				this.txt.x = coordX[this.currentFrame];
				this.txt.y = coordY[this.currentFrame];
				this.txt.text = Lang.getTitle(60, this.currentFrame);
				this.txt.height = 23 * this.txt.numLines;
			}
			
		}
		
		public function init(frame:int):void {
			App.spr.addChild(this);
			this.gotoAndStop(frame);
		}
		
		public function frees():void {
			if(this.parent) {
				this.parent.removeChild(this);
			}
		}
	}

}