package artur.display {
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import report.Report;
	import Utils.Functions;
	public class McInfoInfos extends Sprite {
		public var txt1:TextField = Functions.getTitledTextfield(108.15, -1, 50, 16, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.LEFT, "", 1, Kerning.OFF, -1, true);
		public var txtPlus:TextField = Functions.getTitledTextfield(158, -1, 20, 16, new Art().fontName, 12, 0x33FF00, TextFormatAlign.LEFT, "", 1, Kerning.OFF, -1, true);
		public var txt2:TextField = Functions.getTitledTextfield(178, -1, 40, 16, new Art().fontName, 12, 0x33FF00, TextFormatAlign.LEFT, "", 1, Kerning.OFF, -1, true);
		public var title:TextField;
		
		public function McInfoInfos(str:String = "") {
			var glow:Array = [new GlowFilter(0x0, 0.8, 2, 2, 1)];
			if(str != "") {
				this.addChild(this.title = Functions.getTitledTextfield(20.2, -1.5, 90, 16, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.LEFT, str, 1, Kerning.AUTO, 0, true));
			}
			this.addChild(this.txt1);
			this.txt1.text = "";
			this.txtPlus.text = "+";
			this.txt2.text = "";
			this.txt1.filters = this.txt2.filters = this.txtPlus.filters = glow;
			this.addChild(this.txtPlus);
			this.addChild(this.txt2);
		}
		
		public function battleInit():void {
			this.txt2.visible = false;
			this.txtPlus.visible = false;
		}
		
	}

}