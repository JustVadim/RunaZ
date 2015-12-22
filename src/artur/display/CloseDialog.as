package artur.display {
	import artur.App;
	import flash.events.MouseEvent;
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Utils.Functions;
	
	public class CloseDialog extends dialogBye {
		private var btnEx:BaseButton;
		private var btnCastl:BaseButton;
		private var txt:TextField = Functions.getTitledTextfield(315, 163, 183, 70, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.AUTO, 0, false);
		
		
		public function CloseDialog() {
			 btnEx = new BaseButton(11); btnEx.x = 507.9; btnEx.y = 258.75 - 100;
			 btnCastl = new BaseButton(32); btnCastl.x = 411.2; btnCastl.y = 320.5;
			 iconGold.visible = false
			 iconSilver.visible = false;
			 btnEx.addEventListener(MouseEvent.CLICK, onBtn);
			 this.addChild(btnEx);
			 this.addChild(this.txt);
			 this.txt.y += 20;
			 this.txt.height += 20;
			 btnCastl.addEventListener(MouseEvent.CLICK, onCastl);
		}
		
		private function onCastl(e:MouseEvent):void {
			App.winManajer.swapWin(1);
			frees();
		}
		
		private function onBtn(e:MouseEvent):void {
			frees();
		}
		
		public function init(text:String,showCastle:Boolean = false):void {
		     App.spr.addChild(this);
			 this.txt.text = text;
			 if (showCastle)
			 {
				 this.addChild(btnCastl);
			 }
		}
		
		private function frees():void {
			if (this.contains(btnCastl)) this.removeChild(btnCastl);
			if (parent) parent.removeChild(this);
        }
		
	}

}