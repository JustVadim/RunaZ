package artur.display {
	import flash.display.Sprite;
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Utils.Functions;
	
	public class LockSpr extends Block { 
		private var txt:TextField = Functions.getTitledTextfield(254.1, 203.75, 388, 111, new Art().fontName, 15, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.AUTO, 0, false);
		public function LockSpr() {
			
		}
		
		public  function init(txt:String = "Loading"):void {
			this.addChild(this.txt);
			this.txt.text = txt;
			Main.THIS.addChild(this);
			this.gotoAndPlay(1);
		}
		
		public function frees():void {
			if (this.parent) {
				parent.removeChild(this);
			}
		}
	}

}