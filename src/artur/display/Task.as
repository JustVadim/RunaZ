package artur.display {
	import artur.App;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
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
		private var titleText:TextField = Functions.getTitledTextfield(302, 69, 200, 20, new Art().fontName, 16,0xEFE076, TextFormatAlign.CENTER, "", 0.9);
		private var textText:TextField = Functions.getTitledTextfield(302, 100, 200, 214, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.LEFT, "", 0.9);
		public function Task() {
			Functions.SetPriteAtributs(this, true, true);
			this.close.x = this.take.x = 403;
			this.close.y = this.take.y = 376;
			
			this.addChild(this.progressText = Functions.getTitledTextfield(this.progress.x, this.progress.y - 4, 193, 18, new Art().fontName, 15, 0xFFFFFF, TextFormatAlign.CENTER, "00000000", 0.9));
			this.progressText.filters = this.titleText.filters = this.textText.filters = [new GlowFilter(0x0, 1, 2, 2)];
			Functions.compareAndSet(this.titleText, "Задание");
			this.textText.wordWrap = true;
			this.textText.multiline = true;
			this.addChild(this.titleText);
			this.addChild(this.textText);
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
					Functions.compareAndSet(this.textText, Lang.getTitle(int(UserStaticData.hero.t.tn) + 96));
				} else {
					this.addChild(this.take);
					this.take.addEventListener(MouseEvent.CLICK, this.onTake);
					Functions.compareAndSet(this.textText, Lang.getTitle(152));
					
				}
				this.progress.gotoAndStop(1 + (100 * UserStaticData.hero.t.tp) / UserStaticData.hero.t.pa);
				Functions.compareAndSet(this.progressText, UserStaticData.hero.t.tp + "/" + UserStaticData.hero.t.pa);
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
		}
		
	}

}