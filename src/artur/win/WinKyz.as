package artur.win {
	import artur.App;
	import artur.display.BaseButton;
	import artur.display.KuznitsaChest;
	import artur.PrepareGr;
	import artur.RasterClip;
	import artur.util.Maker;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
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
	
	public class WinKyz {
		private var bg:Bitmap = RasterClip.raster(new mc_bg_kyz(), 800, 440);
		public var bin:Boolean = true;
		private var txt_stones:Array = [];
		private var btns_add:Array = [];
		private var btnStoneCreat:BaseButton;
		private var btnCraft:BaseButton;
		private var bgPrice:Sprite =  new Sprite();
		private var btnsInBg:Array = [];
		private var btnClosePrice:BaseButton = new BaseButton(31);
		public var chest:KuznitsaChest = new KuznitsaChest();
		public static var inst:WinKyz;
		public var timerStone:mcStones = new mcStones();
		public var timerText:TextField = Functions.getTitledTextfield(35, 4, 100, 25, new Art().fontName, 15, 0xFFFFFF, TextFormatAlign.LEFT, "00:00:00", 1, Kerning.ON, 1, true);
		private var timer:Timer;
		
		public function WinKyz() {
			var i:int
			var block:Sprite = new mcBlock();
			var index:int = 0;
			block.x = - 200;
			block.y = - 200;
			block.alpha = 0.5;
			btnClosePrice.x = 696;
			btnClosePrice.y = -7.4;
			bgPrice.addChild(block);
			bgPrice.addChild(Sprite(PrepareGr.creatBms(new bgStonePrice(), true)[0]));
			bgPrice.addChild(btnClosePrice);
			this.timerStone.scaleX = this.timerStone.scaleY = 0.8;
			WinKyz.inst = this;
			
			for ( i = 0; i < 3; i++) {
				for (var j:int = 0; j < 5; j++) {
					var txt:TextField = Maker.getTextField(35, 20, 0xFEEE96, false, false, false, 13);
					var btn:BaseButton = new BaseButton(44);
					txt.x = 30;
					txt.text = String(10 + i * 5);
					btn.addChild(txt);
					btn.x = i * 230 + btn.width/2;
					btn.y = j * 75 + btn.height/2;
					btn.name = String(index);
					btnsInBg[index] = btn;
					bgPrice.addChild(btn);
					
					
					
					txt = Maker.getTextField(35, 20, 0x0F0F0F, false, false, false, 13);
					txt.x = 20 + i * 70;
					txt.y = 74 + j * 40;
					txt.alpha = 1;
					txt_stones[index] =  txt;
					txt.filters = [App.btnOverFilter];
					btn = new BaseButton(41);
					btn.x = txt.x + 30;
					btn.y =  txt.y - 8;
					btn.name = index.toString();
					btn.addEventListener(MouseEvent.CLICK, this.onAddBtnClick);
					btn.visible = false;
					btns_add[index] = btn;
					index ++;
				}
			}
			
			btnStoneCreat = new BaseButton(43);
			btnCraft = new BaseButton(42);
			btnStoneCreat.x = 91.5;
			btnStoneCreat.y = 26.5;
			btnCraft.x = 410.15;
			btnCraft.y = 218.35;
			bgPrice.x = 60;
			bgPrice.y = 20;
			
			btnStoneCreat.addEventListener(MouseEvent.CLICK, onCreatStone);
			btnClosePrice.addEventListener(MouseEvent.CLICK, onClosePrice);
			this.btnCraft.addEventListener(MouseEvent.CLICK, onCraft);
		}
		
		private function onCraft(e:MouseEvent):void {
			if (this.chest.canCraft()) {
				if (UserStaticData.hero.gold > 4) {
					App.byeWin.init("Я хочу улушить", "Вещицу", 5, 0, NaN, 5, 0, NaN);
				} else {
					App.closedDialog.init(Lang.getTitle(42), false);
				}
				
			} else {
				App.closedDialog.init(Lang.getTitle(41), false);
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
				App.byeWin.init("Я хочу заказать", Lang.getTitle(43, stoneNum), 10 + int(stoneNum/5) * 5, 0, 0, 4, stoneNum);
			}
		}
		
		public function init():void {
			this.bin = true;
			App.spr.addChild(bg);
			for (var i:int = 0; i < txt_stones.length; i++) {
				App.spr.addChild(txt_stones[i]);
				App.spr.addChild(btns_add[i]);
				txt_stones[i].text = UserStaticData.hero.st[i];
				if(UserStaticData.hero.st[i] > 9) {
					BaseButton(btns_add[i]).visible = true;
					BaseButton(btns_add[i]).scaleX = 1;
				}
			}
			if(UserStaticData.hero.sz == null) {
				App.spr.addChild(btnStoneCreat);
			} else {
				this.checkStone();
			}
			App.spr.addChild(btnCraft);
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
					this.txt_stones[res.res.t].text = UserStaticData.hero.st[res.res.t];
					UserStaticData.hero.sz = null;
					if(this.timerStone.parent) {
						App.spr.removeChild(this.timerStone);
						App.spr.removeChild(this.timerText);
					}
					//give stone and addbutton;
					if(this.bin) {
						App.spr.addChildAt(this.btnStoneCreat, App.spr.numChildren - 1);
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
			this.bin = false;
			this.chest.frees();
			if(this.timer != null) {
				this.timer.stop();
				this.timer.removeEventListener(TimerEvent.TIMER, this.onTimer);
				this.timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
				this.timer = null;
			}
		}
		
		public function zakazKamnja(itemType:int):void {
			App.lock.init();
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, this.onRes);
			data.sendData(COMMANDS.GET_STONE, itemType.toString(), true);
		}
		
		public function craftItem():void {
			App.lock.init();
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, this.onCraftRes);
			data.sendData(COMMANDS.CRAFT_ITEM, JSON2.encode(this.chest.getCraftObj()), true);
		}
		
		public function turnStoneBtn(stoneNum:int):void {
			BaseButton(this.btns_add[stoneNum]).scaleX = 1;
		}
		
		private function onCraftRes(e:DataExchangeEvent):void {
			DataExchange(e.target).removeEventListener(DataExchangeEvent.ON_RESULT, this.onCraftRes);
			App.sound.playSound("craft", App.sound.onVoice, 1);
			var obj:Object = JSON2.decode(e.result);
			if (obj.res != null) {
				App.lock.frees();
				UserStaticData.hero.gold -= 5;
				obj = this.chest.getCraftObj();
				var item:Object = UserStaticData.hero.chest[obj["in"]];
				for(var key:Object in obj.gems) {
					var sn:int = obj.gems[key];
					var index:int = sn / 5;
					var sn2:int = sn - index * 5;
					index++;
					UserStaticData.hero.st[sn] -= 10;
					TextField(this.txt_stones[sn]).text = String(UserStaticData.hero.st[sn]);
					if(UserStaticData.hero.st[sn] < 9) {
						BaseButton(this.btns_add[sn]).visible = false;
					} else {
						BaseButton(this.btns_add[sn]).scaleX = 1;
					}
					if (item.c[sn2] != null) {
						item.c[sn2] += index;
					} else {
						item.c[sn2] = index;
					}
				}
				this.chest.removeCraft();
				
			} else {
				App.lock.init(obj.error);
			}
		};
		
		private function onRes(e:DataExchangeEvent):void {
			DataExchange(e.target).removeEventListener(DataExchangeEvent.ON_RESULT, this.onRes);
			var res:Object = JSON2.decode(e.result);
			if (res.error == null) {
				App.lock.frees();
				this.btnStoneCreat.parent.removeChild(this.btnStoneCreat);
				UserStaticData.hero.sz = res.res;
				this.addTimer();
			}else {
				App.lock.init(res.error);
			}
		}
		
	}

}