package 
{
	import artur.App;
	import Chat.ChatBasic;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.system.Security;
	import report.Report;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Utils.json.JSON2;
	
	public class Main extends Sprite 
	{
		public static var THIS:Main;
		public static var rep:Report;
		public var app:App;
		private var mcOff:mcOffSide = new mcOffSide();
		public var chat:ChatBasic;
		
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, this.init);
			Security.loadPolicyFile("xmlsocket://" + UserStaticData.server_ip + ":3000");
			Main.THIS = this;
			stage.addChild(rep = new Report());
			DataExchange.socket.addEventListener(DataExchangeEvent.ON_LOGIN_COMPLETE, this.onLogin);
			DataExchange.setConnection();
		}
		
		
		private function onLogin(e:DataExchangeEvent = null):void 
		{
			DataExchange.socket.removeEventListener(DataExchangeEvent.ON_LOGIN_COMPLETE, this.onLogin);
			DataExchange.socket.addEventListener(DataExchangeEvent.DISCONECTED, this.CloseApp);
			stage.addChild(this.chat = new ChatBasic());
			this.addChild(this.app = new App());
			this.addChild(this.mcOff);
			stage.addChild(new movieMonitor());
		}
		
		private function CloseApp(e:DataExchangeEvent):void 
		{
			DataExchange.socket.addEventListener(DataExchangeEvent.DISCONECTED, this.CloseApp);
			while (this.numChildren > 0)
				this.removeChildAt(0);
			this.chat.parent.removeChild(this.chat);
		}
		
	}
	
}