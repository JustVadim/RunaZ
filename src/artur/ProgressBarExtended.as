package artur {
	import flash.filters.GlowFilter;
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Utils.Functions;
	public class ProgressBarExtended  extends progresBar {
		public var lvl:TextField = Functions.getTitledTextfield( 164, -21, 38, 16, new Art().fontName, 14, 0, TextFormatAlign.CENTER, "", 1, Kerning.OFF, -1);
		public var exp:TextField = Functions.getTitledTextfield( 0, -3, 374, 16, new Art().fontName, 11, 0, TextFormatAlign.CENTER, "", 1, Kerning.AUTO, 0);
		public function ProgressBarExtended() {
			Functions.SetPriteAtributs(this, false, false, 0, 0);
			this.addChild(this.lvl);
			this.addChild(this.exp);
			this.lvl.filters = this.exp.filters = [new GlowFilter(0x0, 1, 1, 1, 1)];
			
		}
		
	}

}