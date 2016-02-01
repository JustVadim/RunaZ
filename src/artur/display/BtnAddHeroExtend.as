package artur.display {
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Server.Lang;
	import Utils.Functions;
	public class BtnAddHeroExtend extends btnAddHero {
		private var txt:TextField = Functions.getTitledTextfield( -6, 17.25, 92.10, 50, new Art().fontName, 17, 0xC9B767, TextFormatAlign.CENTER, Lang.getTitle(87), 1, Kerning.AUTO, 0, true, 2);
		public function BtnAddHeroExtend() {
			this.addChild(this.txt)
			this.txt.wordWrap = true;
			this.txt.filters = [new DropShadowFilter(1, 56, 0xFFFFFF, 1, 1, 1), new DropShadowFilter(1, 254, 0xFF9966, 0.6, 1, 1, 1), new GlowFilter(0x0)];
		}
	}

}