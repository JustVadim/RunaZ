package artur 
{
	import flash.filters.GlowFilter;
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Utils.Functions;
	public class UnitBlankTxt extends txtBlank {
		public var txtName:TextField =  Functions.getTitledTextfield(1, 120, 91, 19, new Art().fontName, 15, 0x33CC33, TextFormatAlign.CENTER, "ВАРВАР", 1, Kerning.AUTO, 0, true);
		public var txtGold:TextField = Functions.getTitledTextfield(156, 122.15, 42.25, 15, new Art().fontName, 12, 0xFFF642, TextFormatAlign.LEFT, "", 0.9, Kerning.OFF, -1, false);
		public var txtSilver:TextField = Functions.getTitledTextfield(247.35, 122.15, 42.25, 15, new Art().fontName, 12, 0xE9E7E7, TextFormatAlign.LEFT, "", 0.9, Kerning.OFF, -1, false);
		public var txt_sk_double:TextField = Functions.getTitledTextfield(321, 28.5, 22, 12, new Art().fontName, 9, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.OFF, -1, false);
		public var txt_sk_crit:TextField = Functions.getTitledTextfield(351, 28.5, 22, 12, new Art().fontName, 9, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.OFF, -1, false);
		public var txt_sk_return:TextField = Functions.getTitledTextfield(321, 67.6, 22, 12, new Art().fontName, 9, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.OFF, -1, false);
		public var txt_sk_miss:TextField = Functions.getTitledTextfield(351, 67.6, 22, 12, new Art().fontName, 9, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.OFF, -1, false);
		public var txt_sk_out:TextField = Functions.getTitledTextfield(321, 106.65, 22, 12, new Art().fontName, 9, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.OFF, -1, false);
		public var txt_sk_ult:TextField = Functions.getTitledTextfield(351, 106.65, 22, 12, new Art().fontName, 9, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.OFF, -1, false);
		public var txtLife:TextField = Functions.getTitledTextfield(204.6, 1, 80, 17, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.LEFT, "", 1, Kerning.OFF, -1, false);
		public var txtMana:TextField = Functions.getTitledTextfield(204.6, 18, 80, 17, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.LEFT, "", 1, Kerning.OFF, -1, false);
		public var txtDamage:TextField = Functions.getTitledTextfield(204.6, 34, 80, 17, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.LEFT, "", 1, Kerning.OFF, -1, false);
		public var txtFizDef:TextField = Functions.getTitledTextfield(204.6, 51, 80, 17, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.LEFT, "", 1, Kerning.OFF, -1, false);
		public var txtMagDef:TextField = Functions.getTitledTextfield(204.6, 68, 80, 17, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.LEFT, "", 1, Kerning.OFF, -1, false);
		public var txtInc:TextField = Functions.getTitledTextfield(204.6, 85, 80, 17, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.LEFT, "", 1, Kerning.OFF, -1, false);
		public var txtSpeed:TextField = Functions.getTitledTextfield(204.6, 101, 80, 17, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.LEFT, "", 1, Kerning.OFF, -1, false);
		
		public function UnitBlankTxt() 
		{
			Functions.SetPriteAtributs(this, true, true);
			this.addChild(this.txtName);
			this.txtName.filters = [new GlowFilter(0x0, 1, 3, 3, 1, 1)];
			this.addChild(this.txtGold);
			this.addChild(this.txtSilver);
			this.addChild(this.txt_sk_double);
			this.addChild(this.txt_sk_crit);
			this.addChild(this.txt_sk_return);
			this.addChild(this.txt_sk_miss);
			this.addChild(this.txt_sk_out);
			this.addChild(this.txt_sk_ult);
			this.addChild(this.txtLife);
			this.addChild(this.txtMana);
			this.addChild(this.txtDamage);
			this.addChild(this.txtFizDef);
			this.addChild(this.txtMagDef);
			this.addChild(this.txtInc);
			this.addChild(this.txtSpeed);
		}
		
	}

}