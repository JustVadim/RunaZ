package artur.display.battle 
{
	import Utils.Functions;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.text.engine.Kerning;
	public class mcBarExteds extends mcBar{
		public var title:TextField = Functions.getTitledTextfield(-30, -14, 60, 12, new Art().fontName, 9, 0x09FF09, TextFormatAlign.CENTER, "000/000", 1, Kerning.AUTO, 0, false, 2);
		
		public function mcBarExteds() {
			this.addChild(this.title);
			this.title.filters = [new GlowFilter(0x0, 1, 2, 2, 3)];
			this.title.mouseEnabled = false;
		}	
		
		public function setText(selected:Boolean):void 
		{
			this.title.visible = selected;
		}
		
	}
}