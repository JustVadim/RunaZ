package artur.display {
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Utils.Functions;
	import Utils.json.JSON2;
	import artur.App;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import report.Report;
	
	public class Profile extends mcProfile {
		private var units:Array;
		private var ava_loader:Loader;
		public var lvl_star:LvlStar = new LvlStar();
		public var btnClose:BaseButton = new BaseButton(61);
		private var userId:String
		public function Profile() {
			this.units = new Array();
			for (var i:int = 0; i < 4; i++) {
				this.units[i] = new ProfileUnitText(223 + (i%2)*230, 144 + int((i/2))*125);
				this.addChildAt(units[i],1);
			}
			this.lvl_star.x = 15;
			this.lvl_star.y = 15;
			this.lvl_star.star.gotoAndStop(1);
			this.mcAva.addChild(lvl_star);
			this.addChild(this.btnClose = new BaseButton(61));
			btnClose.x = 580;
			btnClose.y = 70;
		}
		
		public function init(userId:String):void {
			this.frees();
			this.userId = userId;
			App.spr.addChild(this);
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, this.onHero);
			data.sendData(COMMANDS.GET_HERO, userId, true);
			this.getAva();
			this.btnClose.addEventListener(MouseEvent.CLICK, this.onCloseClick);
		}
		
		private function onCloseClick(e:MouseEvent):void 
		{
			this.frees();
		}
		
		private function getAva():void {
			if(this.ava_loader != null && this.ava_loader.parent) {
				this.ava_loader.parent.removeChild(this.ava_loader);
				this.ava_loader = null;
			}
			ava_loader = new Loader();
			ava_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onGetAva);
			ava_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onGetAvaError);
			ava_loader.load(new URLRequest(UserStaticData.users_info[this.userId].pl));
			
			
		}
		
		private function onGetAva(e:Event):void {
			this.ava_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onGetAva);
			this.ava_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onGetAvaError);
			this.ava_loader.tabChildren = false;
			this.ava_loader.mouseEnabled = false;
			this.ava_loader.mouseChildren = false;
			this.ava_loader.tabEnabled = false;
			this.ava_loader.width = 100;
			this.ava_loader.height = 100;
			this.ava_loader.mask = mcAva.avatarMask;
			this.mcAva.addChildAt(ava_loader, 1);
		}
		
		private function onGetAvaError(e:IOErrorEvent):void {
				this.ava_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onGetAva);
				this.ava_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onGetAvaError);
		}
		
		private function onHero(e:DataExchangeEvent):void {
			var res:Object = JSON2.decode(e.result);
			Functions.compareAndSet(this.lvl_star.txt, res.lvl);
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
				if(ava_loader.contentLoaderInfo.hasEventListener(Event.COMPLETE)) {
					this.ava_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onGetAva);
					this.ava_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onGetAvaError);
				}
				this.btnClose.removeEventListener(MouseEvent.CLICK, this.onCloseClick);
			}
		}
	}
}