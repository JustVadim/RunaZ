package artur.display {	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	public class TopMenu extends Sprite {
		
		public function TopMenu() 
		{
			this.updater();
		}
		
		private function updater():void 
		{
			var timer:Timer = new Timer(65000);
			timer.addEventListener(TimerEvent.TIMER, this.onUpdate);
			timer.start();
		}
		
		private function onUpdate(e:TimerEvent):void  {
			if (DataExchange.loged) {
				var data:DataExchange = new DataExchange();
				data.addEventListener(DataExchangeEvent, onUpdateRes);
				new DataExchange().sendData("1500", "", false);
			}
		}
		
		private function onUpdateRes(e:DataExchangeEvent):void 
		{
			//update bar if visible;
			
		}
		
	}

}