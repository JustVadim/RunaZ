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
			//this.addChild(btnStone);
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
			
			
			
			/*var i:int
			var block:Sprite = new mcBlock();
			var index:int = 0;
			block.x = - 200;
			block.y = - 200;
			block.alpha = 0.5;
			btnClosePrice.x = 696;
			btnClosePrice.y = -7.4;
			bgPrice.addChild(block);
			bgPrice.addChild(RasterClip.getMovedBitmap(new bgStonePrice()));
			//Sprite(PrepareGr.creatBms(new bgStonePrice(), true)[0]));
			bgPrice.addChild(btnClosePrice);
			this.timerStone.scaleX = this.timerStone.scaleY = 0.8;
			WinKyz.inst = this;
			
			for ( i = 0; i < 3; i++) {
				for (var j:int = 0; j < 5; j++) {
					var txt:TextField = Maker.getTextField(35, 20, 0xFDDF35, false, false, false, 13);
					var btn:BaseButton = new BaseButton(44);
					txt.x = 30;
					txt.text = String(2 + i);
					btn.addChild(txt);
					btn.x = i * 230 + btn.width/2;
					btn.y = j * 75 + btn.height/2;
					btn.name = String(index);
					btnsInBg[index] = btn;
					bgPrice.addChild(btn);
					btn.addEventListener(MouseEvent.ROLL_OVER, this.onMagStoneOver);
					btn.addEventListener(MouseEvent.ROLL_OUT, this.onMagStoneOut);
					
					txt = Maker.getTextField(35, 20, 0x0F0F0F, false, false, false, 13);
					txt.x = 20 + i * 70;
					txt.y = 74 + j * 40;
					txt.alpha = 1;
					//txt_stones[index] =  txt;
					txt.filters = [App.btnOverFilter];
					btn = new BaseButton(41);
					btn.x = txt.x + 30;
					btn.y =  txt.y - 8;
					btn.name = index.toString();
					btn.addEventListener(MouseEvent.CLICK, this.onAddBtnClick);
					btn.addEventListener(MouseEvent.ROLL_OVER, this.onAddBtnOver);
					btn.addEventListener(MouseEvent.ROLL_OUT, this.onAddBtnOut);
					btn.visible = false;
					btns_add[index] = btn;
					index ++;
				}
			}
			
			
			bgPrice.x = 60;
			bgPrice.y = 20;
			
			
			this.btnCraft.addEventListener(MouseEvent.ROLL_OVER, this.onBtnOver);
			this.btnCraft.addEventListener(MouseEvent.ROLL_OUT, this.onBtnOut);
			this.btnCraft.addEventListener(MouseEvent.CLICK, onCraft);
			
						
			this.btnClosePrice.addEventListener(MouseEvent.ROLL_OVER, this.onBtnClosePrice);
			this.btnClosePrice.addEventListener(MouseEvent.ROLL_OUT, this.onBtnOut);
			this.btnClosePrice.addEventListener(MouseEvent.CLICK, onClosePrice);*/
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
		
		/*private function onBtnClosePrice(e:MouseEvent):void {
			var mc:BaseButton = BaseButton(e.target);
			App.info.init(mc.x - 45, mc.y + 30, { txtInfo_w:70, txtInfo_h:37, txtInfo_t:Lang.getTitle(47), type:0} );
		}
		
		private function onMagStoneOut(e:MouseEvent):void {
			App.info.frees();
		}
		
		private function onMagStoneOver(e:MouseEvent):void {
			var mc:BaseButton = BaseButton(e.target);
			App.info.init(mc.x-90, mc.y + mc.height, { txtInfo_w:300, txtInfo_h:37, txtInfo_t:Lang.getTitle(59, int(mc.name)), type:0, title: Lang.getTitle(43, int(mc.name)) } );
		}
		
		private function onAddBtnOut(e:MouseEvent):void 
		{
			App.info.frees();
		}
		
		private function onAddBtnOver(e:MouseEvent):void {
			var mc:BaseButton = BaseButton(e.target);
			if(mc.scaleX == 1) {
				App.info.init(mc.x + mc.width + 15, mc.y + mc.height, { txtInfo_w:300, txtInfo_h:37, txtInfo_t:Lang.getTitle(54) + "\n" + Lang.getTitle(58, int(mc.name)), type:0, title: Lang.getTitle(43, int(mc.name))} );
			} else {
				App.info.init(mc.x + mc.width + 15, mc.y + mc.height, { txtInfo_w:300, txtInfo_h:37, txtInfo_t:Lang.getTitle(57) + "\n" + Lang.getTitle(58, int(mc.name)),title:Lang.getTitle(43, int(mc.name)), type:0 } );
			}
		}
		
		private function onBtnOut(e:MouseEvent):void 
		{
			App.info.frees();
		}
		
		private function onBtnOver(e:MouseEvent):void 
		{
			var mc:BaseButton = BaseButton(e.target);
			switch(mc) {
				case this.btnCraft:
					App.info.init(mc.x + mc.width - 35, mc.y + mc.height, { txtInfo_w:100, txtInfo_h:37, txtInfo_t:Lang.getTitle(53), type:0 } );
					break;
			}
		}
		
		
		
		private function onAddBtnClick(e:MouseEvent):void 
		{
			if(BaseButton(e.target).scaleX == 1){
				if (this.chest.addSoneToCraft(int(e.target.name))) {
					BaseButton(e.target).scaleX = -1;
					App.sound.playSound("stone", App.sound.onVoice, 1);
				}
			} else {
				this.chest.removeStoneFromCraft(int(e.target.name));
			}
		}
		
		private function onClosePrice(e:MouseEvent = null):void 
		{
			for (var i:int = 0; i < btnsInBg.length; i++) {
				BaseButton(this.btnsInBg[i]).removeEventListener(MouseEvent.CLICK, this.onBtnsInBgClick);
			}
			App.spr.removeChild(bgPrice);
		}
		
		private function onCreatStone(e:MouseEvent):void 
		{
			App.spr.addChild(bgPrice);
			for (var i:int = 0; i < btnsInBg.length; i++) {
				BaseButton(this.btnsInBg[i]).addEventListener(MouseEvent.CLICK, this.onBtnsInBgClick);
			}
		}
		
		private function onBtnsInBgClick(e:MouseEvent):void {
			this.onClosePrice();
			var stoneNum:int = int(e.target.name);
			if (true) {
				App.byeWin.init(Lang.getTitle(75), Lang.getTitle(43, stoneNum), 2 + int(stoneNum/5), 0, 0, 4, stoneNum);
			}
		}
		
		public function init():void {
			this.bin = true;
			App.spr.addChild(bg);
			/*for (var i:int = 0; i < txt_stones.length; i++) {
				//App.spr.addChild(txt_stones[i]);
				App.spr.addChild(btns_add[i]);
				//txt_stones[i].text = UserStaticData.hero.st[i];
				if(UserStaticData.hero.st[i] > 9) {
					BaseButton(btns_add[i]).visible = true;
					BaseButton(btns_add[i]).scaleX = 1;
				}
			}*/
			/*if(UserStaticData.hero.sz == null) {
				
			} else {
				this.checkStone();
			}
			App.spr.addChild(btnCraft);
			App.topMenu.init(false, true);
			this.chest.init();
			App.topPanel.init(this);
			
		}
		
		private function checkStone():void {
			App.lock.init();
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, this.onCheckStone);
			data.sendData(COMMANDS.CHECK_STONE, "", true);
		}
		
		private function onCheckStone(e:DataExchangeEvent):void 
		{
			DataExchange(e.target).removeEventListener(DataExchangeEvent.ON_RESULT, this.onCheckStone);
			var res:Object = JSON2.decode(e.result);
			if(res.error == null) {
				App.lock.frees();
				if (res.res.tl > 0 ) {
					UserStaticData.hero.sz = res.res;
					if(this.bin) {
						this.addTimer();
					}
				} else {
					UserStaticData.hero.st[res.res.t]++;
					UserStaticData.hero.sz = null;
					if(this.timerStone.parent) {
						App.spr.removeChild(this.timerStone);
						App.spr.removeChild(this.timerText);
					}
					//give stone and addbutton;
					if(this.bin) {
						if(UserStaticData.hero.st[res.res.t]>9) {
							BaseButton(this.btns_add[res.res.t]).visible = true;
						}
					}
				}
			} else {
				App.lock.init(res.error);
			}
		}
		
		private function addTimer():void {
			if(this.timerStone.parent == null) {
				App.spr.addChildAt(this.timerStone, App.spr.numChildren - 1);
				App.spr.addChildAt(this.timerText, App.spr.numChildren - 1);
				this.timerStone.gotoAndStop(UserStaticData.hero.sz.t +1);
			}
			this.timer = new Timer(1000, UserStaticData.hero.sz.tl + 1);
			this.setTimeText(int(UserStaticData.hero.sz.tl + 1));
			this.timer.addEventListener(TimerEvent.TIMER, onTimer);
			this.timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			this.timer.start();
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
		
		private function onTimerComplete(e:TimerEvent):void 
		{
			this.timer.removeEventListener(TimerEvent.TIMER, this.onTimer);
			this.timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
			this.timer = null;
			this.checkStone();
		}
		
		private function onTimer(e:TimerEvent):void {
			this.setTimeText(int((this.timer.repeatCount - this.timer.currentCount)));
		}
		
		public function update():void
		{
			
		}
		
		public function frees():void
		{
			App.info.frees();
			this.bin = false;
			this.chest.frees();
			if(this.timer != null) {
				this.timer.stop();
				this.timer.removeEventListener(TimerEvent.TIMER, this.onTimer);
				this.timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
				this.timer = null;
			}
		}
		
		
		
		
		
		
		

		
		private function onRes(e:DataExchangeEvent):void {
			DataExchange(e.target).removeEventListener(DataExchangeEvent.ON_RESULT, this.onRes);
			var res:Object = JSON2.decode(e.result);
			if (res.error == null) {
				App.lock.frees();
				UserStaticData.hero.sz = res.res;
				UserStaticData.hero.gold -= (2 + (int(res.res.t / 5)));
				App.topMenu.updateGold();
				this.addTimer();
			}else {
				App.lock.init(res.error);
			}
		}*/
		
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
			}
			
			private function onMakeGift(e:MouseEvent):void {
				this.makeGiftDialog.init(UserStaticData.hero.sg.t);
			}
			
			public function frees():void {
				if(this.parent) {
					App.spr.removeChild(this);
				}
				this.chest.frees();
				this.giftStone.frees();
			}
			
			public function update():void {
				
			}
			
			public function turnStoneBtn(stoneNum:int):void 
			{
				KyzStone(this.zakazBtns[stoneNum]).turnStoneBtn()
			}
			
			
		
	}

}