package artur.display 
{
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Utils.Functions;
	public class BtnStoneExtend extends BtnStone {
		private var title:TextField;
		public function BtnStoneExtend() {
			this.addChild(this.title = Functions.getTitledTextfield(0, 7, this.width, 35, new Art().fontName, 18, 0xFFFF00, TextFormatAlign.CENTER, "Заказать", 0.8));
			this.title.filters = [new GlowFilter(0xFF8F20)];
		}
		
	}

}