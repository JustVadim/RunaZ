package artur.display {
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Utils.Functions;
	public class btnSel1Extend extends btnSel1{
		private var title:TextField = Functions.getTitledTextfield(0, 2, 147, 22, new Art().fontName, 16, 0xFFFFFF, TextFormatAlign.CENTER, "");
		public function btnSel1Extend(str:String) {
			title.filters = [new GlowFilter(0, 1, 2, 2, 1)];
			this.title.text = str;
			this.addChild(this.title);
		}
	}

}