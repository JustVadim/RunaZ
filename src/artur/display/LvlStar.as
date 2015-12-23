package artur.display {
	import flash.filters.GlowFilter;
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Utils.Functions;
	public class LvlStar extends mcStar {
		public var txt:TextField = Functions.getTitledTextfield(-11.25, -8.5, 20.65, 16, new Art().fontName, 11, 0, TextFormatAlign.CENTER, "", 1, Kerning.OFF, -1, true);
		public function LvlStar() {
			this.addChild(this.txt);
			this.txt.text = "12";
			this.txt.filters = [new GlowFilter(0, 1, 1, 1, 1)];
		}
	}
}