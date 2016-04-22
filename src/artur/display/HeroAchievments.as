package artur.display {
	import Utils.Functions;
	import artur.App;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.text.engine.Kerning;
	import report.Report;
	
	public class HeroAchievments extends Sprite {
		public static var ACHIEVMENTS_QTY:int = 12;
		private var bg:mcBgAchiv;
		private var cont:Sprite;
		private var ach_array:Array;
		private var title:TextField = Functions.getTitledTextfield(320, 70, 155, 22, new Art().fontName, 16, 0xFFF642, TextFormatAlign.CENTER, "Достижения", 1, Kerning.OFF, -1);
		private var closeBtn:BaseButton;
		
		public function HeroAchievments() {
			Functions.SetPriteAtributs(this, true, true, 0, 0);
			this.closeBtn = new BaseButton(31);
			this.closeBtn.x = 400;
			this.closeBtn.y = 358;
			this.addChild(this.bg = new mcBgAchiv());
			this.cont = new Sprite()
			this.ach_array = new Array();
			for (var i:int = 0; i < HeroAchievments.ACHIEVMENTS_QTY; i++) {
				var ach:Achiv = new Achiv(i, 310 + 54 * (i % 3), 100 + 60 * int(i / 3));
				this.ach_array[i] = ach;
				this.cont.addChild(ach);
			}
			this.bg.achiv_scrollbar.source = cont;
			this.addChild(this.cont);
			this.addChild(this.title);
			this.scaleX = this.scaleY = 1.2;
			this.x = -80;
			this.y = -40;
			this.title.filters = [new GlowFilter(0x645F00, 1, 2, 2)];
			this.addChild(this.closeBtn);
		}
		
		public function init():void {
			App.spr.addChild(this);
			this.closeBtn.addEventListener(MouseEvent.CLICK, this.onClick);
			for (var i:int = 0; i < HeroAchievments.ACHIEVMENTS_QTY; i++) {
				Achiv(this.ach_array[i]).init(UserStaticData.hero.ach[i].s);
			}
		}
		
		private function onClick(e:MouseEvent):void 
		{
			this.frees();
		}
		
		private function frees():void 
		{
			if(this.parent) {
				this.parent.removeChild(this);
			}
		}
	}

}