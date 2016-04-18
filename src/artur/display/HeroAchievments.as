package artur.display {
	import Utils.Functions;
	import artur.App;
	import flash.display.Sprite;
	import report.Report;
	
	public class HeroAchievments extends Sprite {
		private var bg:mcBgAchiv;
		private var cont:Sprite;
		private var ach_array:Array;
		private var btn_close:BaseButton;
		
		public function HeroAchievments() {
			Functions.SetPriteAtributs(this, true, true, 0, 0);
			this.addChild(this.bg = new mcBgAchiv());
			this.bg.achiv_scrollbar.source = (cont = new Sprite());
			this.ach_array = new Array();
			
		}
		
		public function init():void 
		{
			App.spr.addChild(this);
		}
	}

}