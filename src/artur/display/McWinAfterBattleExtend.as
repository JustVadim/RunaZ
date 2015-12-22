package artur.display {
	import com.greensock.TweenLite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Utils.Functions;
	public class McWinAfterBattleExtend extends mcAfterBattle {
		public var title:TextField = Functions.getTitledTextfield(0, 6, 820, 50, new Art().fontName, 34, 0xD2A055, TextFormatAlign.CENTER, "Победа", 1, Kerning.AUTO, 0, false);
		public var ressTxtGold:TextField = Functions.getTitledTextfield(24, 6, 55, 22.2, new Art().fontName, 17, 0xFFF642, TextFormatAlign.CENTER, "1234", 1, Kerning.OFF, -1, false);
		public var ressTxtSilver:TextField = Functions.getTitledTextfield(105, 6, 55, 22.2, new Art().fontName, 17, 0xFFFFFF, TextFormatAlign.CENTER, "1234", 1, Kerning.OFF, -1, false);
		public var txt1:Array = [];
		public var txt2:Array = [];
		public var closeBtn:BaseButton = new BaseButton(15);
		
		public function McWinAfterBattleExtend() {
			this.addChild(this.title);
			this.title.filters = [new GlowFilter(0x0, 1,3,3,1,1) , new DropShadowFilter(1, 42, 0xFFFFFF, 1, 1, 1, 0.5,1,true), new DropShadowFilter(1, 234, 0xFFCC99, 1, 1, 1, 0.5,1,true)];
			var filtres:Array = [new GlowFilter(0x0, 1, 2, 2, 2, 1)];
			this.ressTxtGold.filters = this.ressTxtSilver.filters = filtres;
			this.ress.addChild(this.ressTxtGold);
			this.ress.addChild(this.ressTxtSilver);
			for (var i:int = 0; i < 4; i++) {
				var blank:mcBlankWinn = this[String("k" + i)];
				var txt:TextField = Functions.getTitledTextfield(57.15, 0, 100, 14, new Art().fontName, 10, 0xF3F3F3, TextFormatAlign.LEFT, "Убил", 0.7);
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
		}
		
		private function onAddedToStage(e:Event):void 
		{
			this.title.alpha = 0;
			this.closeBtn.scaleX = this.closeBtn.scaleY = 0
			TweenLite.to(this.title,2, { alpha:1, onComplete:this.addBtn } );
		}
		
		private function addBtn():void 
		{
			TweenLite.to(this.closeBtn, 0.5, { scaleX:1, scaleY:1} );
		}
	}
}