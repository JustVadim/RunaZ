package artur.display {	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import report.Report;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	public class TopMenu extends Sprite {
		
		public function TopMenu() 
		{
			this.updater();
		}
		
		private function updater():void {
			var timer:Timer = new Timer(65000);
			timer.addEventListener(TimerEvent.TIMER, this.updateEnergy);
			timer.start();
		}
		
		public function updateEnergy(e:TimerEvent = null):void  {
			if (DataExchange.loged) {
				var data:DataExchange = new DataExchange();
				data.addEventListener(DataExchangeEvent.ON_RESULT, onUpdateRes);
				data.sendData(COMMANDS.CHECK_ENERGY, "", true);
			}
		}
		
		private function onUpdateRes(e:DataExchangeEvent):void {
			//Report.addMassage(e.result);
			//update bar if visible;
			
		}
		
	}

}