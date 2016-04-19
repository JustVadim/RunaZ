package artur.display {
	import Utils.Functions;
	import artur.App;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.text.engine.Kerning;
	import report.Report;
	
	public class HeroAchievments extends Sprite {
		public static var ACHIEVMENTS_QTY:int = 11;
		private var bg:mcBgAchiv;
		private var cont:Sprite;
		private var ach_array:Array;
		private var btn_close:BaseButton;
		private var title:TextField = Functions.getTitledTextfield(320, 70, 155, 22, new Art().fontName, 16, 0xFFF642, TextFormatAlign.CENTER, "Достижения", 1, Kerning.OFF, -1);
		
		public function HeroAchievments() {
			Functions.SetPriteAtributs(this, true, true, 0, 0);
			this.addChild(this.bg = new mcBgAchiv());
			
			this.bg.achiv_scrollbar.source = (cont = new Sprite());
			this.ach_array = new Array();
			for (var i:int = 0; i < HeroAchievments.ACHIEVMENTS_QTY; i++) {
				var ach:Achiv = new Achiv(i, 310 + 54 * (i % 3), 100 + 60 * int(i / 3));
				this.ach_array[i] = ach;
				this.addChild(ach);
			}
			this.addChild(this.title);
			this.scaleX = this.scaleY = 1.2;
			this.x = -80;
			this.y = -40;
			
		}
		
		public function init(ach_obj:Object):void 
		{
			App.spr.addChild(this);
		}
	}

}