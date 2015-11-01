package  {
	
	import artur.App;
	import Chat.ChatBasic;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.system.Security;
	import report.Report;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Server.Lang;
	import Utils.json.JSON2;
	
	[Frame(factoryClass = "Preloader")]
	public class Main extends Sprite {
		
		public static var THIS:Main;
		public static var rep:Report;
		public var app:App;
		private var mcOff:mcOffSide = new mcOffSide();
		public var chat:ChatBasic;
		
		public function Main():void {
		
			if (stage) {
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event = null):void {
			Lang.init();	
			this.removeEventListener(Event.ADDED_TO_STAGE, this.init);
			Main.THIS = this;
			stage.addChild(rep = new Report());
			try {
				UserStaticData.flash_vars = stage.loaderInfo.parameters as Object;
				if (UserStaticData.flash_vars['api_id']) {
					this.vkPrepare();
				}
				Security.loadPolicyFile("xmlsocket://" + UserStaticData.server_ip + ":3000");
				DataExchange.socket.addEventListener(DataExchangeEvent.ON_LOGIN_COMPLETE, this.onLogin);
				DataExchange.setConnection();
			} catch (err:Error) {
				Report.addMassage("error" + err.getStackTrace() + " " + err.message + " "  +err.name);
				
			}
		}
		
		private function vkPrepare():void {
			var api_res:Object = JSON2.decode(UserStaticData.flash_vars.api_result);
			UserStaticData.from = "v";
			UserStaticData.fname = api_res.response[0].first_name;
			UserStaticData.sname = api_res.response[0].last_name;
			UserStaticData.plink = api_res.response[0].photo_100;
			UserStaticData.id = api_res.response[0].uid;
			UserStaticData.friend_invited = UserStaticData.flash_vars.user_id;
		}
		
		private function onLogin(e:DataExchangeEvent = null):void {
			DataExchange.socket.removeEventListener(DataExchangeEvent.ON_LOGIN_COMPLETE, this.onLogin);
			DataExchange.socket.addEventListener(DataExchangeEvent.DISCONECTED, this.CloseApp);
			stage.addChild(this.chat = new ChatBasic());
			this.addChild(this.app = new App(this.stage));
			this.addChild(this.mcOff);
			stage.addChild(new movieMonitor());
		}
		
		private function CloseApp(e:DataExchangeEvent):void {
			DataExchange.socket.addEventListener(DataExchangeEvent.DISCONECTED, this.CloseApp);
			while (this.numChildren > 0) {
				this.removeChildAt(0);
			}
			this.chat.parent.removeChild(this.chat);
		}
		
	}
}