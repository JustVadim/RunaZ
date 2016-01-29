package artur.display {
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import report.Report;
	import Server.Lang;
	import Utils.Functions;
	public class WinSellExtend extends WinSell{
		public var sellTittle:TextField = Functions.getTitledTextfield( -65.7, -6, 147.7, 30, new Art().fontName, 15, 0xFFFFFF, TextFormatAlign.CENTER, Lang.getTitle(73));
		public function WinSellExtend() {
			this.sellSprite.addChild(this.sellTittle);
			this.sellSprite.addFrameScript(1, this.frameFunc);
			this.sellSprite.addFrameScript(0, this.frameFunc);
			this.sellSprite.gotoAndStop(1);
		}
		
		private function frameFunc():void 
		{	
			switch(this.sellSprite.currentFrame) {
				case 1:
					this.sellTittle.textColor = 0xFFFFFF;
					break;
				case 2:
					this.sellTittle.textColor = 0xC6FF00;
					break;
			}	
		}
		
	}

}