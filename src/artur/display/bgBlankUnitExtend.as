package artur.display 
{
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Server.Lang;
	import Utils.Functions;
	public class bgBlankUnitExtend extends bgBlankUnit {
		private var txt1:TextField = Functions.getTitledTextfield(21.15 + 92.5, 1, 93, 118, new Art().fontName, 12, 0xDFDFDF, TextFormatAlign.LEFT, Lang.getTitle(63) + "\n" + Lang.getTitle(64) +"\n" + Lang.getTitle(65) + "\n" + Lang.getTitle(66) + "\n" + Lang.getTitle(67) + "\n" + Lang.getTitle(69) + "\n" + Lang.getTitle(68), 1, Kerning.AUTO, 0, true, 2);
		private var txt2:TextField = Functions.getTitledTextfield(1 + 92.5, 121, 46, 18.5, new Art().fontName, 12, 0xDFDFDF, TextFormatAlign.LEFT, Lang.getTitle(85), 1, Kerning.AUTO, 0, true, 2);
		private var txt3:TextField = Functions.getTitledTextfield(106+ 92.5, 121, 30, 18.5, new Art().fontName, 12, 0xDFDFDF, TextFormatAlign.LEFT, Lang.getTitle(86), 1, Kerning.AUTO, 0, true, 2);
		public function bgBlankUnitExtend() {
			this.addChild(this.txt1);
			this.addChild(this.txt2);
			this.addChild(this.txt3);
		}
		
	}

}