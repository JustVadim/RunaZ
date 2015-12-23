package artur.display 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import report.Report;
	import Utils.Functions;

	public class MapTown extends Sprite
	{
		public static var HOLD_TOWN:int = 1;
		public static var OPEN_TOWN:int = 2;
		public static var CURR_TOWN:int = 3;
		public static var WINN_TOWN:int = 4;
		public static var COLORS_TEXT:Array = [0, 0xAEAEAE, 0xE4A03A, 0xE4A03A, 0x2EF146];
		
		public var town:BaseButton;
		private var nameTown:String;
		 
		public var table:mcTownTable = new mcTownTable();
		private var title:TextField = Functions.getTitledTextfield(-30.5, -8, 61, 15, new Art().fontName, 10, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.AUTO,0);
		
		public static var currTownClick:int 
		
		public function MapTown(baseBtn:BaseButton, nameTown:String) 
		{
			this.title.filters = [new GlowFilter(0, 1, 2, 2, 1)];
			this.town = baseBtn;
			this.table.addChild(this.title);
			this.addChild(town);
			this.addChild(table);
			table.y = town.height / 2 + table.height / 2 -0.5;
			updateTable1();
			this.title.text = nameTown;
			table.addEventListener(MouseEvent.MOUSE_DOWN, onKlickTable);
			table.addEventListener(MouseEvent.MOUSE_OVER, town.over);
			table.addEventListener(MouseEvent.MOUSE_OUT, town.out);
		}
		
		private function out(e:MouseEvent):void 
		{
			town.out();
		}
		
		private function onOver(e:MouseEvent):void 
		{
			town.over();
		}
		
		private function onKlickTable(e:MouseEvent):void 
		{
			town.down();
		}
		
		public function updateTable1(frame:int = 1):void {
			Report.addMassage("tableUpdate" + frame);
			table.gotoAndStop(frame);
			this.title.textColor = COLORS_TEXT [frame];
			town.setActive( frame != 1);
			table.buttonMode = Boolean(frame != 1);
		}
	}

}