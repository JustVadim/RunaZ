package artur.display  {
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Utils.Functions;
	public class BtnHeroExtend extends btnAddHero2 {
		private var title:TextField = Functions.getTitledTextfield(0.4, -3, 77, 18, new Art().fontName, 15, 0xC29A4C, TextFormatAlign.CENTER, "", 1, Kerning.AUTO, 0, false);
		
		public function BtnHeroExtend() {
			this.addChild(this.title);
			this.title.text = "Нанять";
		}
	}
}