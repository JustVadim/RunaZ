package artur.display {
	import artur.App;
	import artur.win.WinMap;
	import com.greensock.TweenLite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import report.Report;
	import Server.Lang;
	import Utils.Functions;
	public class McWinAfterBattleExtend extends mcAfterBattle {
		public var title:TextField = Functions.getTitledTextfield(0, 6, 820, 50, new Art().fontName, 34, 0xD2A055, TextFormatAlign.CENTER, Lang.getTitle(71), 1, Kerning.AUTO, 0, false);
		public var ressTxtGold:TextField = Functions.getTitledTextfield(24, 6, 55, 22.2, new Art().fontName, 17, 0xFFF642, TextFormatAlign.CENTER, "1234", 1, Kerning.OFF, -1, false);
		public var ressTxtSilver:TextField = Functions.getTitledTextfield(105, 6, 55, 22.2, new Art().fontName, 17, 0xFFFFFF, TextFormatAlign.CENTER, "1234", 1, Kerning.OFF, -1, false);
		public var txt1:Array = [];
		public var txt2:Array = [];
		public var closeBtn:BaseButton = new BaseButton(15);
		private var nextMiss:BaseButton;
		private var thisMiss:BaseButton;
		public static var rebattleUse:Boolean = false;
		
		
		public function McWinAfterBattleExtend() {
			this.addChild(this.title);
			this.title.filters = [new GlowFilter(0x0, 1,3,3,1,1) , new DropShadowFilter(1, 42, 0xFFFFFF, 1, 1, 1, 0.5,1,true), new DropShadowFilter(1, 234, 0xFFCC99, 1, 1, 1, 0.5,1,true)];
			var filtres:Array = [new GlowFilter(0x0, 1, 2, 2, 2, 1)];
			this.ressTxtGold.filters = this.ressTxtSilver.filters = filtres;
			this.ress.addChild(this.ressTxtGold);
			this.ress.addChild(this.ressTxtSilver);
			for (var i:int = 0; i < 4; i++) {
				var blank:mcBlankWinn = this[String("k" + i)];
				var txt:TextField = Functions.getTitledTextfield(57.15, 0, 100, 14, new Art().fontName, 10, 0xF3F3F3, TextFormatAlign.LEFT, Lang.getTitle(76), 0.7);
				txt.filters = filtres;
				blank.addChild(txt);
				txt1[i] = txt;
				txt = Functions.getTitledTextfield(57.55, 22, 135, 19, new Art().fontName, 16, 0x52A82E, TextFormatAlign.LEFT, "+343 опыта");
				txt.filters = filtres;
				blank.addChild(txt);
				txt2[i] = txt;
			}
			this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
			this.addChild(this.closeBtn);
			this.closeBtn.x = 419.5;
			this.closeBtn.y = 408.2;
			this.nextMiss = new BaseButton(48);
			this.thisMiss = new BaseButton(49);
			this.nextMiss.x = 675;
			this.nextMiss.y = 340;
			this.thisMiss.x = 600;
			this.thisMiss.y = 340;
		}
		
		private function onAddedToStage(e:Event):void {
			App.sound.stopSound("BatleSong");
			this.title.alpha = 0;
			this.closeBtn.scaleX = this.closeBtn.scaleY = 0;
			this.closeBtn.mouseEnabled = false;
			TweenLite.to(this.title, 2, { alpha:1, onComplete:this.addBtn } );
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
		}
		
		private function onRemovedFromStage(e:Event):void {
			this.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
			if(this.thisMiss.parent) {
				this.removeChild(this.thisMiss);
				this.removeChild(this.nextMiss);
				this.nextMiss.removeEventListener(MouseEvent.CLICK, this.onNextClick);
				this.nextMiss.removeEventListener(MouseEvent.ROLL_OVER, this.onOver);
				this.nextMiss.removeEventListener(MouseEvent.ROLL_OUT, this.onOut);
				this.thisMiss.removeEventListener(MouseEvent.CLICK, this.onThisMissClick);
				this.thisMiss.removeEventListener(MouseEvent.ROLL_OVER, this.onOver);
				this.thisMiss.removeEventListener(MouseEvent.ROLL_OUT, this.onOut);
			}
			
		}
		
		private function addBtn():void {
			TweenLite.to(this.closeBtn, 0.5, { scaleX:1, scaleY:1, onComplete:onFinnalBtn } );
			if (String(UserStaticData.hero.mbat.ids[1]).substr(0, 3) == "bot") {	
				this.addChild(this.thisMiss);
				this.thisMiss.addEventListener(MouseEvent.CLICK, this.onThisMissClick);
				this.thisMiss.addEventListener(MouseEvent.ROLL_OVER, this.onOver);
				this.thisMiss.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
				
				this.addChild(this.nextMiss);
				this.nextMiss.addEventListener(MouseEvent.CLICK, this.onNextClick);
				this.nextMiss.addEventListener(MouseEvent.ROLL_OVER, this.onOver);
				this.nextMiss.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
			}
		}
		
		private function onFinnalBtn():void 
		{
			this.closeBtn.mouseEnabled = true;
		}
		
		private function onOut(e:MouseEvent):void 
		{
			App.info.frees();
		}
		
		private function onOver(e:MouseEvent):void {
			var btn:BaseButton = BaseButton(e.target);
			if(btn == this.thisMiss) {
				App.info.init( e.currentTarget.x - 90, e.currentTarget.y - 50, { txtInfo_w:180, txtInfo_h:37, txtInfo_t:Lang.getTitle(155), type:0 } );
			} else {
				App.info.init( e.currentTarget.x - 90, e.currentTarget.y - 50, { txtInfo_w:180, txtInfo_h:37, txtInfo_t:Lang.getTitle(156), type:0 } );
			}
		}
		
		private function onThisMissClick(e:MouseEvent):void {
			McWinAfterBattleExtend.rebattleUse = true;
			var missNum:int = int(String(UserStaticData.hero.mbat.ids[1]).substr(3)) % 11;
			WinMap.sprSelLevel.init(missNum, UserStaticData.hero.miss[MapTown.currTownClick].mn[missNum]);
		}
		
		private function onNextClick(e:MouseEvent):void {
			McWinAfterBattleExtend.rebattleUse = true;
			var missNum:int = int(String(UserStaticData.hero.mbat.ids[1]).substr(3)) % 11;
			if (missNum != 0 && (missNum + 1) % 11 == 0) {
				MapTown.currTownClick++;
				WinMap.sprSelLevel.init(missNum, UserStaticData.hero.miss[MapTown.currTownClick].mn[0]);
			} else {
				WinMap.sprSelLevel.init(missNum + 1, UserStaticData.hero.miss[MapTown.currTownClick].mn[missNum + 1]);
			}
			
		}
	}
}