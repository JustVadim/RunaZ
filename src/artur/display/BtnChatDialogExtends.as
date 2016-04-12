package artur.display 
{
	import Utils.Functions;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	public class BtnChatDialogExtends extends btnChatDialog {
		private var title:TextField = Functions.getTitledTextfield(0, 2, 93, 18.2, new Art().fontName, 10, 0xFFCC99, TextFormatAlign.CENTER, "", 1);
		public function BtnChatDialogExtends(str:String) {
			this.addChild(this.title)
			this.title.text = str;
		}
	}

}