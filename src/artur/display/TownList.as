package artur.display 
{
	import artur.App;
	import artur.util.GetServerData;
	import artur.win.WinMap;
	import flash.events.MouseEvent;
	import report.Report;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Utils.json.JSON2;
	
	public class TownList extends mcTownList
	{
		private var blanks:Array = [];
		public static var NAMES:Array = [[[]]];
		private var btnClose:BaseButton = new BaseButton(31);
		
		public function TownList() 
		{
			for (var i:int = 0; i < 11; i++) 
			{
				var blank:mcBlankMap = new mcBlankMap();
				blank.x = 235;
				blank.y = 106 + 21 * i;
				blank.gotoAndStop(1); blank.starBar.gotoAndStop(1);
				var btn:BaseButton = new BaseButton(30);
				btn.name = String(i);
				btn.addEventListener(MouseEvent.CLICK, onBatle);
				blank.addChild(btn); btn.x = 260 + btn.width/2; btn.y = -9.7 + btn.height/2;
				blanks.push( { blank:blank, btn:btn } );
				this.addChild(blank);
			}
			btnClose.x = 563 + btnClose.width / 2 ; btnClose.y = 65 + btnClose.height / 2;
			this.addChild(btnClose);
			btnClose.addEventListener(MouseEvent.CLICK, closeClick);
		}
		
		private function closeClick(e:MouseEvent):void 
		{
			App.spr.removeChild(this);
		}
		public function init(currMap:int, currTwon:int, title:String):void
		{
			MapTown.currTownClick = currTwon;
			this.title.txt.text = title;
			App.spr.addChild(this);
			var obj:Object = UserStaticData.hero.miss[currTwon].mn;
			var lastMision:int = -1
			for (var i:int = 0; i < blanks.length; i++) 
			{
				var blank:mcBlankMap = blanks[i].blank;
				var btn:BaseButton = blanks[i].btn;
				if (obj[i] != null) 
				{
					blank.gotoAndStop(3);
					btn.visible = true;
					lastMision = i;
					for (var j:int = 0; j < 4; j++) 
					{
						if (obj[i].st[j] == 1)
							blank.starBar['st'+j].visible = true;
						else
							blank.starBar['st' + j].visible = false;
					}
				}
				else
				{
					blank.gotoAndStop(1);
					btn.visible = false;
					blank.starBar.st0.visible = false;
					blank.starBar.st1.visible = false;
					blank.starBar.st2.visible = false;
					blank.starBar.st3.visible = false;
				}
			}
			if ( lastMision < blanks.length-1) 
			{
				blanks[lastMision + 1].blank.gotoAndStop(2);
				blanks[lastMision + 1].btn.visible = true;
			}
		}
		private function onBatle(e:MouseEvent):void 
		{
			Report.addMassage(MapTown.currTownClick * 11 + "  " + int(e.currentTarget.name));
			if (GetServerData.getUserIsReadyToBattle()) 
			{
				App.lock.init();	
				var data:DataExchange = new DataExchange();
				data.addEventListener(DataExchangeEvent.ON_RESULT, getRessBattle);
				data.sendData(COMMANDS.CREAT_BATTLE, String(MapTown.currTownClick * 11 + int(e.currentTarget.name)) , true);
			}
		}
		
		private function getRessBattle(e:DataExchangeEvent):void 
		{	
			var obj:Object = JSON2.decode(e.result);
			if (obj.error==null) 
			{
				UserStaticData.hero.mbat = obj.res;
				UserStaticData.hero.bat = obj.res.id;
				App.lock.frees();
				App.winManajer.swapWin(3);
			}
			else
			{
				App.lock.init('Error: '+obj.error)
			}
		}
		
	}

}