package artur.display 
{
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Server.Lang;
	import Utils.json.JSON2;
	import artur.App;
	import artur.RasterClip;
	import artur.win.WinRoot;
	import datacalsses.Hero;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Utils.Functions;
	
	public class LevelUpDialog extends Sprite
	{
		private var bg:Bitmap = RasterClip.getBitmap(new mcUpdSkill());
		private var btns:Array = [];
		private var txts:Array  = [];
		private var btnOk:BaseButton;
		private var txtUp:TextField  = Functions.getTitledTextfield(317.7, 110.3, 167.5, 26, new Art().fontName, 15, 0x232101, TextFormatAlign.CENTER, "Новый уровень", 1);
		private var txtDown:TextField  = Functions.getTitledTextfield(222.2, 249.4, 167.5, 33.15, new Art().fontName, 20 ,  0xFDDD5B, TextFormatAlign.CENTER, "Ваша награда", 1);
		private var txtGold:TextField  = Functions.getTitledTextfield(447.1, 255.0, 48, 28, new Art().fontName, 16 , 0xFDDD5B, TextFormatAlign.CENTER, "10", 1);
		private var txtSilver:TextField  = Functions.getTitledTextfield(527.65, 255.0, 48, 28, new Art().fontName, 16, 0xC0C0C0, TextFormatAlign.CENTER, "50", 1);
		private var pushedBtn:String;
		
		public function LevelUpDialog() {
			var f:GlowFilter = new GlowFilter(0x000000, 0.5);
			this.addChild(bg);
			this.addChild(txtUp);
			this.addChild(txtDown);
			this.addChild(txtGold);
			this.addChild(txtSilver);
			txtDown.filters = [f];
			txtSilver.filters = [f];
			txtGold.filters = [f];
			for (var i:int = 0; i < 4; i++) {
				var btn:BaseButton = new BaseButton(80 + i);
				btns.push(btn);
				btn.name = String(i);
				btn.x = 282.75 + i * 75;
				btn.y = 194.25;
				btn.name = i.toString();
				this.addChild(btn);
				var txt:TextField = Functions.getTitledTextfield(btn.x -18, btn.y + 20.5, 40, 23, new Art().fontName, 15,0x393502, TextFormatAlign.CENTER, "21", 1);
				
				txts.push(txt);
				this.addChild(txt);
			}
			btnOk = new BaseButton(84);
			this.addChild(btnOk);
			btnOk.x = 400;
			btnOk.y = 316.85;
			btnOk.addEventListener(MouseEvent.CLICK, onOk);
		}
		
		private function onOk(e:MouseEvent):void {
			App.dialogManager.canShow();
			this.frees();
		}
		
		public function frees():void {
			if(this.parent) {
				this.parent.removeChild(this);
				for (var i:int = 0; i < 4; i++) {
					var btn:BaseButton = this.btns[i];
					btn.removeEventListener(MouseEvent.CLICK, onBtn);
					btn.removeEventListener(MouseEvent.ROLL_OVER, this.onOver);
					btn.removeEventListener(MouseEvent.ROLL_OUT, this.onOut);
				}
			}
			if(UserStaticData.hero.level == 5) {
				Main.THIS.chat.ShowVipBtn();
				App.vipDialog.init();
			}
		}
		
		
		
		public function init():void {
			App.sound.playSound('levelUp', App.sound.onVoice, 1);
			App.spr.addChild(this);
			this.updateThis();
			for (var i:int = 0; i < 4; i++) {
				var btn:BaseButton = this.btns[i];
				btn.addEventListener(MouseEvent.CLICK, onBtn);
				btn.addEventListener(MouseEvent.ROLL_OVER, this.onOver);
				btn.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
			}
			Functions.compareAndSet(this.txtSilver, String(20 * UserStaticData.hero.level));
			Functions.compareAndSet(this.txtGold, String(1 + int(UserStaticData.hero.level/2)));
		}
		
		private function updateThis():void {
			Functions.compareAndSet(this.txts[0], String(UserStaticData.hero.skills.attack));
			Functions.compareAndSet(this.txts[1], String(UserStaticData.hero.skills.defence));
			Functions.compareAndSet(this.txts[2], String(UserStaticData.hero.skills.energy));
			Functions.compareAndSet(this.txts[3], String(UserStaticData.hero.skills.vitality));
		}
		
		private function onBtn(e:MouseEvent):void {
			if(UserStaticData.hero.fs > 0) {
				var str:String = e.currentTarget.name;
				App.lock.init();
				var data:DataExchange = new DataExchange();
				data.addEventListener(DataExchangeEvent.ON_RESULT, this.onRes);
				data.sendData(COMMANDS.PERSON_UPDATE, str, true);
				this.pushedBtn = str;
			}
		}
		
		private function onRes(e:DataExchangeEvent):void {
			var res:Object = JSON2.decode(e.result);
			if (res.error == null) {
				var hero:Hero = UserStaticData.hero;
				hero.cur_vitality = res.res;
				hero.fs -= 1;
				switch(pushedBtn) {
					case "0":
						hero.skills.attack++;
						break;
					case "1":
						hero.skills.defence++;
						break;
					case "2":
						hero.skills.energy++;
						break;
					case "3":
						hero.skills.vitality++;
						break;
				}
				if(App.winManajer.currWin == 0) {
					WinRoot(App.winManajer.windows[0]).updateBar();
				}
				this.updateThis();
				App.lock.frees();
			}
			else {
				App.lock.init(res.error);
			}
			/*if(UserStaticData.hero.fs == 0) {
				App.dialogManager.canShow();
			}*/
		}
		
		private function onOut(e:MouseEvent):void {
			App.info.frees();
		}
		
		private function onOver(e:MouseEvent):void {
			App.sound.playSound('over1', App.sound.onVoice, 1);
			var mc:BaseButton = BaseButton(e.target);
			var num:int = int(mc.name);
			var str:String = "";
			switch(num) {
				case 0:
					str += "+" + UserStaticData.hero.skills.attack + Lang.getTitle(179, num);
					break;
				case 1:
					str += "+" + UserStaticData.hero.skills.defence + Lang.getTitle(179, num);
					break;
				case 2:
					str += "+" + UserStaticData.hero.skills.energy * 10 + Lang.getTitle(179, num);
					break;
				case 3:
					str += UserStaticData.hero.skills.vitality * 10 + Lang.getTitle(179, num);
					break;
			}
			if(UserStaticData.hero.fs > 0) {
				str += "\n<font color=\"#11B1FF\">Нажмите, что бы улучшить!"
			}
			App.info.init( 225, 20, {title:Lang.getTitle(178, num), txtInfo_w:350, txtInfo_h:37, txtInfo_t:str, type:0 });
		}

		
	}

}