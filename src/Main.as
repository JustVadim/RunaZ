package  {
	import _SN_vk.APIConnection;
	import _SN_vk.events.CustomEvent;
	import artur.App;
	import artur.display.McAfterBattleLoseExtend;
	import artur.display.McWinAfterBattleExtend;
	import artur.display.WinRootMcText;
	import Chat.ChatBasic;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.TimerEvent;
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
		public static var spr:Sprite
		public function Main():void 
		{
			if (stage) {
				this.init();
			} else {
				this.addEventListener(Event.ADDED_TO_STAGE, this.init);
			}
		}
		private function init(e:Event = null):void {
			spr  = Sprite(this);
			Lang.init();	
			this.removeEventListener(Event.ADDED_TO_STAGE, this.init);
			Main.THIS = this;
			this.stage.addChild(rep = new Report());
			UserStaticData.flash_vars = this.stage.loaderInfo.parameters as Object;
			if (UserStaticData.flash_vars['api_id']) {
				this.vkPrepare();
			}
			Security.loadPolicyFile("xmlsocket://" + UserStaticData.server_ip + ":3000");
			Security.allowDomain("*");
			DataExchange.socket.addEventListener(DataExchangeEvent.ON_LOGIN_COMPLETE, this.onLogin);
			DataExchange.setConnection();
		}
		
		private function vkPrepare():void {
			Main.VK = new APIConnection(UserStaticData.flash_vars);
			var api_res:Object = JSON2.decode(UserStaticData.flash_vars.api_result);
			UserStaticData.from = "v";
			UserStaticData.fname = api_res.response[0].first_name;
			UserStaticData.sname = api_res.response[0].last_name;
			UserStaticData.plink = api_res.response[0].photo_100;
			UserStaticData.id = api_res.response[0].uid;
			UserStaticData.friend_invited = UserStaticData.flash_vars.user_id;
			Main.VK.addEventListener('onOrderSuccess', Main.onVkPayment);
			//Main.VK.addEventListener('onSettingsChanged', Main.down_menu.onSettingsChanged);
		}
		
		private static function onVkPayment(e:CustomEvent):void {
			new DataExchange().sendData(COMMANDS.BYE_COINS, String(e.params[0]), false);
		}
		
		private function onLogin(e:DataExchangeEvent = null):void {
			DataExchange.socket.removeEventListener(DataExchangeEvent.ON_LOGIN_COMPLETE, this.onLogin);
			DataExchange.socket.addEventListener(DataExchangeEvent.DISCONECTED, this.CloseApp);
			this.chat = new ChatBasic();
			this.app = new App(this.stage);
			
			//this.addChild(topMenu);
			app.y = 44;
			
			if(Preloader.loader!=null) {
				TweenLite.to(Preloader.loader, 0.4, { alpha:0.2 , onComplete:this.onHalfPreloader} );
			}
			
		}
		
		private function onHalfPreloader():void {
			stage.addChild(this.chat);
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
			if(this.chat.parent){
				this.chat.parent.removeChild(this.chat);
			}
		}
		
	}
}