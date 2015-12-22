package artur.display {
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Utils.Functions;
	public class mcBigLifeBarExtend extends mcBigLifeBar{
		public var txtHP:TextField = Functions.getTitledTextfield(180, 0, 87, 14, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.OFF, -1, true);
		public var txtMp:TextField = Functions.getTitledTextfield(180, 0, 87, 14, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.OFF, -1, true);
		
		public function mcBigLifeBarExtend() 
		{
			this.mcLife.addChild(this.txtHP);
			this.mcMana.addChild(txtMp);
		}
		
	}

}