package artur.win {
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Server.Lang;
	import Utils.Functions;
	import Utils.json.JSON2;
	import artur.App;
	import artur.display.BaseButton;
	import flash.display.Sprite;
	import artur.RasterClip;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.text.engine.Kerning;
	import flash.utils.Timer;
	import report.Report;
	public class WinCave extends Sprite {
		public var bin:Boolean;
		private var bg:Bitmap;
		private var take:BaseButton;
		private var nextFight:BaseButton;
		private var cave_load:caveLoader;
		private var timerBg:Bitmap;
		
		private var nextF_text:TextField = Functions.getTitledTextfield( -25, 6, 35, 16, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.RIGHT, "6", 1, Kerning.AUTO, 0, false, 2);
		private var take_text:TextField = Functions.getTitledTextfield( -25, 6, 35, 16, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.RIGHT, "6", 1, Kerning.AUTO, 0, false, 2);
		private var next_title:TextField = Functions.getTitledTextfield( -45, 40, 96, 18, new Art().fontName, 14, 0xFFFFFF, TextFormatAlign.CENTER, Lang.getTitle(204), 1, Kerning.AUTO, 0, false, 2);
		private var timerText:TextField = Functions.getTitledTextfield(225, 292, 350, 20, new Art().fontName, 13, 0xFFF642, TextFormatAlign.CENTER, "00:00:00", 1, Kerning.ON, 1, true);;
		private var time:Timer;
		public static var dt:int;
		public static var inst:WinCave;
		
		public function WinCave() {
			WinCave.inst = this;
			this.bin = false;
			this.tabEnabled = this.tabChildren = false;
			this.bg = RasterClip.getBitmap(new mcCaveWin());
			this.take = new BaseButton(74);
			this.take.x = 273.55;
			this.take.y = 297.95;
			this.nextFight = new BaseButton(75);
			this.nextFight.x = 526.6;
			this.nextFight.y = 286.65;
			this.addChild(this.bg);
			this.addChild(this.cave_load = new caveLoader());
			Functions.SetPriteAtributs(this.cave_load, false, false, 253.2, 153.2);
			this.cave_load.gotoAndStop(1);
			this.timerBg = RasterClip.getBitmap(new mcCaveTimerBg());
			this.timerBg.x = 322.85;
			this.timerBg.y = 238.35;
			this.take.addChild(this.take_text);
			this.nextFight.addChild(this.next_title);
			this.updateBtns();
			this.timerText.filters = [new GlowFilter(0x0, 1, 3, 3)];
		}
		
		public function updateBtns():void {
			WinCave.dt = UserStaticData.caveInfo.tl;
			if(WinCave.dt == 0) {
				if(this.timerBg.parent) {
					this.removeChild(this.timerBg);
				}
				if(this.timerText.parent) {
					this.removeChild(this.timerText);
				}
				
				if(UserStaticData.caveInfo.cn < 29) {
					this.addChild(this.nextFight);
					this.nextFight.addEventListener(MouseEvent.CLICK, this.onNextClick);
					this.nextFight.addChild(this.nextF_text);
					this.nextF_text.x = -25;
					this.nextF_text.y = 6;
					Functions.compareAndSet(this.nextF_text, String(3 + 3 * int(UserStaticData.caveInfo.cn / 3)))
				} else {
					if(this.nextFight.parent) {
						this.removeChild(this.nextFight)
					}
					if(this.nextF_text.parent) {
						this.nextF_text.parent.removeChild(this.nextF_text);
					}
				}
				if (UserStaticData.caveInfo.cn % 3 == 0 && UserStaticData.caveInfo.cn != 0) {
					this.addChild(this.take);
					Functions.compareAndSet(this.take_text, String(UserStaticData.caveInfo.cn));
				} else {
					if(this.take.parent) {
						this.removeChild(this.take);
					}
				}
			} else {
				this.nextF_text.x = 502;
				this.nextF_text.y = 293;
				this.addChild(this.nextF_text);
				Functions.compareAndSet(this.nextF_text, String(3 + 3*int(UserStaticData.caveInfo.cn/3)))
				if(this.take.parent) {
					this.removeChild(this.take);
				}
				if(this.nextFight.parent) {
					this.removeChild(this.nextFight);
				}
				this.addChild(this.timerBg);
				this.addChild(this.timerText);
				this.time = new Timer(1000, WinCave.dt);
				this.time.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerCmplt);
				this.time.addEventListener(TimerEvent.TIMER, this.onTimer);
				this.time.start();
			}
		}
		
		private function onTimer(e:TimerEvent):void {
			WinCave.dt--;
			this.setTimeText(WinCave.dt);
		}
		
		private function onTimerCmplt(e:TimerEvent):void {
			this.time.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerCmplt);
			this.time.removeEventListener(TimerEvent.TIMER, this.onTimer);
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, this.onGetCaveInfoRes);
			data.sendData(COMMANDS.GET_CAVE_INFO, "", true);
		}
		
		private function onGetCaveInfoRes(e:DataExchangeEvent):void {
			DataExchange(e.target).removeEventListener(e.type, this.onGetCaveInfoRes);
			UserStaticData.caveInfo = JSON2.decode(e.result);
			this.updateBtns();
		}
		
		private function onNextClick(e:MouseEvent):void {
			App.lock.init();
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, this.onResult);
			data.sendData(COMMANDS.CREATE_CAVE_BATTLE, "", true);
		}
		
		private function onResult(e:DataExchangeEvent):void {
			DataExchange(e.target).removeEventListener(e.type, onResult);
			var obj:Object = JSON2.decode(e.result);
			if (obj.error == null) {
				UserStaticData.hero.mbat = obj.res;
				UserStaticData.hero.bat = obj.res.id;
				App.lock.frees();
				App.winManajer.swapWin(3);
			} else {
				if (obj.error == 1) {
					App.lock.frees();	
					App.closedDialog.init1(Lang.getTitle(37), false);
				} else {
					App.lock.init('Error: ' + obj.error)
				}
			}
		}
		
		public function init():void {
			this.bin = true;
			App.spr.addChild(this);
			App.topMenu.init(true, true);
			App.topPanel.init(this);
			if (WinCave.dt == 0) {
				
			}
		}
		
		public function frees():void {
			if(this.bin) {
				this.bin = false;
				App.spr.removeChild(this);
			}
		}
		
		public function update():void {
			if(this.bin) {
				
			}
		}
		
		private function setTimeText(time:int):void {
			if(this.parent) {
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
		}
		
		
	}

}