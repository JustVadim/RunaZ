package artur.display {
	import artur.App;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import report.Report;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Server.Lang;
	import Utils.Functions;
	import Utils.json.JSON2;
	public class Task extends mcGvest {
		private var close:BaseButton = new BaseButton(15);
		private var take:BaseButton = new BaseButton(33);
		private var progressText:TextField;

		private var titleText:TextField   = Functions.getTitledTextfield(302, 67, 200, 20, new Art().fontName, 17, 0xFBF199, TextFormatAlign.CENTER, "", 0.9);
		private var textText:TextField   = Functions.getTitledTextfield(302, 160, 200, 152, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.LEFT, "", 0.9);
		private var priceTitle:TextField  = Functions.getTitledTextfield(302, 313, 100, 20, new Art().fontName, 14,0xFBF199, TextFormatAlign.LEFT, "", 0.9);
		private var txtGold:TextField    = Functions.getTitledTextfield(420, 314, 50, 20, new Art().fontName, 13, 0xFBF199, TextFormatAlign.RIGHT, "", 1, Kerning.OFF, -1);
		private var preText:TextField    = Functions.getTitledTextfield(302, 95, 200, 60, new Art().fontName, 13, 0x4AFF4A, TextFormatAlign.CENTER, "", 0.9);

		public function Task() {
			Functions.SetPriteAtributs(this, true, true);
			this.close.x = this.take.x = 403;
			this.close.y = this.take.y = 376;
			
			this.addChild(this.progressText = Functions.getTitledTextfield(this.progress.x, this.progress.y - 4, 193, 18, new Art().fontName, 15, 0x77C1F9, TextFormatAlign.CENTER, "00000000", 0.9));
			this.progressText.filters = this.titleText.filters = this.textText.filters = this.priceTitle.filters = this.txtGold.filters = this.preText.filters = [new GlowFilter(0x0, 1, 2, 2)];
			Functions.compareAndSet(this.titleText, "Задание");
			Functions.compareAndSet(this.priceTitle, Lang.getTitle(153));
			this.textText.wordWrap = true;
			this.textText.multiline = true;
			this.preText.wordWrap = true;
			this.preText.multiline = true;
			this.addChild(this.titleText);
			this.addChild(this.textText);
			this.addChild(this.priceTitle);
			this.addChild(this.txtGold);
			this.addChild(this.preText);
		}
		
		public function init(isChat:Boolean = false):void {
			App.spr.addChild(this);
			if (UserStaticData.hero.t.tn != 0) {
				if(!isChat) {
					if(UserStaticData.hero.t.tp == 0) {
						//play new task sound
					} else {
						//play done task sound
					}
				} else {
					if(UserStaticData.hero.t.tp == UserStaticData.hero.t.pa) {
						//play done task sound
					}
				}
				if(UserStaticData.hero.t.tp != UserStaticData.hero.t.pa) {
					this.addChild(this.close);
					this.close.addEventListener(MouseEvent.CLICK, this.onClose);
					Functions.compareAndSet(this.preText, Lang.getTitle(int(UserStaticData.hero.t.tn) + 96, 0));
					Functions.compareAndSet(this.textText, Lang.getTitle(int(UserStaticData.hero.t.tn) + 96, 1));
				} else {
					this.addChild(this.take);
					this.take.addEventListener(MouseEvent.CLICK, this.onTake);
					Functions.compareAndSet(this.preText, Lang.getTitle(152));
					this.textText.text = "";
					
				}
				this.progress.gotoAndStop(1 + int((100 * UserStaticData.hero.t.tp) / UserStaticData.hero.t.pa));
				Functions.compareAndSet(this.progressText, UserStaticData.hero.t.tp + "/" + UserStaticData.hero.t.pa);
				Functions.compareAndSet(this.txtGold, UserStaticData.hero.t.pr);
			} else {
				this.frees();
			}
		}
		
		private function onTake(e:MouseEvent):void {
			App.lock.init();
			Main.THIS.chat.removeBtn();
			this.frees();
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, this.onTakeGold);
			data.sendData(COMMANDS.TAKE_TASK_GOLD, "", true);
		}
		
		private function onTakeGold(e:DataExchangeEvent):void {
			var res:Object = JSON2.decode(e.result);
			if (res.error == null) {
				UserStaticData.hero.gold = res.res;
				App.topMenu.updateGold();
				App.sound.playSound('gold', App.sound.onVoice, 1);
				App.lock.frees();
			} else {
				App.lock.init(res.error);
			}
		}
		
		private function onClose(e:MouseEvent):void {
			this.frees();
		}
		
		public function frees():void {
			if(this.parent) {
				this.parent.removeChild(this);
			}
			if(this.close.parent) {
				this.removeChild(this.close);
				this.close.removeEventListener(MouseEvent.CLICK, this.onClose);
			}
			if(this.take.parent) {
				this.removeChild(this.take);
				this.take.removeEventListener(MouseEvent.CLICK, this.onTake);
			}
		}
		
	}

}