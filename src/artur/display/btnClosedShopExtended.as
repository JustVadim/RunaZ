package artur.display {
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Utils.Functions;
	public class btnClosedShopExtended extends btnClosedShop{
		
		private var title:TextField = Functions.getTitledTextfield(2.75, -2, 92.5, 14.8, new Art().fontName, 15, 0xFFCC99, TextFormatAlign.CENTER, "", 1);
		
		public function btnClosedShopExtended() {
			this.addChild(this.title);
			this.title.text = "Закрыть";
		}
		
	}

}