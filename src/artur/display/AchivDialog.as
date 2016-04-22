package artur.display  {
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Server.Lang;
	import Utils.Functions;
	import Utils.json.JSON2;
	import artur.App;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.text.engine.Kerning;
	import report.Report;
	
	
	public class AchivDialog extends dialogAchiv {
		private var btn:BaseButton = new BaseButton(33);
		private var title:TextField = Functions.getTitledTextfield(300, 113, 195, 28, new Art().fontName, 20, 0xFFF642, TextFormatAlign.CENTER, "Достижения", 1, Kerning.OFF, -1);
		private var txtInfo:TextField = Functions.getTitledTextfield( 281, 152, 235, 36, new Art().fontName, 13, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.AUTO, 0);
		private var index:int;
		private var lvl:int;
		
		public function AchivDialog()  {
			this.addChild(btn);
			btn.x = 400; btn.y = 375;
			stop();
			this.addChild(this.title);
			this.addChild(this.txtInfo);
		}
	
		public function init(frameGift:int, lvl:int):void {
			Report.addMassage("ini6ted");
			App.spr.addChild(this);
	        this.gotoAndStop(frameGift+1);
			App.sound.playSound('achiv', App.sound.onVoice, 1);
			this.btn.addEventListener(MouseEvent.CLICK, this.onClick);
			this.st0.visible = lvl >= 1;
			this.st1.visible = lvl >= 2;
			this.st2.visible = lvl == 3;
			this.txtInfo.htmlText = "<font color=\"#00FF40\">" + Lang.getTitle(192, frameGift) + "</font>\n" + "<font color=\"#FF8040\">" + Lang.getTitle(15) + ": " +  lvl + "</font>";;
			this.index = frameGift;
			this.lvl = lvl;
		}
		
		private function onClick(e:MouseEvent):void {
			App.lock.init();
			var obj:Object = {f:this.index, t:this.lvl};
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, this.onResult);
			data.sendData(COMMANDS.GET_ACHIEVMENT, JSON2.encode(obj), true);
		}
		
		private function onResult(e:DataExchangeEvent):void {
			DataExchange(e.target).removeEventListener(e.type, this.onResult);
			var res:Object = JSON2.decode(e.result);
			if(res.error == null) {
				UserStaticData.hero.ach[this.index].s++;
				if(this.lvl == 1) {
					UserStaticData.hero.gold += 2;
					UserStaticData.hero.silver += 50;
				} else if(this.lvl == 2) {
					UserStaticData.hero.gold += 5;
					UserStaticData.hero.silver += 100;
				} else if (this.lvl == 3) {
					UserStaticData.hero.gold += 10;
					UserStaticData.hero.silver += 200;
				}
				App.sound.playSound('gold', App.sound.onVoice, 1);
				App.topMenu.updateGold();
				App.lock.frees();
				this.frees();
			} else {
				App.lock.init(res.error);
			}
			
		}
		
		private function frees():void {
			if(this.parent) {
				this.parent.removeChild(this);
				this.btn.removeEventListener(MouseEvent.CLICK, this.onClick);
				App.dialogManager.checkAchievement();
				App.dialogManager.canShow();
			}
			
		}
		
		
	}

}