package artur.display {
	import artur.App;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
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
		private var btnEnergy:BaseButton;
		private var txt:TextField = Functions.getTitledTextfield(315, 163, 183, 0, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.AUTO, 0, false, 2);
		private var spr:Sprite = new Sprite();
		private var btns:Array;
		
		public function CloseDialog() {
			
			this.btnEx = new BaseButton(11); btnEx.x = 507.9; btnEx.y = 258.75 - 100;
			this.btnCastl = new BaseButton(32);
			this.btnBanK = new BaseButton(45);
			this.btnMision = new BaseButton(46);
			this.btnEnergy = new BaseButton(50);
			this.iconGold.visible = false
			this.iconSilver.visible = false;
			this.txt.wordWrap = true;
			this.addChild(btnEx);
			this.addChild(this.txt);
			this.txt.y += 0;
			this.btns = [this.btnCastl, this.btnBanK, this.btnMision, this.btnEnergy];
			this.spr.y = 310;
			this.addChild(this.spr);
			this.txt.filters = [new GlowFilter(0x0, 1, 2, 2)];
			this.init1(Lang.getTitle(46), false, false, false, false, false);
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
				case btnEnergy:
					App.info.init(mc.x + mc.width + spr.x, mc.y + mc.height + spr.y, { txtInfo_w:100, txtInfo_h:37, txtInfo_t:Lang.getTitle(162), type:0 });
					break;
			}
		}
		
		private function onBtn(e:MouseEvent):void {
			var mc:BaseButton = BaseButton(e.currentTarget);
			switch(mc) {
				case this.btnEx:
					this.frees();
					App.dialogManager.canShow();
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
				case btnEnergy:
					App.byeWin.init("Я хочу пополнить", "энергию", GameVars.ENERGY_PRICE, 0, NaN, 6);
					this.frees();
					break;
			}
			
		}
		
		public function init1(text:String, showCastle:Boolean = false, showMision:Boolean = false, showBank:Boolean = false, showEnergy:Boolean = false, playSoung:Boolean = true):void {
			if(playSoung) {
				App.sound.playSound('inventar', App.sound.onVoice, 1);
			}
			while (spr.numChildren > 0) {
				spr.removeChildAt(0);
			}
			Functions.compareAndSet(this.txt, text);
			var arr:Array = [showCastle, showBank, showMision, showEnergy];
			this.addBtnsEvents(this.btnEx);
			var count:int = 0;
			for (var i:int = 0; i < arr.length; i++) {
				if (arr[i] == true) {
					spr.addChild(btns[i]);
					this.addBtnsEvents(this.btns[i]);
					btns[i].x = 57 / 2 + count * 60;
					count++;
				}
			}
			this.txt.height = 18 * this.txt.numLines;
			this.txt.y = 163 + (110 - this.txt.height) / 2;
			spr.x = 410 - spr.width / 2;
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
			App.spr.addChild(this);
		}
		
		private function addBtnsEvents(mc:BaseButton):void {
			mc.addEventListener(MouseEvent.CLICK, onBtn);
			mc.addEventListener(MouseEvent.ROLL_OVER, onBtnOver);
			mc.addEventListener(MouseEvent.ROLL_OUT, onOut);
		}
		
		private function onRemovedFromStage(e:Event):void {
			this.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
		}
		
		private function removeBtnsEvents(mc:BaseButton):void {
			Report.addMassage("sdfsdf");
			mc.removeEventListener(MouseEvent.CLICK, onBtn);
			mc.removeEventListener(MouseEvent.ROLL_OVER, onBtnOver);
			mc.removeEventListener(MouseEvent.ROLL_OUT, onOut);
		}
		
		private function frees():void {
			if (parent) {
				parent.removeChild(this);
				this.removeBtnsEvents(this.btnEx);
				for (var i:int = 0; i < this.btns.length; i++) {
					if(BaseButton(this.btns[i]).parent !=null) {
						this.removeBtnsEvents(BaseButton(this.btns[i]));
					}
				}
				App.info.frees();
			}
        }
		
	}

}