package artur.display {
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Utils.json.JSON2;
	import artur.App;
	import flash.events.Event;
	import report.Report;
	
	public class Profile extends mcProfile {
		private var units:Array;
		
		public function Profile() {
			this.units = new Array();
			for (var i:int = 0; i < 4; i++) {
				this.units[i] = new ProfileUnitText(223 + (i%2)*230, 144 + int((i/2))*125);
				this.addChild(units[i]);
			}
		}
		
		public function init(userId:String):void {
			this.frees();
			App.spr.addChild(this);
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, this.onHero);
			data.sendData(COMMANDS.GET_HERO, userId, true);
		}
		
		private function onHero(e:DataExchangeEvent):void {
			var res:Object = JSON2.decode(e.result);
			DataExchange(e.target).removeEventListener(e.type, this.onHero);
			if(res.error == null) {
				if (this.stage) {
					for (var i:int = 0; i < 4; i++) {
						ProfileUnitText(this.units[i]).init(res, i);
					}
				} else {
				}
			} else {
				//Report.addMassage(res.error);
			}
		}
		
		public function frees():void {
			if(this.parent) {
				this.parent.removeChild(this);
				for (var i:int = 0; i < 4; i++) {
					ProfileUnitText(this.units[i]).frees();
				}
			}
		}
	}
}