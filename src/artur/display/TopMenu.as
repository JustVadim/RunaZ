package artur.display {	
	import artur.App;
	import artur.win.WinCastle;
	import datacalsses.Hero;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	import report.Report;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Utils.Functions;
	public class TopMenu extends Sprite {
		private var mcAva:mcAvatarBar = new mcAvatarBar();
		private var txtAvatarLevel:TextField = Functions.getTitledTextfield(32.5, 77, 31.75, 19.9, new Art().fontName, 15, 0xFBFBFB, TextFormatAlign.CENTER, "99", 1, Kerning.OFF, -1);
		public var txtExp:TextField;
		public var txtVit:TextField;
		public var txtGold:TextField = Functions.getTitledTextfield(31, 11, 78, 22, new Art().fontName, 16, 0xFFF642, TextFormatAlign.CENTER, "9999", 1, Kerning.OFF, -1);
		public var txtSilver:TextField = Functions.getTitledTextfield(160, 11, 78, 22, new Art().fontName, 16, 0xFFFFFF, TextFormatAlign.CENTER, "9999", 1, Kerning.OFF, -1);
		
		private var gold:mcRessBar = new mcRessBar();
		
		public function TopMenu() {
			this.tabEnabled = false;
			this.tabChildren = false;
			Functions.SetPriteAtributs(this, false, true, 0, 0);
			this.addChild(this.mcAva);
			this.mcAva.addChild(txtAvatarLevel);
			this.mcAva.expBar.addChild(this.txtExp = Functions.getTitledTextfield(0, -3, this.mcAva.expBar.width, 17, new Art().fontName, 14, 0xFFFFFF, TextFormatAlign.CENTER, "00/00", 1, Kerning.OFF, -1));
			this.mcAva.vitBar.addChild(this.txtVit = Functions.getTitledTextfield(0, -3, this.mcAva.expBar.width, 17, new Art().fontName, 14, 0xFFFFFF, TextFormatAlign.CENTER, "00/00", 1, Kerning.OFF, -1));
			this.txtAvatarLevel.filters = this.txtExp.filters = this.txtGold.filters = this.txtSilver.filters = this.txtVit.filters = [new GlowFilter(0x0, 1, 2, 2, 2, 1, false, false)];
			this.gold.x = 800 - this.gold.width+7;
			this.gold.addChild(this.txtGold);
			this.gold.addChild(this.txtSilver);
			this.gold.mouseChildren = false;
			this.gold.tabEnabled = false;
			this.gold.tabChildren = false;
			this.gold.buttonMode = true;
			this.updater();
		}
		
		public function init(showAva:Boolean, showGold:Boolean, topPanel:Boolean = false, tpClass:Class = null):void {
			App.spr.addChild(this);
			if(showAva) {
				this.addChild(this.mcAva)
			} else {
				if(this.mcAva.parent) {
					this.mcAva.parent.removeChild(this.mcAva);
				}
			}
			if(showGold) {
				this.addChild(this.gold);
			} else {
				if(this.gold.parent) {
					this.removeChild(this.gold);
				}
			}
			this.updateAva();
			this.updateGold();
		}
		
		
		public function updateGold():void {
			Functions.compareAndSet(this.txtGold, String(UserStaticData.hero.gold));
			Functions.compareAndSet(this.txtSilver, String(UserStaticData.hero.silver));
		}
		
		private function updateAva():void {
			if (this.mcAva.parent) {
				var hero:Hero = UserStaticData.hero;
				var maxVit:int = hero.skills.vitality*10;
				var currEn:int = hero.cur_vitality;
				var currExp:int = hero.exp;
				Functions.compareAndSet(this.txtAvatarLevel, hero.level.toString());
				Functions.compareAndSet(this.txtExp, String(currExp + '/' + 11));
				Functions.compareAndSet(this.txtVit, String(currEn + '/' + maxVit));
				this.mcAva.vitBar.gotoAndStop(int(maxVit / currEn * 100) + 1);
				this.mcAva.expBar.gotoAndStop(int(currExp / 11 * 100) + 1);
				if(currEn < 10) {
					this.mcAva.vitBar.buttonMode = true;
				}
			}
		}
		
		private function updater():void {
			var timer:Timer = new Timer(65000);
			timer.addEventListener(TimerEvent.TIMER, this.updateEnergy);
			timer.start();
		}
		
		public function updateEnergy(e:TimerEvent = null):void  {
			if (DataExchange.loged) {
				var data:DataExchange = new DataExchange();
				data.addEventListener(DataExchangeEvent.ON_RESULT, onUpdateRes);
				data.sendData(COMMANDS.CHECK_ENERGY, "", true);
			}
		}
		
		private function onUpdateRes(e:DataExchangeEvent):void {
			Report.addMassage(e.result);
			//update bar if visible;
		}
		
	}

}