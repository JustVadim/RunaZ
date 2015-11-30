package artur.display 
{
	import artur.App;
	import artur.display.battle.MissionBlank;
	import artur.util.GetServerData;
	import artur.win.WinMap;
	import flash.events.MouseEvent;
	import report.Report;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Server.Lang;
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
				var blank:MissionBlank = new MissionBlank(i, 235, 106 + 21 * i, this.onBatle);
				blanks.push(blank);
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
			
			for (var i:int = 0; i < blanks.length; i++) {
				var blank:MissionBlank = MissionBlank(blanks[i]);
				blank.setName(Lang.getTitle(0,MapTown.currTownClick * 11 + i));
				if (obj[i] != null) {
					blank.hasComplete(obj[i]);
				} else {
					blank.hideMission();
				}
			}
			
		}
		
		private function onBatle(e:MouseEvent):void 
		{
			if (GetServerData.getUserIsReadyToBattle()) {
				var missNum:int = int(e.currentTarget.name)
				WinMap.sprSelLevel.init(missNum, UserStaticData.hero.miss[MapTown.currTownClick].mn[missNum]);
			} else {
				App.closedDialog.init(Lang.getTitle(36) , true);
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
				if (obj.error == 1) {
					App.lock.frees();
					App.closedDialog.init(Lang.getTitle(37), false);
				} else {
					App.lock.init('Error: ' + obj.error)
				}
			}
		}
		
	}

}