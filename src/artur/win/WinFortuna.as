package artur.win 
{
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Server.Lang;
	import Utils.json.JSON2;
	import artur.App;
	import artur.display.BaseButton;
	import artur.display.MyBitMap;
	import artur.util.Numbs1;
	import com.greensock.easing.Circ;
	import com.greensock.easing.Cubic;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Utils.Functions;
	import flash.utils.Timer;
	import report.Report;
	
	public class WinFortuna extends Sprite {
		public var bin:Boolean = false;
		private var circle:Sprite = new Sprite();
		private var currStep:int = 0;
		private var arrow:mcFortuna = new mcFortuna();
		private var bgCircle:mcBgFortuna = new mcBgFortuna();
		private var bg:Bitmap;
		
		private var btnClose:BaseButton;
		private var btnDonate:BaseButton;
		private var btnFree:BaseButton;
		
		private var timer:Timer;
		private var is_free_lock:Boolean = false;
		public static var dt:int = -1;
		private var sp:int = 0;
		
		private var res:int;
		private static var NONE:int = 1;
		private static var GOLD:int = 2;
		private static var ENERGY:int = 3;
		private static var SILVER:int = 4;
		private var arr:Object = UserStaticData.fd;
		private var timerText:TextField = Functions.getTitledTextfield(35, 4, 100, 25, new Art().fontName, 16, 0xFFFFFF, TextFormatAlign.CENTER, "00:00:00", 1, Kerning.ON, 1, true);
		private var exitBtnText:TextField;
		private var freeBtnText:TextField;
		private var donateBtnText:TextField;
		private var animFortuna:mcFortunaAnim = new mcFortunaAnim();
		private var animFortunaText:TextField = Functions.getTitledTextfield( -42, -12.5, 84, 25, new Art().fontName, 16, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.ON, 1, true);;
		public static var dialogChecked:Boolean = false;
		
		
		public function WinFortuna() {
			this.tabEnabled = this.tabChildren = false;
			//circle.addChild();
			animFortuna.gotoAndStop(1);
			animFortuna.mc.gotoAndStop(1);
			animFortuna.x = 400;
		    animFortuna.y = 233;
			bg = new MyBitMap(App.prepare.cach[62]);
			btnClose = new BaseButton(63);
			btnFree = new BaseButton(64);
			btnDonate = new BaseButton(65);
			btnClose.x = 613.95;
			btnClose.y = 103;
			btnFree.x = 655.65;
			btnFree.y = 201.65;
			btnDonate.x = 665.95;
			btnDonate.y = 152;
			this.addChild(bg);
			this.addChild(btnClose);
			this.addChild(btnFree);
			this.addChild(btnDonate);
			this.addChild(bgCircle);
		//	bgCircle.rotation = 90;
			var f:GlowFilter = new GlowFilter(0x000000, 1, 3, 3, 2);
			for (var i:int = 0; i < 18; i++) {
				var slot:mcSlotRullet = new mcSlotRullet();
				circle.addChildAt(slot, 0);
				slot.rotation = i * 20;
				slot.gotoAndStop(arr[i].f)
				slot.cacheAsBitmap = true;
				if (slot.currentFrame != WinFortuna.NONE) {
					var txt:TextField =  Functions.getTitledTextfield( 148, -26.9, 51.5, 27, new Art().fontName, 24, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.AUTO, 0, false, 2);
				    txt.text = arr[i].n;
				    txt.rotation = 90;
				    slot.addChild(txt);
					txt.filters = [f];
					txt.cacheAsBitmap = true;
				}
			}
			this.bgCircle.x = 400;
			this.bgCircle.y = 233;
			this.bgCircle.addChild(circle);
			this.bgCircle.addChild(arrow);
			this.bgCircle.rotation = - 90;
			this.checkTime(false);
			this.addChild(this.timerText);
			this.timerText.y = 359 - this.timerText.height / 2;
			this.timerText.x = 659 - this.timerText.width / 2;
			this.exitBtnText = Functions.getTitledTextfield( -(this.btnClose.width) / 2 + 40, -this.btnClose.height / 2 + 7, this.btnClose.width - 43, 25, new Art().fontName, 18, 0xFFFFFF, TextFormatAlign.CENTER, Lang.getTitle(21), 1, Kerning.ON, 1, true);
			this.freeBtnText = Functions.getTitledTextfield( -(this.btnFree.width) / 2, -this.btnFree.height / 2 + 7, this.btnFree.width, 25, new Art().fontName, 18, 0xFFFFFF, TextFormatAlign.CENTER, Lang.getTitle(22), 1, Kerning.ON, 1, true);
			this.donateBtnText = Functions.getTitledTextfield( -(this.btnDonate.width) / 2, -this.btnDonate.height / 2 + 7, this.btnFree.width - 25, 25, new Art().fontName, 18, 0xFFFFFF, TextFormatAlign.CENTER, Lang.getTitle(22), 1, Kerning.ON, 1, true);
			this.animFortuna.mc.addChild(this.animFortunaText);
			this.btnClose.addChild(this.exitBtnText);
			this.btnDonate.addChild(this.donateBtnText);
			this.btnFree.addChild(this.freeBtnText);
			this.donateBtnText.filters = this.freeBtnText.filters = this.exitBtnText.filters = this.timerText.filters = [new GlowFilter(0x0,1,3,3,1)];
		}
		public function init(rot:int = 0 ):void {
			bin = true;
			this.circle.rotation = 1;
			App.spr.addChild(this);
			this.addEvents(true);
			App.topPanel.init(this);
			App.topMenu.init(true, true);
		}
		
		private function checkTime(state:Boolean):void {
			this.is_free_lock = state;
			if(is_free_lock) {
				App.lock.init();
			}
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, this.checkTimeRes);
			data.sendData(COMMANDS.GET_FORTUNA_TIMER, "", true);
		}
		
		private function checkTimeRes(e:DataExchangeEvent):void {
			var obj:Object = JSON2.decode(e.result);
			WinFortuna.dt = obj.res;
			this.updateFreeBtn();
			if(this.is_free_lock) {
				App.lock.frees();
			}
		}
		
		private function updateFreeBtn():void {
			if (dt > 0) {
				if(this.btnFree.parent!=null) {
					this.removeChild(this.btnFree);
				}
				if(this.timerText.parent == null) {
					this.addChild(this.timerText);
				}
				this.timer = new Timer(1000, WinFortuna.dt);
				this.timer.addEventListener(TimerEvent.TIMER, this.onTImer);
				this.timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTImerCmplt);
				this.timer.start();
			} else {
				if(!this.bin) {
					WinFortuna.dialogChecked = true;
				}
				if(this.timerText.parent != null) {
					this.removeChild(this.timerText);
				}
				this.addChild(this.btnFree);
			}
			
		}
		
		private function onTImerCmplt(e:TimerEvent):void {
			this.timer.removeEventListener(TimerEvent.TIMER, this.onTImer);
			this.timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTImerCmplt);
			this.timer = null;
			this.checkTime(this.parent != null);
		}
		
		private function onTImer(e:TimerEvent):void {
			WinFortuna.dt--;
			this.setTimeText(dt);
		}
		
		private function setTimeText(time:int):void {
			var h:int = time / 3600;
			time = time - h * 3600;
			var m:int = (time / 60);
			time = time - m * 60;
			this.timerText.text = "";
			if (h < 10) {
				this.timerText.appendText("0");
			}
			this.timerText.appendText(h.toString() + ":");
			if (m < 10) { 
				this.timerText.appendText("0");
			}
			this.timerText.appendText(m.toString()+":");
			if(time< 10) {
				this.timerText.appendText("0");
			}
			this.timerText.appendText(time.toString());
		}
		
		private function addEvents(state:Boolean):void {
			if(state) {
				this.btnFree.addEventListener(MouseEvent.CLICK, this.onSpinClick);
				this.btnDonate.addEventListener(MouseEvent.CLICK, this.onSpin2Click);
				this.btnClose.addEventListener(MouseEvent.CLICK, this.onExit);
			} else {
				this.btnFree.removeEventListener(MouseEvent.CLICK, this.onSpinClick);
				this.btnDonate.removeEventListener(MouseEvent.CLICK, this.onSpin2Click);
				this.btnClose.removeEventListener(MouseEvent.CLICK, this.onExit);
			}
			this.btnClose.setActive(state);
			this.btnDonate.setActive(state);
			this.btnFree.setActive(state);
		}
		
		private function onSpin2Click(e:MouseEvent):void {
			if (UserStaticData.hero.gold < 3) {
				App.closedDialog.init1(Lang.getTitle(45), false, true, true);
				return;
			}
			this.addEvents(false);
			this.sp = 3;
			this.spin(3);
		}
		
		private function onExit(e:MouseEvent):void {
			this.addEvents(false);
			App.winManajer.swapWin(App.winManajer.prevWin);
		}
		
		private function onSpinClick(e:MouseEvent):void {
			this.addEvents(false);
			this.sp = 0;
			this.spin(0);
		}
		
		private function spin(price:int):void {
			App.lock.init();
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, this.onSpinRes);
			data.sendData(COMMANDS.SPIN_FORTUNA, price.toString(), true);
		}
		
		private function onSpinRes(e:DataExchangeEvent):void {
			var res:Object = JSON2.decode(e.result);
			if (res.error == null) {
				var agle:int = Numbs1.RandomInt(-8, 8);
				TweenLite.to(this.circle, 3, { rotation : - (res.res * 20 + agle + 360), ease: Cubic.easeOut, onComplete:onSpinComplete });
				this.res = res.res;
				if(this.sp == 0) {
					WinFortuna.dt = 90 * 60;
					this.updateFreeBtn();
				} else {
					UserStaticData.hero.gold -= 3;
					App.topMenu.updateGold();
					
					App.sound.playSound('gold', App.sound.onVoice, 1);
				}
				App.lock.frees();
			} else {
				App.lock.init(res.error);
			}
		}
		
		private function onSpinComplete():void {
			this.addEvents(true);
			var obj:Object = arr[this.res];
			Report.addMassage(res + " res: " + JSON2.encode(obj));
			this.addChild(animFortuna);
			animFortuna.gotoAndPlay(1);
			
			if (obj.f == WinFortuna.NONE) {
				App.sound.playSound('fortuna_lose', App.sound.onVoice, 1);
				this.animFortunaText.width = 84;
				this.animFortunaText.text = Lang.getTitle(23);
				animFortuna.mc.gotoAndStop(1);
				
				//losesound
			} else {
				App.sound.playSound('fortuna_win', App.sound.onVoice, 1);
				this.animFortunaText.width = 60;
				this.animFortunaText.text = "+" + obj.n; 
				//winsound
				switch(obj.f) {
					case WinFortuna.ENERGY:
						UserStaticData.hero.cur_vitality += obj.n;
						App.topMenu.updateAva();
						animFortuna.mc.gotoAndStop(3);
						break;
					case WinFortuna.SILVER:
						UserStaticData.hero.silver += obj.n;
						animFortuna.mc.gotoAndStop(4);
						//App.sound.playSound('gold', App.sound.onVoice, 1);
						App.topMenu.updateGold();
						break;
					case WinFortuna.GOLD:
						animFortuna.mc.gotoAndStop(2);
						UserStaticData.hero.gold += obj.n;
						//App.sound.playSound('gold', App.sound.onVoice, 1);
						App.topMenu.updateGold();
						break;
				}
			}
		}
		
		public function update():void {
		
		}
		public function frees():void {
			if(this.bin) {
				App.spr.removeChild(this);
				bin = false;
			}
		}
		
	}

}