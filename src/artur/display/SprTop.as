package artur.display {
	import Server.Lang;
	import Utils.Functions;
	import artur.App;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.text.engine.Kerning;
	import report.Report;
	
	public class SprTop extends mcTopBg {
		private var btnReiting:BaseButton;
		private var btnGold:BaseButton;
		private var btnLevel:BaseButton;
		private var _btns:Array;
		private var btns:Array;
		protected var btnsText:Array;
		private var btnClose:BaseButton
		private var curRatSelected:int = 0;
		private var mainTitle:TextField = Functions.getTitledTextfield(356, 7, 112, 18.5, new Art().fontName, 15, 0xFFF642, TextFormatAlign.CENTER, Lang.getTitle(197), 1, Kerning.OFF, -1, false);
		private var ratingText:TextField = Functions.getTitledTextfield( -47.75, -9, 95.75, 16.25, new Art().fontName, 13, 0xFFFFFF, TextFormatAlign.CENTER, Lang.getTitle(198, 0), 1, Kerning.OFF, -1, false);
		private var goldText:TextField = Functions.getTitledTextfield( -47.75, -9, 95.75, 16.25, new Art().fontName, 13, 0xFFFFFF, TextFormatAlign.CENTER, Lang.getTitle(198, 1), 1, Kerning.OFF, -1, false);
		private var levelTxt:TextField = Functions.getTitledTextfield( -47.75, -9, 95.75, 16.25, new Art().fontName, 13, 0xFFFFFF, TextFormatAlign.CENTER, Lang.getTitle(198, 2), 1, Kerning.OFF, -1, false);
		private var scrollCont:Sprite = new Sprite();
		private var placesCont:Array = [];
		
		
		public function SprTop() {
			this.btnClose = new BaseButton(31); btnClose.x = 603.9; btnClose.y = 17.8;
			this.tabEnabled = false;
			this.tabChildren = false;
			this.btnReiting = new BaseButton(67);
			this.btnGold = new BaseButton(67);
			this.btnLevel = new BaseButton(67);
			this._btns = [this.b1, this.b2, this.b3];
			this.btnsText = [this.ratingText, this.goldText, this.levelTxt];
			this.btns = [this.btnReiting, this.btnGold, this.btnLevel];
			var count:int;
			for (count = 0; count < btns.length; count++) {
				var btn:BaseButton = btns[count];
				btn.addChild(TextField(btnsText[count]));
				btn.x = Sprite(_btns[count]).x;
				btn.y = Sprite(_btns[count]).y;
				btn.name = String(count);
				this.addChild(btn);
			}
			btns.push(this.btnClose);
			this.btnClose.name = String(count + 1);
			this.addChild(btnClose)
			this.addChild(this.mainTitle);
			this.mainTitle.filters = this.ratingText.filters = this.goldText.filters = this.levelTxt.filters = [new GlowFilter(0x0, 1, 2, 2, 1)];
			this.scroll.source = this.scrollCont;
			for (count = 0; count < 20; count++) {
				var blank:McBlankTopExtended = new McBlankTopExtended(0, 2 + 39 * count, count + 1);
				this.placesCont[count] = blank;
				this.scrollCont.addChild(blank);
			}
			this.scroll.update();
		}
		
		public function init():void {
			App.spr.addChild(this);
			for (var i:int = 0; i < this.btns.length; i++) {
				BaseButton(this.btns[i]).addEventListener(MouseEvent.CLICK, this.onBtnClick);
			}
			this.hideCurrBtn(0);
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
			
		}
		
		private function onBtnClick(e:MouseEvent):void {
			var btn:BaseButton = BaseButton(e.target);
			if(int(btn.name) == this.btns.length) {
				this.frees();
			} else {
				this.hideCurrBtn(int(btn.name));
			}
		}
		
		private function onRemoved(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			
		}
		
		public function frees():void {
			App.spr.removeChild(this);
		}
		
		public function hideCurrBtn(index:int):void {
			BaseButton(this.btns[curRatSelected]).visible = true;
			Sprite(this._btns[curRatSelected]).visible = false;
			BaseButton(this.btns[curRatSelected]).addChild(TextField(this.btnsText[curRatSelected]));
			TextField(this.btnsText[curRatSelected]).textColor = 0xFFFFFF;
			this.curRatSelected = index;
			BaseButton(this.btns[curRatSelected]).visible = false;
			Sprite(this._btns[curRatSelected]).visible = true;
			Sprite(this._btns[curRatSelected]).addChild(TextField(this.btnsText[curRatSelected]));
			TextField(this.btnsText[curRatSelected]).textColor = 0x9F9FFF;
			var selObj:Object;
			switch(curRatSelected) {
				case 0:
					selObj = UserStaticData.top.rat;
					break;
				case 1:
					selObj = UserStaticData.top.gold;
					break;
				case 2:
					selObj = UserStaticData.top.lvl;
					break;
			}
			for (var i:int = 0; i < 20; i++) {
				var blank:McBlankTopExtended = this.placesCont[i];
				blank.update(selObj[i]);
			}
			this.scroll.update();
		}
		
	}

}