package artur.display {
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Utils.Functions;
	public class McInfoNew extends mcInfo {
		public var mcNameTxt:TextField = Functions.getTitledTextfield(-46.5, -7.55, 93,15, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.AUTO);
		public function McInfoNew() {
			Functions.SetPriteAtributs(this, false, true, 0, 0);
			this.title.addChild(mcNameTxt);
			
		}
	}
}