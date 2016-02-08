package artur.display 
{
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import report.Report;
	import Utils.Functions;
	public class WinRootMcText extends Sprite {	
		public var txtGold:TextField = Functions.getTitledTextfield(586, 7.5, 72, 22, new Art().fontName, 16, 0xFFF642, TextFormatAlign.CENTER, "9999", 1, Kerning.OFF, -1);
		public var txtSilver:TextField = Functions.getTitledTextfield(715, 7.5, 72, 22, new Art().fontName, 16, 0xFFFFFF, TextFormatAlign.CENTER, "9999", 1, Kerning.OFF, -1);
		public var txtAtack:TextField = Functions.getTitledTextfield(39.5, 118.65, 30.35, 19, new Art().fontName, 16, 0xEECB85, TextFormatAlign.CENTER, "12", 0.9, Kerning.OFF, -1);
		public var txtDeff:TextField = Functions.getTitledTextfield(39.5, 143.1, 30.35, 19, new Art().fontName, 16, 0x9CF751, TextFormatAlign.CENTER, "12", 0.9, Kerning.OFF, -1);
		public var txtMana:TextField = Functions.getTitledTextfield(39.5, 167, 30.35, 19, new Art().fontName, 16, 0x99F3F5, TextFormatAlign.CENTER, "12", 0.9, Kerning.OFF, -1);
		public var txtEnergy:TextField = Functions.getTitledTextfield(39.5, 191, 30.35, 19, new Art().fontName, 16, 0xEE930A, TextFormatAlign.CENTER, "12", 0.9, Kerning.OFF, -1);
		
		
		public function WinRootMcText() {
			Functions.SetPriteAtributs(this, false, true, 0, 0);
			this.txtGold.filters = this.txtSilver.filters = this.txtAtack.filters = this.txtDeff.filters = this.txtMana.filters = this.txtEnergy.filters = [new GlowFilter(0x0, 1, 2, 2, 2, 1, false, false)];
			this.addChild(this.txtGold);
			this.addChild(this.txtSilver);
			this.addChild(this.txtAtack);
			this.addChild(this.txtDeff);
			this.addChild(this.txtMana);
			this.addChild(this.txtEnergy);
			this.txtGold.filters = this.txtSilver.filters = [new GlowFilter(0, 1, 2, 2, 1, 1)];
		}	
	}
}