package artur {
	import flash.filters.GlowFilter;
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Utils.Functions;
	public class McTextCastleWinExtend extends mcTextCastleWin {
		public var txtGold:TextField = Functions.getTitledTextfield( 585, 8, 75, 22, new Art().fontName, 16, 0xFFF642, TextFormatAlign.CENTER, "", 1, Kerning.OFF, -1);
		public var txtSilver:TextField = Functions.getTitledTextfield( 713, 8, 75, 22, new Art().fontName, 16, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.AUTO, -1);
		
		public function McTextCastleWinExtend() {
			Functions.SetPriteAtributs(this, false, true, 0, 0);
			this.addChild(this.txtGold);
			this.addChild(this.txtSilver);
			this.txtGold.filters = this.txtSilver.filters = [new GlowFilter(0, 1, 2, 2, 1, 1)];
		}
	}

}