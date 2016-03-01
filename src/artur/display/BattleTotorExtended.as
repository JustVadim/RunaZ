package artur.display {
	import artur.App;
	import com.greensock.TweenLite;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Server.Lang;
	import Utils.Functions;
	public class BattleTotorExtended extends mcBatleTutorial {
		private var text:TextField = Functions.getTitledTextfield(10, 10, 169, 80, new Art().fontName, 11, 0xFFFFFF, TextFormatAlign.CENTER, "", 0.9);
		public function BattleTotorExtended() {
			this.addChild(this.text);
			this.text.wordWrap = true;
			this.text.multiline = true;
			this.text.filters = [new GlowFilter(0x0, 1, 2, 2)];
			this.mouseChildren = this.mouseEnabled = false;
		}
		
		public function setText(num:int):void {
			Functions.compareAndSet(this.text, Lang.getTitle(157+num));
		}
		
		public function init(xx:Number, yy:Number, text:int):void 
		{
			this.x = xx;
			this.y = yy;
			this.setText(text);
			App.spr.addChild(this);
			TweenLite.to(this, 0, { delay:7, onComplete:onComplete} );
		}
		
		private function onComplete():void 
		{
			this.frees();
		}
		
		public function frees():void {
			if(this.stage) {
				this.parent.removeChild(this);
			}
		}
	}
}