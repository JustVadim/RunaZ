package artur.display {
	import Server.Lang;
	import Utils.Functions;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	public class BtnArena extends btnArena1 {
		private var title:TextField;
		public function BtnArena() {
			this.addChild(this.title = Functions.getTitledTextfield(0, 33, this.width, 35, new Art().fontName, 18, 0xB9DCFF, TextFormatAlign.CENTER, Lang.getTitle(163), 0.8));
			this.title.filters = [new GlowFilter(0x000000)];
		}
	}
}