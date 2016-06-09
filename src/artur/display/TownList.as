package artur.display 
{
	import artur.App;
	import artur.display.battle.MissionBlank;
	import artur.util.GetServerData;
	import artur.win.WinMap;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import report.Report;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Server.Lang;
	import Utils.Functions;
	import Utils.json.JSON2;
	
	public class TownList extends mcTownList
	{
		private var blanks:Array = [];
		public static var NAMES:Array = [[[]]];
		private var btnClose:BaseButton = new BaseButton(31);
		private var txtTitle:TextField = Functions.getTitledTextfield( -61.25, -9, 122.5, 16, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.AUTO, 0);
		
		public function TownList() {
			for (var i:int = 0; i < 11; i++) 
			{
				var blank:MissionBlank = new MissionBlank(i, 235, 106 + 21 * i, this.onBatle);
				blanks.push(blank);
				this.addChild(blank);
			}
			btnClose.x = 563 + btnClose.width / 2 ; btnClose.y = 65 + btnClose.height / 2;
			this.addChild(btnClose);
			btnClose.addEventListener(MouseEvent.CLICK, closeClick);
			this.title.addChild(this.txtTitle);
			this.txtTitle.filters = [new GlowFilter(0, 1, 3, 3, 1, 1), new DropShadowFilter(1, 42, 0xFFFFFF, 1, 1, 1, 0.5), new DropShadowFilter(1, 234, 0xFFCC99, 1, 1, 1, 0.5)];
		}
		
		private function closeClick(e:MouseEvent):void 
		{
			App.spr.removeChild(this);
		}
		
		public function init(currMap:int, currTwon:int, title:String):void {
			MapTown.currTownClick = currTwon;
			this.txtTitle.text = title;
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
		
		private function onBatle(e:MouseEvent):void {
			if (GetServerData.getUserIsReadyToBattle()) {
				var missNum:int = int(e.currentTarget.name)
				WinMap.sprSelLevel.init(missNum, UserStaticData.hero.miss[MapTown.currTownClick].mn[missNum]);
			} else {
				App.closedDialog.init1(Lang.getTitle(36) , true);
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
					App.closedDialog.init1(Lang.getTitle(37));
				} else {
					App.lock.init('Error: ' + obj.error)
				}
			}
		}
		
	}

}