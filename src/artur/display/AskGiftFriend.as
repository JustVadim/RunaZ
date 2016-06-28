package artur.display {
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Server.Lang;
	import Utils.json.JSON2;
	import artur.App;
	import artur.RasterClip;
	import artur.win.WinKyz;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.net.URLRequest;
	import report.Report;
	public class AskGiftFriend extends Sprite{
		private var userObj:Object;
		private var loader:Loader = new Loader();
		private var type:int;
		private var gal:Bitmap;
		
		
		public function AskGiftFriend(num:int, type:int, xx:Number, yy:Number) {
			this.x = xx;
			this.y = yy;
			this.userObj = UserStaticData.ASK_FRIENDS[num];
			this.buttonMode = true;
			this.addEventListener(Event.ADDED_TO_STAGE, this.added);
			this.mouseChildren = false;
			this.type = type;
		}
		
		private function added(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, this.added);
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
			this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoad);
			this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
			this.loader.load(new URLRequest(userObj.photo_100));
			this.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
			this.addEventListener(MouseEvent.ROLL_OVER, this.onOver);
			this.addEventListener(MouseEvent.CLICK, this.onClick);
		}
		
		private function onClick(e:MouseEvent):void {
			Report.addMassage("clicked");
			if (this.type == 0) {
				if (UserStaticData.from == "v") {
					var mass:String = this.userObj.first_name + ", подари мне пожалуйста " + Lang.getTitle(43, AskGiftDialog.stoneNum) + ". Я тебе заранее благодарен за твоё великодушие."
					Main.VK.addEventListener("onRequestSuccess", this.onSuckes);
					Main.VK.addEventListener("onRequestCancel", this.onCancel);
					Main.VK.addEventListener("onRequestFail", this.onFail);
					Main.VK.callMethod("showRequestBox", int(this.userObj.user_id), mass, AskGiftDialog.stoneNum);
					
				}
			} else {
				App.lock.init();
				var data:DataExchange = new DataExchange();
				data.addEventListener(DataExchangeEvent.ON_RESULT, this.onMakeGift);
				data.sendData(COMMANDS.MAKE_GIFT, UserStaticData.from + this.userObj.user_id, true);
			}
		}
		
		private function onMakeGift(e:DataExchangeEvent):void {
			DataExchange(e.target).removeEventListener(e.type, onMakeGift);
			var res:Object = JSON2.decode(e.result);
			if(res.error == null) {
				if(res.res.tl > 0) {
					UserStaticData.hero.sg = res.res;
					WinKyz.dt_gift = res.res.tl;
					WinKyz.inst.updateGiftBtn();
					WinKyz.inst.changeGiftStone();
					if(UserStaticData.from == "v") {
						Main.VK.callMethod("showRequestBox", int(this.userObj.user_id), "Я подарил тебе " + Lang.getTitle(43, AskGiftDialog.stoneNum) + ", но не нужно благодарности. Лучше зайди в игру и подари мне какой-то подарок.", AskGiftDialog.stoneNum);
					}
					//reques qift
				} else {
					Main.VK.callMethod("showRequestBox", int(this.userObj.user_id), "Я хотел подарить тебе подарок, но к сожалению ты еще не играл эту замечательную игру. Вступай в игру, получай и дари подарки друзьям, при этом наслаждайся игрой.", AskGiftDialog.stoneNum);					
				}
				App.lock.frees();
				WinKyz.inst.makeGiftDialog.frees();
			} else {
				App.lock.init(res.error);
			}
		}
		
		private function onFail(e:Event):void {
			Main.VK.removeEventListener("onRequestSuccess", this.onSuckes);
			Main.VK.removeEventListener("onRequestCancel", this.onCancel);
			Main.VK.removeEventListener("onRequestFail", this.onFail);
		}
		
		private function onCancel(e:Event):void {
			Main.VK.removeEventListener("onRequestSuccess", this.onSuckes);
			Main.VK.removeEventListener("onRequestCancel", this.onCancel);
			Main.VK.removeEventListener("onRequestFail", this.onFail);
		}
		
		private function onSuckes(e:Event):void {
			Main.VK.removeEventListener("onRequestSuccess", this.onSuckes);
			Main.VK.removeEventListener("onRequestCancel", this.onCancel);
			Main.VK.removeEventListener("onRequestFail", this.onFail);
			this.userObj.done = 1;
			if(this.gal == null) {
				this.gal = RasterClip.getBitmap(new SprTrue(), 1, -1, -1);
				this.gal.scaleX *= 0.5;
				this.gal.scaleY *= 0.5;
			}
			this.addChild(this.gal);
			this.mouseEnabled = false;
		}
		
		private function onOver(e:MouseEvent):void {
			this.filters = [new GlowFilter(0xFFFFFF, 1, 3, 3, 2)]
		}
		
		private function onOut(e:MouseEvent):void {
			this.filters = [];
		}
		
		private function onRemoved(e:Event):void {
			this.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
			this.addEventListener(Event.ADDED_TO_STAGE, this.added);
			this.removeEventListener(MouseEvent.ROLL_OUT, this.onOut);
			this.removeEventListener(MouseEvent.ROLL_OVER, this.onOver);
			this.removeEventListener(MouseEvent.CLICK, this.onClick);
			this.loader.unload();
			if(this.gal != null) {
				this.removeChild(this.gal);
			}
		}
		
		private function onError(e:IOErrorEvent):void {
			Report.addMassage("cant load avatar");
		}
		
		private function onLoad(e:Event):void {
			this.addChild(this.loader);
			this.loader.scaleX = this.loader.scaleY = 0.5;
			if(this.userObj.done!=null) {
				this.addChild(this.gal);
			}
		}
	}
}