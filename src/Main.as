package  {
	import Adds.VKAdds;
	import Chat.UserInList;
	import Chat.UserInListDialog;
	import _SN_vk.APIConnection;
	import _SN_vk.events.CustomEvent;
	import artur.App;
	import artur.display.McAfterBattleLoseExtend;
	import artur.display.McWinAfterBattleExtend;
	import artur.display.WinRootMcText;
	import Chat.ChatBasic;
	import artur.util.Numbs1;
	import artur.win.WinBattle;
	import com.greensock.TweenLite;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.utils.Timer;
	import report.Report;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Server.Lang;
	import Utils.json.JSON2;
	import flash.ui.Mouse;
	
	[Frame(factoryClass = "Preloader")]
	
	public class Main extends Sprite {
		public static var THIS:Main;
		public static var rep:Report;
		public var app:App;
		private var mcOff:mcOffSide = new mcOffSide();
		public var chat:ChatBasic;
		public static var VK:APIConnection;
		
		
		public function Main():void {
			if (stage) {
				this.init();
			} else {
				this.addEventListener(Event.ADDED_TO_STAGE, this.init);
			}
		}
		
		private function init(e:Event = null):void {
			Lang.init();	
			this.removeEventListener(Event.ADDED_TO_STAGE, this.init);
			Main.THIS = this;
			UserStaticData.flash_vars = this.stage.loaderInfo.parameters as Object;
			this.stage.addChild(rep = new Report());
			if (UserStaticData.flash_vars['api_id']) {
				this.vkPrepare();	
			}
			UserStaticData.allId = UserStaticData.from + UserStaticData.id;
			Report.checkDoShow();
			Security.loadPolicyFile("xmlsocket://" + UserStaticData.server_ip + ":3000");
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			DataExchange.socket.addEventListener(DataExchangeEvent.ON_LOGIN_COMPLETE, this.onLogin);
			DataExchange.setConnection();
		}
		
		
		private function vkPrepare():void {
			Report.addMassage(JSON2.encode(UserStaticData.flash_vars));
			Main.VK = new APIConnection(UserStaticData.flash_vars);
			var api_res:Object = JSON2.decode(UserStaticData.flash_vars.api_result);
			UserStaticData.from = "v";
			UserStaticData.fname = api_res.response[0].first_name;
			UserStaticData.sname = api_res.response[0].last_name;
			UserStaticData.plink = api_res.response[0].photo_100;
			UserStaticData.id = api_res.response[0].uid;
			if(UserStaticData.flash_vars.user_id != "0") {
				UserStaticData.friend_invited = "v" + UserStaticData.flash_vars.user_id;
			}
			//VKAdds.init();
		}
		
		public static function onVkPayment(e:CustomEvent):void {
			new DataExchange().sendData(COMMANDS.BYE_COINS, String(e.params[0]), false);
		}
		
		private function onLogin(e:DataExchangeEvent = null):void {
			DataExchange.socket.removeEventListener(DataExchangeEvent.ON_LOGIN_COMPLETE, this.onLogin);
			DataExchange.socket.addEventListener(DataExchangeEvent.DISCONECTED, this.CloseApp);
			this.app = new App(this.stage);
			this.chat = new ChatBasic();
			App.dialogManager.init();
			if(Preloader.loader!=null) {
				TweenLite.to(Preloader.loader, 0.4, { alpha:0.2 , onComplete:this.onHalfPreloader} );
			}
			
		}
		
		private function onHalfPreloader():void {
			stage.addChildAt(this.chat, 1);
			this.addChild(this.app);
			this.addChild(this.mcOff);
			///stage.addChild(new movieMonitor());
			TweenLite.to(Preloader.loader, 0.1, { alpha:0 , onComplete:this.onPreloader } );
		}
		
		private function onPreloader():void  {
			Preloader.loader.parent.removeChild(Preloader.loader);
			Preloader.loader = null;
		}
		
		public function CloseApp():void {
			DataExchange.socket.addEventListener(DataExchangeEvent.DISCONECTED, this.CloseApp);
			while (this.numChildren > 0) {
				this.removeChildAt(0);
			}
			if (this.chat.parent != null){
				this.chat.parent.removeChild(this.chat);
			} 
			if(WinBattle.battleChat.parent != null) {
				WinBattle.battleChat.parent.removeChild(WinBattle.battleChat);
			}
			App.lock.init("Connection was closed. Reload application please.")
		}
		
	}
}