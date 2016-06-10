package artur.win {
	import artur.App;
	import artur.display.AskGiftDialog;
	import artur.display.BaseButton;
	import artur.display.KuznitsaChest;
	import artur.PrepareGr;
	import artur.RasterClip;
	import artur.display.KyzChestStoneGraph;
	import artur.display.KyzProgress;
	import artur.display.KyzStone;
	import artur.util.Maker;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.geom.PerspectiveProjection;
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	import report.Report;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Server.Lang;
	import Utils.Functions;
	import Utils.json.JSON2;
	
	public class WinKyz extends Sprite {
		private var bg:Bitmap;
		public var chest:KuznitsaChest;
		public static var inst:WinKyz;
		public var bin:Boolean = false;
		public static var dt:int = -1;
		private var is_free_lock:Boolean = false;
		public var zakazBtns:Array = new Array();
		private var timerText:TextField = Functions.getTitledTextfield(38.65, 364, 485, 33, new Art().fontName, 20, 0xFFF642, TextFormatAlign.CENTER, "00:00:00", 1, Kerning.ON, 1, true);
		private var timerTextGift:TextField = Functions.getTitledTextfield(0, 0, 485, 33, new Art().fontName, 15, 0xFFF642, TextFormatAlign.CENTER, "00:00:00", 1, Kerning.ON, 1, true);
		private var timer:Timer;
		private var progress:KyzProgress;
		private var btnStone:BaseButton;
		public var askGiftDialog:AskGiftDialog;
		public var makeGiftDialog:AskGiftDialog;
		private var zakazBtnBg:Bitmap;
		private var giftStone:KyzChestStoneGraph;
		private var is_free_lock_gift:Boolean = false;
		private var timer2:Timer;
		public static var dt_gift:int;
		private var btnCraft:BaseButton;
		
		
		public function WinKyz() {
			WinKyz.inst = this;
			this.tabEnabled = false;
			this.tabChildren = false;
			this.bg = RasterClip.getBitmap(new mc_bg_kyz(), -1, -1);
			this.addChild(this.bg );
			this.chest = new KuznitsaChest();
			this.addChild(this.chest);
			for (var i:int = 1; i <= 5; i++) {
				var showSt:KyzStone = new KyzStone(i, 96.55, 50 * i - 22);
				this.zakazBtns[i] = showSt;
				showSt.showZakazBtn(false);
				showSt.setSt();
				this.addChild(showSt);
			}
			this.addChild(this.timerText);
			this.progress = new KyzProgress();
			this.checkTime(false);
			this.checkStoneGiftTime(false);
			this.timerText.filters = [new GlowFilter(0x0, 1, 4, 4, 2)];
			this.btnStone = new BaseButton(43);
			this.btnStone.x = 85.85;
			this.btnStone.y = 278.85
			this.askGiftDialog = new AskGiftDialog(0);
			this.makeGiftDialog = new AskGiftDialog(1);
			this.zakazBtnBg = RasterClip.getBitmap(new mcBtnBgStoneGift());
			this.zakazBtnBg.x = 23.65;
			this.zakazBtnBg.y = 301.45;
			this.addChild(zakazBtnBg);
			this.btnCraft = new BaseButton(42);
			this.btnCraft.x = 410.15;
			this.btnCraft.y = 218.35;
			this.btnCraft.addEventListener(MouseEvent.CLICK, this.onCraft);
			this.addChild(this.btnCraft);
		}
		
		private function checkStoneGiftTime(state:Boolean):void {
			this.is_free_lock_gift = state;
			if(is_free_lock_gift) {
				App.lock.init();
			}
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, this.onCheckStoneGiftRes);
			data.sendData(COMMANDS.CHECK_STONE_GIFT, "", true);
		}
		
		private function onCheckStoneGiftRes(e:DataExchangeEvent):void {
			DataExchange(e.target).removeEventListener(DataExchangeEvent.ON_RESULT, this.onCheckStone);
			var res:Object = JSON2.decode(e.result);
			if (res.error == null) { 
				WinKyz.dt_gift = res.res.tl;
				UserStaticData.hero.sg = res.res;
				this.updateGiftBtn();
				if(this.is_free_lock_gift) {
					App.lock.frees();
				}
			} else {
				App.lock.init(res.error);
			}
		}
		
		public function updateGiftBtn():void {
			if (WinKyz.dt_gift > 0) {
				if(this.btnStone.parent) {
					this.removeChild(this.btnStone);
				}
				this.timer2 = new Timer(1000, WinKyz.dt_gift);
				this.timer2.addEventListener(TimerEvent.TIMER, this.onTImerGift);
				this.timer2.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTImerCmpltGift);
				this.timer2.start();
				this.addChild(this.timerTextGift);
			} else {
				App.dialogManager.checkKyzGift();
				if(!this.btnStone.parent) {
					this.addChild(this.btnStone);
				}
				if(this.timerTextGift.parent) {
					this.removeChild(this.timerTextGift);
				}
			}
		}
		
		private function onTImerGift(e:TimerEvent):void {
			this.setTimeText(dt_gift, this.timerTextGift, true);
		}
		
		private function onTImerCmpltGift(e:TimerEvent):void {
			this.timer2.removeEventListener(TimerEvent.TIMER, this.onTImerGift);
			this.timer2.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTImerCmpltGift);
			this.timer2 = null;
			this.checkStoneGiftTime(this.parent != null);
		}
		
		private function checkTime(state:Boolean):void {
			this.is_free_lock = state;
			if(is_free_lock) {
				App.lock.init();
			}
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, this.onCheckStone);
			data.sendData(COMMANDS.CHECK_STONE, "", true);
		}
		
		
		private function onCheckStone(e:DataExchangeEvent):void {
			DataExchange(e.target).removeEventListener(DataExchangeEvent.ON_RESULT, this.onCheckStone);
			var res:Object = JSON2.decode(e.result);
			if (res.error == null) { 
				WinKyz.dt = res.res.tl;
				UserStaticData.hero.sz = res.res;
				if(res.res.tl == 0 && res.res.t != null) {
					UserStaticData.hero.st[res.res.t]++;
					KyzStone(this.zakazBtns[res.res.t + 1]).setSt();
				}
				this.updateZakazBtn();
				if(this.is_free_lock) {
					App.lock.frees();
				}
			} else {
				App.lock.init(res.error);
			}
		}
		
		private function updateZakazBtn():void {
			if (WinKyz.dt > 0) {
				for (var j:int = 1; j < 6; j++) {
					KyzStone(this.zakazBtns[j]).showZakazBtn(false);
				}
				this.progress.init(UserStaticData.hero.sz.t, this);
				this.addChild(this.timerText);
				this.setTimeText(dt,this.timerText);
				this.timer = new Timer(1000, WinKyz.dt);
				this.timer.addEventListener(TimerEvent.TIMER, this.onTImer);
				this.timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTImerCmplt);
				this.timer.start();
			} else {
				App.dialogManager.checkKyzZakaz();
				for (var i:int = 1; i < 6; i++) {
					KyzStone(this.zakazBtns[i]).showZakazBtn(true);
				}
				this.progress.frees();
				if(this.timerText.parent) {
					this.timerText.parent.removeChild(this.timerText);
				}
				
			}
		}
		
		private function onTImerCmplt(e:TimerEvent):void {
			this.timer.removeEventListener(TimerEvent.TIMER, this.onTImer);
			this.timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTImerCmplt);
			this.timer = null;
			this.checkTime(this.parent != null);
		}
		
		private function onTImer(e:TimerEvent):void {
			WinKyz.dt--;
			this.setTimeText(dt, this.timerText);
		}
		
		public function changeGiftStone():void {
			this.giftStone.frees();
			this.giftStone = KyzChestStoneGraph.getStone(UserStaticData.hero.sg.t, 70.5, 301, 0.9);
			this.addChild(this.giftStone);
		}
		
		private function setTimeText(time:int, tf:TextField, is_gift:Boolean = false):void {
			if(this.parent) {
				if(!is_gift) {
					this.progress.setTo(time);
				}
				if (this.parent ) {
					var h:int = time / 3600;
					time = time - h * 3600;
					var m:int = (time / 60);
					time = time - m * 60;
					tf.text = "";
					if (h < 10) {
						tf.appendText("0");
					}
					tf.appendText(h.toString() + ":");
					if (m < 10) { 
						tf.appendText("0");
					}
					tf.appendText(m.toString()+":");
					if (time < 10){
						tf.appendText("0");
					}
					tf.appendText(time.toString());
				}
			}
		}
		
		public function zakazKamnja(itemType:int):void {
			App.lock.init();
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, this.onRes);
			data.sendData(COMMANDS.GET_STONE, itemType.toString(), true);
		}
		
		private function onRes(e:DataExchangeEvent):void {
			DataExchange(e.target).removeEventListener(DataExchangeEvent.ON_RESULT, this.onRes);
			var res:Object = JSON2.decode(e.result);
			if (res.error == null) {
				App.lock.frees();
				UserStaticData.hero.sz = res.res;
				UserStaticData.hero.gold -= 2;
				App.topMenu.updateGold();
				WinKyz.dt = res.res.tl;
				this.updateZakazBtn();
			}else {
				App.lock.init(res.error);
			}
		}
		
		public function craftItem():void {
			App.lock.init();
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, this.onCraftRes);
			data.sendData(COMMANDS.CRAFT_ITEM, JSON2.encode(this.chest.getCraftObj()), true);
		}
		
		private function onCraftRes(e:DataExchangeEvent):void {
			DataExchange(e.target).removeEventListener(DataExchangeEvent.ON_RESULT, this.onCraftRes);
			App.sound.playSound("craft", App.sound.onVoice, 1);
			var obj:Object = JSON2.decode(e.result);
			if (obj.res != null) {
				App.lock.frees();
				UserStaticData.hero.gold -= 3;
				App.topMenu.updateGold();
				obj = this.chest.getCraftObj();
				var item:Object = UserStaticData.hero.chest[obj["in"]];
				
				for (var key:Object in obj.gems) {
					var sn:int = obj.gems[key];
					var ch:int = 0;
					var qty:int = 0;
					switch(sn) {
						case 0:
							ch = 0;
							qty = 5;
							break;
						case 1:
							ch = 3;
							qty = 1;
							break;
						case 2:
							ch = 4;
							qty = 1;
							break;
						case 3:
							ch = 1;
							qty = 5;
							break;
						case 4:
							ch = 2;
							qty = 1;
							break;
					}
					UserStaticData.hero.st[sn] -= 10;
					KyzStone(this.zakazBtns[sn + 1]).setSt();
					if (item.c[ch] != null) {
						item.c[ch] += qty;
					} else {
						item.c[ch] = qty;
					}
				}
				
				
				this.chest.removeCraft();
			} else {
				App.lock.init(obj.error);
			}
		}
		
		private function onCraft(e:MouseEvent):void {
			if (this.chest.canCraft()) {
				if (UserStaticData.hero.gold >= 3) {
					App.byeWin.init(Lang.getTitle(74), "Вещицу", 3, 0, NaN, 5, 0, NaN);
				} else {
					App.closedDialog.init1(Lang.getTitle(42),false, true, true);
				}
				
			} else {
				App.closedDialog.init1(Lang.getTitle(41), true, false, false);
			}
		}
		
		public function init():void {
			App.spr.addChild(this);
			App.topPanel.init(this);
			App.topMenu.init(false, true);
			this.chest.init();
			if(WinKyz.dt > 0) {
				this.setTimeText(dt, this.timerText);
			}
			this.giftStone = KyzChestStoneGraph.getStone(UserStaticData.hero.sg.t, 70.5, 301, 0.9);
			this.addChild(this.giftStone);
			this.btnStone.addEventListener(MouseEvent.CLICK, this.onMakeGift);
			this.btnStone.addEventListener(MouseEvent.ROLL_OVER, this.onMakeGiftOver);
			this.btnStone.addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
			this.btnCraft.addEventListener(MouseEvent.ROLL_OVER, this.onCraftOver);
			this.btnCraft.addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
			if(UserStaticData.hero.demo == 6) {
				App.tutor.init(14);
			}  else if (UserStaticData.hero.demo == 7) {
				App.tutor.init(19);
			} else if(UserStaticData.hero.level < 5 && UserStaticData.hero.gold >= 2 && WinKyz.dt == 0) {
				App.tutor.init(14);
			}
			
		}
			
		private function onMakeGiftOver(e:MouseEvent):void {
			App.info.init(this.btnStone.x + this.btnStone.width - 55, this.btnStone.y + this.btnStone.height-55, { txtInfo_w:120, txtInfo_h:37, txtInfo_t:Lang.getTitle(201) + Lang.getTitle(43, UserStaticData.hero.sg.t), type:0 } );
		}
		
		private function onRollOut(e:MouseEvent):void 
		{
			App.info.frees();
		}
		
		private function onCraftOver(e:MouseEvent):void {
			App.info.init(btnCraft.x + btnCraft.width - 35, btnCraft.y + btnCraft.height, { txtInfo_w:120, txtInfo_h:37, txtInfo_t:Lang.getTitle(53), type:0 } );
		}
		
		private function onMakeGift(e:MouseEvent):void {
			this.makeGiftDialog.init(UserStaticData.hero.sg.t);
			if(UserStaticData.hero.demo == 7) {
				UserStaticData.hero.demo = 8;
				App.tutor.frees();
				Report.addMassage("demo == 8");
			}
		}
		
		public function frees():void {
			if(this.parent) {
				App.spr.removeChild(this);
			}
			this.chest.frees();
			this.giftStone.frees();
			this.btnStone.removeEventListener(MouseEvent.CLICK, this.onMakeGift);
		}
		
		public function update():void {
			
		}
		
		public function turnStoneBtn(stoneNum:int):void 
		{
			KyzStone(this.zakazBtns[stoneNum]).turnStoneBtn()
		}
			
			
		
	}

}