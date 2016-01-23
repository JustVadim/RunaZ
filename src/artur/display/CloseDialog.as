package artur.display {
	import artur.App;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import report.Report;
	import Server.Lang;
	import Utils.Functions;
	
	public class CloseDialog extends dialogBye {
		private var btnEx:BaseButton;
		private var btnCastl:BaseButton;
		private var btnMision:BaseButton;
		private var btnBanK:BaseButton;
		private var txt:TextField = Functions.getTitledTextfield(315, 163, 183, 0, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.AUTO, 0, false, 2);
		private var spr:Sprite = new Sprite();
		private var btns:Array
		public function CloseDialog() {
			btnEx = new BaseButton(11); btnEx.x = 507.9; btnEx.y = 258.75 - 100;
			btnCastl = new BaseButton(32);
			btnBanK = new BaseButton(45);
			btnMision = new BaseButton(46);
			iconGold.visible = false
			iconSilver.visible = false;
			this.txt.wordWrap = true;
			this.addChild(btnEx);
			this.addChild(this.txt);
			this.txt.y += 0;
			this.btns = [btnCastl, btnBanK, btnMision];
			this.spr.y = 310;
			this.btnEx.addEventListener(MouseEvent.CLICK, onBtn);
			this.btnCastl.addEventListener(MouseEvent.CLICK, onBtn);
			this.btnBanK.addEventListener(MouseEvent.CLICK, onBtn);
			this.btnMision.addEventListener(MouseEvent.CLICK, onBtn);
			this.btnEx.addEventListener(MouseEvent.ROLL_OVER, onBtnOver);
			this.btnCastl.addEventListener(MouseEvent.ROLL_OVER, onBtnOver);
			this.btnBanK.addEventListener(MouseEvent.ROLL_OVER, onBtnOver);
			this.btnMision.addEventListener(MouseEvent.ROLL_OVER, onBtnOver);
			this.btnEx.addEventListener(MouseEvent.ROLL_OUT, onOut);
			this.btnCastl.addEventListener(MouseEvent.ROLL_OUT, onOut);
			this.btnBanK.addEventListener(MouseEvent.ROLL_OUT, onOut);
			this.btnMision.addEventListener(MouseEvent.ROLL_OUT, onOut);
			this.init(Lang.getTitle(46), false, false, false);
			this.frees();
			
		}
		
		private function onOut(e:MouseEvent):void 
		{
			App.info.frees();
		}
		
		private function onBtnOver(e:MouseEvent):void {
			var mc:BaseButton = BaseButton(e.currentTarget);
			switch(mc) {
				case this.btnEx:
					App.info.init(mc.x + mc.width, mc.y + mc.height, { txtInfo_w:100, txtInfo_h:37, txtInfo_t:Lang.getTitle(47), type:0 });
					break;
				case this.btnCastl:
					App.info.init(mc.x + mc.width  + spr.x, mc.y + mc.height  + spr.y, { txtInfo_w:100, txtInfo_h:37, txtInfo_t:Lang.getTitle(3,2), type:0 });
					break;
				case this.btnBanK:
					App.info.init(mc.x + mc.width+spr.x, mc.y + mc.height + spr.y, { txtInfo_w:100, txtInfo_h:37, txtInfo_t:Lang.getTitle(3,0), type:0 });
					break;
				case btnMision:
					App.info.init(mc.x + mc.width + spr.x, mc.y + mc.height + spr.y, { txtInfo_w:100, txtInfo_h:37, txtInfo_t:Lang.getTitle(3,5), type:0 });
					break;
			}
		}
		
		private function onBtn(e:MouseEvent):void {
			var mc:BaseButton = BaseButton(e.currentTarget);
			switch(mc) {
				case this.btnEx:
					this.frees();
					break;
				case this.btnCastl:
					App.winManajer.swapWin(1);
					this.frees();
					break;
				case this.btnBanK:
					App.winBank.init();
					this.frees();
					break;
				case btnMision:
					App.winManajer.swapWin(2);
					this.frees();
					break;
			}
			
		}
		
		public function init(text:String, showCastle:Boolean = false, showMision:Boolean = false, showBank:Boolean = false):void {
			App.sound.playSound('inventar', App.sound.onVoice, 1);
			App.spr.addChild(this);
			this.txt.text = text;
			var arr:Array = [showCastle, showBank, showMision];
			while (spr.numChildren > 0) {
				spr.removeChildAt(0);
			}
			var count:int = 0;
			for (var i:int = 0; i < arr.length; i++) {
				if (arr[i] == true) {
					spr.addChild(btns[i]);
					btns[i].x = 57 / 2 + count * 60;
					count++;
				}
			}
			this.txt.height = 18 * this.txt.numLines;
			this.txt.y = 163 + (110 - this.txt.height) / 2;
			spr.x = 410 - spr.width / 2;
			this.addChild(spr);
		}
		
		private function frees():void {
			if (parent) parent.removeChild(this);
        }
		
	}

}