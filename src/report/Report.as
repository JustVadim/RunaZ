package report 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author 
	 */
	public class Report extends Sprite
	{
		private static var show_report:Sprite = null;
		private static var rep_textfield:TextField = null;
		private static var count:Boolean = true;
		
		public function Report() 
		{
			show_report = new Sprite();
			show_report.graphics.beginFill(0x0000FF, 1);
			show_report.graphics.drawRect(800-15, 0, 15, 15);
			show_report.graphics.endFill();
			show_report.tabEnabled = false;
			this.addChild(show_report);
			rep_textfield = new TextField();
			rep_textfield.tabEnabled = false;
			rep_textfield.width = 800;
			rep_textfield.height = 400;
			rep_textfield.multiline = true;
			rep_textfield.wordWrap = true;
			rep_textfield.x = 0;
			rep_textfield.y = 0
			rep_textfield.visible = false;
			rep_textfield.background = true;
			rep_textfield.alpha = 0.8;
			show_report.addEventListener(MouseEvent.CLICK, onReportClick);
			this.addChildAt(rep_textfield, 0);
			
		}
		
		private function onReportClick(e:MouseEvent):void 
		{
			if (rep_textfield.visible)
			{
				rep_textfield.visible = false;
			}
			else
			{
				rep_textfield.visible = true;
			}
		}
		
		public static function hideReport():void
		{
			rep_textfield.parent.removeChild(rep_textfield);
			show_report.parent.removeChild(show_report);
		}
		
		static public function addMassage(mass:Object):void
		{
			if(show_report.visible) {
				if (count) {
					rep_textfield.htmlText += "<font color=\"FF8000\">" + String(mass) + "</font>" + "<br>";
				} else {
					rep_textfield.htmlText += "<font color = \"E80074\">" + String(mass) + "</font>" + "<br>";
				}
				count = !count;
			}
		}
		
		static public function checkDoShow():void {
			if(UserStaticData.from == "v" && UserStaticData.id != "259039640" && UserStaticData.id != "6128467" && UserStaticData.id != "365845134") {
				show_report.visible = false;
			} else {
				show_report.visible = true;
			}
		}
		
	}

}