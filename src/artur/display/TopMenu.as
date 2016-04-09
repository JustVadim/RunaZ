package artur.display {	
	import Server.Lang;
	import artur.App;
	import artur.win.WinCastle;
	import datacalsses.Hero;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.net.URLRequest;
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	import report.Report;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Utils.Functions;
	import Utils.json.JSON2;
	public class TopMenu extends Sprite {
		private var mcAva:mcAvatarBar = new mcAvatarBar();
		private var txtAvatarLevel:TextField = Functions.getTitledTextfield(32.5, 77, 31.75, 19.9, new Art().fontName, 15, 0xFBFBFB, TextFormatAlign.CENTER, "99", 1, Kerning.OFF, -1);
		public var txtExp:TextField;
		public var txtVit:TextField;
		public var txtGold:TextField = Functions.getTitledTextfield(31, 11, 78, 22, new Art().fontName, 16, 0xFFF642, TextFormatAlign.CENTER, "9999", 1, Kerning.OFF, -1);
		public var txtSilver:TextField = Functions.getTitledTextfield(160, 11, 78, 22, new Art().fontName, 16, 0xFFFFFF, TextFormatAlign.CENTER, "9999", 1, Kerning.OFF, -1);
		private var ava_loader:Loader;
		private var gold:mcRessBar = new mcRessBar();
		
		private var groupCounter:int = 0;
		private var bonusCounter:int = 0;
		
		public function TopMenu() {
			this.tabEnabled = false;
			this.tabChildren = false;
			Functions.SetPriteAtributs(this, false, true, 0, 0);
			this.addChild(this.mcAva);
			this.mcAva.addChild(txtAvatarLevel);
			this.mcAva.expBar.addChild(this.txtExp = Functions.getTitledTextfield(0, -2, this.mcAva.expBar.width, 14, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.CENTER, "00/00", 1, Kerning.OFF, -1));
			this.mcAva.vitBar.addChild(this.txtVit = Functions.getTitledTextfield(0, -3, this.mcAva.expBar.width, 17, new Art().fontName, 14, 0xFFFFFF, TextFormatAlign.CENTER, "00/00", 1, Kerning.OFF, -1));
			this.mcAva.vitBar.buttonMode = true;
			this.mcAva.expBar.buttonMode = true;
			this.txtAvatarLevel.filters = this.txtExp.filters = this.txtGold.filters = this.txtSilver.filters = this.txtVit.filters = [new GlowFilter(0x0, 1, 2, 2, 2, 1, false, false)];
			this.gold.x = 800 - this.gold.width+7;
			this.gold.addChild(this.txtGold);
			this.gold.addChild(this.txtSilver);
			this.gold.mouseChildren = false;
			this.gold.tabEnabled = false;
			this.gold.tabChildren = false;
			this.gold.buttonMode = true;
			this.updater();
			this.addAva();
			this.addEventListener(Event.ADDED_TO_STAGE, this.onAdded);
		}
		
		private function onAdded(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, this.onAdded);
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
			this.addBtnEvents(this.gold);	
			this.addBtnEvents(this.mcAva.vitBar);
			this.addBtnEvents(this.mcAva.expBar);
		}
		
		private function onRemoved(e:Event):void {
			this.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
			this.addEventListener(Event.ADDED_TO_STAGE, this.onAdded);
			this.removeBtnEvents(this.gold);
			this.removeBtnEvents(this.mcAva.expBar);
			this.removeBtnEvents(this.mcAva.vitBar);
		}
		
		private function addBtnEvents(mc:Sprite):void {
			mc.addEventListener(MouseEvent.CLICK, this.onResClick);
			mc.addEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
			mc.addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
		}
		
		private function removeBtnEvents(mc:Sprite):void {
			mc.removeEventListener(MouseEvent.CLICK, this.onResClick);
			mc.removeEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
			mc.removeEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
		}
		
		private function onRollOut(e:MouseEvent):void {
			var mc:Sprite = Sprite(e.target);
			switch(mc) {
				case this.gold:
					this.gold.filters = [];
					break;
			}
			App.info.frees();
		}
		
		private function onRollOver(e:MouseEvent):void {
			var mc:Sprite = Sprite(e.target);
			switch(mc) {
				case this.gold:
					this.gold.filters = [new GlowFilter(0xFFFFFF)];
					App.sound.playSound("over1", App.sound.onVoice, 1);
					App.info.init( mc.x - 60, mc.y + 80, { title:Lang.getTitle(180), txtInfo_w:300, txtInfo_h:37, txtInfo_t:Lang.getTitle(181), type:0 });
					break;
				case this.mcAva.vitBar:
					App.sound.playSound("over1", App.sound.onVoice, 1);
					App.info.init( mc.x - 25, mc.y + 55, { title:Lang.getTitle(182), txtInfo_w:300, txtInfo_h:37, txtInfo_t:Lang.getTitle(183), type:0 });
					break;
				case this.mcAva.expBar:
					App.sound.playSound("over1", App.sound.onVoice, 1);
					App.info.init( mc.x - 25, mc.y + 55, { title:Lang.getTitle(184), txtInfo_w:300, txtInfo_h:37, txtInfo_t:Lang.getTitle(185), type:0 });
					break;
			}
		}
		
		private function onResClick(e:MouseEvent):void {
			var mc:Sprite = Sprite(e.target);
			switch(mc) {
				case this.gold:
					App.winBank.init();
					break;
				case this.mcAva.vitBar:
					App.byeWin.init("Я хочу пополнить", " энергию", 10, 0, NaN, 6);
					break;
			}
			
		}
		
		private function addAva():void {
			ava_loader = new Loader();
			ava_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onGetAva);
			ava_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onGetAvaError);
			ava_loader.load(new URLRequest(UserStaticData.plink));
			function onGetAva(e:Event):void {
				ava_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onGetAva);
				ava_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onGetAvaError);
				ava_loader.tabChildren = false;
				ava_loader.mouseEnabled = false;
				ava_loader.mouseChildren = false;
				ava_loader.tabEnabled = false;
				ava_loader.x = 7;
				ava_loader.y = 4;
				ava_loader.width = 85;
				ava_loader.height = 82;
				ava_loader.mask = mcAva.avatarMask;
				addChild(ava_loader);
			}
			
			function onGetAvaError(e:IOErrorEvent):void {
				
			}

		}
		
		public function init(showAva:Boolean, showGold:Boolean, topPanel:Boolean = false, tpClass:Class = null):void {
			App.spr.addChild(this);
			if(showAva) {
				this.addChild(this.mcAva)
				this.ava_loader.visible = true;
			} else {
				if(this.mcAva.parent) {
					this.mcAva.parent.removeChild(this.mcAva);
					this.ava_loader.visible = false;
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
		
		
		
		public function updateAva():void {
			if (this.mcAva.parent) {
				var hero:Hero = UserStaticData.hero;
				var maxVit:int = hero.skills.vitality*10;
				var currEn:int = hero.cur_vitality;
				var currExp:int = hero.exp;
				Functions.compareAndSet(this.txtAvatarLevel, hero.level.toString());
				Functions.compareAndSet(this.txtExp, String(currExp + '/' + UserStaticData.hero.nle));
				Functions.compareAndSet(this.txtVit, String(currEn + '/' + maxVit));
				
				this.mcAva.vitBar.gotoAndStop(int(currEn  / maxVit * 100) + 1);
				this.mcAva.expBar.gotoAndStop(int(currExp / UserStaticData.hero.nle * 100) + 1);
				
				
				/*if(currEn < 10) {
					this.mcAva.vitBar.buttonMode = true;
					this.mcAva.vitBar.mouseEnabled = true;
					this.mcAva.vitBar.addEventListener(MouseEvent.ROLL_OVER, this.onOver);
					this.mcAva.vitBar.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
					this.mcAva.vitBar.addEventListener(MouseEvent.CLICK, this.onClick);
					
				} else {
					this.mcAva.vitBar.buttonMode = false;
					this.mcAva.vitBar.mouseEnabled = false;
					this.mcAva.vitBar.removeEventListener(MouseEvent.ROLL_OVER, this.onOver);
					this.mcAva.vitBar.removeEventListener(MouseEvent.ROLL_OUT, this.onOut);
					this.mcAva.vitBar.removeEventListener(MouseEvent.CLICK, this.onClick);
				}*/
			}
		}
		
		private function onClick(e:MouseEvent):void {
			
		}
		
		private function onOut(e:MouseEvent):void {
			App.info.frees();	
		}
		
		private function onOver(e:MouseEvent):void {
			var mc:MovieClip = MovieClip(e.target);
			App.info.init( mc.x + 100, mc.y + 30, { txtInfo_w:180, txtInfo_h:37, txtInfo_t:Lang.getTitle(162), type:0 });
		}
		
		private function updater():void {
			var timer:Timer = new Timer(30000);
			timer.addEventListener(TimerEvent.TIMER, this.updateEnergy);
			timer.start();
		}
		
		private function updateEnergy(e:TimerEvent):void  {
			if (DataExchange.loged) {
				var data:DataExchange = new DataExchange();
				data.addEventListener(DataExchangeEvent.ON_RESULT, onUpdateRes);
				data.sendData(COMMANDS.CHECK_ENERGY, "", true);
				if (this.groupCounter == 3) {
					if(UserStaticData.from == "v") {
						App.upPanel.checkVKGroup();
					}
					this.groupCounter = 0;
					return
				}
				this.groupCounter++;
			}
		}
		
		public function updateBar():void {
			
		}
		
		public function buyEnergy():void {
			App.lock.init();
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, this.onEnergyBuyResult);
			data.sendData(COMMANDS.BUY_ENERGY, "", true);
		}
		
		private function onEnergyBuyResult(e:DataExchangeEvent):void {
			DataExchange(e.target).removeEventListener(e.type, this.onEnergyBuyResult);
			var obj:Object = JSON2.decode(e.result);
			if (obj.res != null) {
				App.sound.playSound('gold', App.sound.onVoice, 1);
				UserStaticData.hero.cur_vitality = obj.res
				UserStaticData.hero.gold -= 10;
				this.updateAva();
				this.updateGold();
				App.lock.frees();
				return
			} 
			App.lock.init(obj.error);
		}
		
		private function onUpdateRes(e:DataExchangeEvent):void {
			var obj:Object = JSON2.decode(e.result);
			if(obj.res != null) {
				UserStaticData.hero.cur_vitality = int(obj.res);
			}
			if(this.stage) {
				this.updateAva();
			}
		}
		
	}

}