package artur.display {
	import artur.App;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Utils.Functions;
	
	public class CloseDialog extends dialogBye {
		private var btnEx:BaseButton;
		private var btnCastl:BaseButton;
		private var btnMision:BaseButton;
		private var btnBanK:BaseButton;
		private var txt:TextField = Functions.getTitledTextfield(315, 163, 183, 70, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.AUTO, 0, false, 2);
		private var spr:Sprite = new Sprite();
		private var btns:Array
		public function CloseDialog() {
			 btnEx = new BaseButton(11); btnEx.x = 507.9; btnEx.y = 258.75 - 100;
			 btnCastl = new BaseButton(32); //btnCastl.x = 411.2; btnCastl.y = 320.5;
			 btnBanK = new BaseButton(45);
			 btnMision = new BaseButton(46);
			 iconGold.visible = false
			 iconSilver.visible = false;
			 btnEx.addEventListener(MouseEvent.CLICK, onBtn);
			 this.addChild(btnEx);
			 this.addChild(this.txt);
			 this.txt.y += 20;
			 this.txt.height += 20;
			 btnCastl.addEventListener(MouseEvent.CLICK, onCastl);
			 btns = [btnCastl,btnBanK,btnMision];
		}
		
		private function onCastl(e:MouseEvent):void {
			App.winManajer.swapWin(1);
			frees();
		}
		
		private function onBtn(e:MouseEvent):void {
			frees();
		}
		
		public function init(text:String, showCastle:Boolean = false, showMision:Boolean = false,showBank:Boolean = true ):void 
		{
		     App.spr.addChild(this);
			 this.txt.text = text;
			 if (showCastle)
			 {
				 this.addChild(btnCastl);
			 }
			 var arr:Array = [showCastle, showBank, showMision];
			 while (spr.numChildren > 0)
			 spr.removeChildAt(0);
			 for (var i:int = 0; i < arr.length; i++) 
			 {
				 if (arr[i]) 
				 {
					 spr.addChild(btns[i]);
					 btns[i].x = 57 / 2 + i * 60;
				 }
			 }
			 this.addChild(spr);
			 spr.y = 320;
			 spr.x = 410 - spr.width / 2;
		}
		
		private function frees():void {
			
			if (parent) parent.removeChild(this);
        }
		
	}

}