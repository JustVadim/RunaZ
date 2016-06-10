package artur.win {
	import artur.App;
	import artur.RasterClip;
	import artur.display.BaseButton;
	import flash.text.engine.Kerning;
	
	import artur.units.U_Lyk;
	import artur.units.U_Mag;
	import artur.units.U_Paladin;
	import artur.units.U_Warwar;
	import artur.units.UnitCache;
	import artur.util.GetServerData;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Server.Lang;
	import flash.filters.GlowFilter;
	import flash.text.TextFormatAlign;
	import report.Report;

	
	
	import Utils.Functions;
	import Utils.json.JSON2;
	import flash.text.TextField;
	
	public class WinArena {
		public var bin:Boolean = false;
		private var bg:Bitmap;
		private var btnClose:BaseButton 
		private var mcFound:mcFounMovie = new mcFounMovie();
		public static const NEEDED_LVL:int = 3;
		private var btn1Title:TextField;
		private var dell1:int
		private var dell2:int
		private var char1:Object;
		private var char2:Object;
		private var types:Array = [U_Lyk, U_Mag, U_Paladin, U_Warwar, U_Lyk, U_Mag, U_Paladin, U_Warwar];
		private var ratText:TextField = Functions.getTitledTextfield(298, 165, 200, 20, new Art().fontName, 13, 0xFFFFFF, TextFormatAlign.CENTER, "1111", 0.9);
		private var pointBtn:BaseButton;
		private var silverBtn:BaseButton;
		private var goldBtn:BaseButton;
		
		private var pointTitle:TextField = Functions.getTitledTextfield( -80, -8, 160, 18, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.CENTER, Lang.getTitle(212,0), 1, Kerning.AUTO, 0, false, 2);
		private var silvetTitle:TextField = Functions.getTitledTextfield( -80, -8, 160, 18, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.CENTER, Lang.getTitle(212,1), 1, Kerning.AUTO, 0, false, 2);
		private var goldTitle:TextField = Functions.getTitledTextfield( -80, -8, 160, 18, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.CENTER, Lang.getTitle(212,2), 1, Kerning.AUTO, 0, false, 2);
		
		
		public function WinArena() {
			bg = RasterClip.getBitmap(new mcArena());
			this.pointBtn = new BaseButton(72);
			this.pointBtn.x = 161.1;
			this.pointBtn.y = 127.95;
			
			this.silverBtn = new BaseButton(73);
			this.silverBtn.x = 400.7;
			this.silverBtn.y = 91.3;
			
			this.goldBtn = new BaseButton(71);
			this.goldBtn.x = 646;
			this.goldBtn.y = 128.7;
			
			btnClose = new BaseButton(31);
			mcFound.x = 400;
			mcFound.y = 250;
			mcFound.gotoAndStop(1);
			this.ratText.filters = this.pointTitle.filters = this.silvetTitle.filters = this.goldTitle.filters = [new GlowFilter(0x0, 1, 2, 2)] ;
			this.pointBtn.addChild(this.pointTitle);
			this.silverBtn.addChild(this.silvetTitle);
			this.goldBtn.addChild(this.goldTitle)
		}
		
		private function onBtnClose(e:MouseEvent):void {
			App.info.frees();
			App.lock.init();
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, this.onRes1);
			data.sendData(COMMANDS.FIND_BATTLE, "", true);
		}
		
		private function onRes1(e:DataExchangeEvent):void {
			App.spr.removeChild(mcFound);
			mcFound.gotoAndStop(1);
			App.spr.removeChild(btnClose);
			App.lock.frees();
		}
		
		private function onRes(e:DataExchangeEvent):void {
			var obj:Object = JSON2.decode(e.result);
			if (obj.res == null) {
				App.spr.removeChild(this.mcFound);
				App.spr.removeChild(this.btnClose);
				App.lock.init("ERRRORRRR!!!!!!");
			} else {
				App.lock.frees();
			}
		}
		
		public function init():void {
			this.ratText.text = Lang.getTitle(171) + UserStaticData.hero.rat;
			dell1 = 80;
			dell2 = 120;
			App.swapMuz('MenuSong');
			App.spr.addChild(bg);
			App.spr.addChild(this.pointBtn);
			App.spr.addChild(this.silverBtn);
			App.spr.addChild(this.goldBtn);
			mcFound.gotoAndStop(1);
			mcFound.rotation = 0;
			mcFound.rot.visible = false;
			App.topPanel.init(this);
			App.topMenu.init(true, true);
			char1 = UnitCache.getUnit('Barbarian');
			char1.init(App.spr);
			char1.x = 290;
			char1.y = 380;
			char2 = UnitCache.getUnit('Paladin');
			char2.init(App.spr);
			char2.x = 800 - 290;
			char2.y = 380;
			char2.itemUpdate([RandomInt(1,5), RandomInt(1,5), RandomInt(1,5), RandomInt(1,5), RandomInt(1,5), RandomInt(1,5), RandomInt(1,5), RandomInt(0,5), RandomInt(1,5), RandomInt(1,5), RandomInt(1,5), RandomInt(1,5), RandomInt(1,5), RandomInt(1,5)]);
			char1.itemUpdate([RandomInt(1,5), RandomInt(1,5), RandomInt(1,5), RandomInt(1,5), RandomInt(1,5), RandomInt(1,5), RandomInt(1,5), RandomInt(0,5), RandomInt(1,5), RandomInt(1,5), RandomInt(1,5), RandomInt(1,5), RandomInt(1,5), RandomInt(1,5)]);
			char2.scaleX = -1;
			App.spr.addChild(this.ratText);
			btnClose.addEventListener(MouseEvent.CLICK, onBtnClose);
			this.pointBtn.addEventListener(MouseEvent.CLICK, this.onClick);
			this.pointBtn.addEventListener(MouseEvent.ROLL_OVER, this.onOver);
			this.pointBtn.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
			this.silverBtn.addEventListener(MouseEvent.CLICK, this.onClick);
			this.silverBtn.addEventListener(MouseEvent.ROLL_OVER, this.onOver);
			this.silverBtn.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
			this.goldBtn.addEventListener(MouseEvent.CLICK, this.onClick);
			this.goldBtn.addEventListener(MouseEvent.ROLL_OVER, this.onOver);
			this.goldBtn.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
		}
		
		private function onOut(e:MouseEvent):void {
			App.info.frees();
		}
		
		private function onOver(e:MouseEvent):void {
			var mc:BaseButton = BaseButton(e.target);
			var c:int = 0;
			switch(mc) {
				case pointBtn:
					c = 0;
					break;
				case silverBtn:
					c = 1;
					break;
				case goldBtn:
					c = 2;
					break;
			}
			App.info.init(mc.x - 150 , mc.y + mc.height / 2 + 15, { txtInfo_w:300, txtInfo_h:0, txtInfo_t:Lang.getArenaBtnTitle(c), type:0 });
		}
		
		
		
		private function onClick(e:MouseEvent):void {
			var btn:BaseButton = BaseButton(e.target);
			var type:int = -1;
			switch(btn) {
				case this.pointBtn:
					Report.addMassage(0);
					if(UserStaticData.hero.level >= 3) {
						if(!GetServerData.getUserIsReadyToBattle()) {
							App.closedDialog.init1(Lang.getTitle(36), true);
						} else if(UserStaticData.hero.cur_vitality < 10) {
							App.closedDialog.init1(Lang.getTitle(170), false, false, false, true);
						} else {
							type = 0;
						}
					} else {
						App.closedDialog.init1(Lang.getTitle(44, 0), false, true);
					}
					break;
				case this.silverBtn:
					if(UserStaticData.hero.level >= 5) {
						if(!GetServerData.getUserIsReadyToBattle()) {
							App.closedDialog.init1(Lang.getTitle(36), true);
						} else if(UserStaticData.hero.cur_vitality < 10) {
							App.closedDialog.init1(Lang.getTitle(170), false, false, false, true);
						} else if(UserStaticData.hero.silver < UserStaticData.hero.level*10) {
							
						} else {
							type = 1;
						}
					} else {
						App.closedDialog.init1(Lang.getTitle(44, 1), false, true);
					}
					break;
				case this.goldBtn:
					if (UserStaticData.hero.level >= 7) {
						var g:int = 1 + UserStaticData.hero.level / 3;
						if(!GetServerData.getUserIsReadyToBattle()) {
							App.closedDialog.init1(Lang.getTitle(36), true);
						} else if(UserStaticData.hero.cur_vitality < 10) {
							App.closedDialog.init1(Lang.getTitle(170), false, false, false, true);
						} else if(UserStaticData.hero.gold < g) {
							
						} else {
							type = 2;
						}
					} else {
						App.closedDialog.init1(Lang.getTitle(44, 2), false, true);
					}
					break;
			}
			if(type != -1) {
				mcFound.rotation = 0;
				mcFound.rot.visible = false;
				mcFound.gotoAndPlay(1);
				App.spr.addChild(mcFound);
				App.spr.addChild(btnClose);
				btnClose.x = e.currentTarget.x;
				btnClose.y = e.currentTarget.y + 50;
				var data:DataExchange = new DataExchange();
				data.addEventListener(DataExchangeEvent.ON_RESULT, this.onRes);
				data.sendData(COMMANDS.FIND_BATTLE, type.toString(), true);
				App.lock.init();
			}
		}
		
		private function onBattleBtnOut(e:MouseEvent):void {
			App.info.frees();
		}
		
		private function onBattleOver(e:MouseEvent):void {
			var mc:BaseButton = BaseButton(e.target);
			App.info.init(mc.x + mc.width - 130, mc.y + mc.height - 25, { txtInfo_w:110, txtInfo_h:37, txtInfo_t:Lang.getTitle(51), type:0 });
		}
		
		public function update():void {
			if (mcFound.currentFrame == mcFound.totalFrames) {
				mcFound.rotation += 2;
				mcFound.rot.visible = true;
				mcFound.rot.rotation = -mcFound.rotation; 
			}
			//char1.update();
			//char2.update();
			/*if (dell1-- < 0)
			{
				dell1 = 80;
			     char1.gotoAndPlay('atack1' )
			}
			if (dell2-- <0)
			{
				dell2 =  60;
				char2.gotoAndPlay('atack1' );
			}*/
		}
		
		public function frees():void {
			char1.frees();
			char2.frees();
			App.info.frees();
			btnClose.removeEventListener(MouseEvent.CLICK, onBtnClose);
		}
		
		static public function Random(clow:Number, chigh:Number):Number
	    {
	       return Math.round(Math.random() * (chigh - clow)) + clow;
	    }
		
		private function RandomInt(min:int, max:int):int 
		{
			 return Math.round(Math.random() * (max - min) + min);
		}
		
	}
	  

}