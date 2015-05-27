package artur.display 
{
.


	/**
	 * ...
	 * @author art
	 */
	public class MapTown extends Sprite
	{
		  public static var HOLD_TOWN:int = 1;
		  public static var OPEN_TOWN:int = 2;
		  public static var CURR_TOWN:int = 3;
		  public static var WINN_TOWN:int = 4;
		  public static var COLORS_TEXT:Array = [0,0xAEAEAE,0xE4A03A,0xE4A03A,0x2EF146];
		  
		 public var town:BaseButton;
		 private var nameTown:String;
		 
		 public var table:mcTownTable = new mcTownTable();
		 public static var currTownClick:int 
		public function MapTown(baseBtn:BaseButton,nameTown:String) 
		{
			this.town = baseBtn;
			this.addChild(town);
			this.addChild(table);
			table.y = town.height / 2 + table.height / 2 -0.5;
			table.txt.text = nameTown; table.mouseChildren = false;
			updateTable();
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
			currTownClick  = int(this.name);
			town.down();
		
		}
		public function updateTable(frame:int=1):void
		{
			 table.gotoAndStop(frame);
			 table.txt.textColor = COLORS_TEXT [frame];
			 town.setActive( frame != 1);
		     table.buttonMode = Boolean(frame != 1);
		}
		
		
	}

}