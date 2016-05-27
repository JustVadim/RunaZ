package artur.display 
{
	import Server.Lang;
	import Utils.Functions;
	import artur.App;
	import artur.RasterClip;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.text.engine.Kerning;
	import report.Report;
	public class AskGiftDialog extends mcStonesForFriends {
		
		private var users_arr:Array;
		private var cont:Sprite = new Sprite();
		public var type:int;
		public static var stoneNum:int;
		private var title:TextField = Functions.getTitledTextfield(330, 99, 170, 20, new Art().fontName, 13, 0xFFF642, TextFormatAlign.CENTER, "", 1, Kerning.ON, 1, true);
		private var closeBtn:BaseButton;
		private var st:KyzChestStoneGraph;
		
		public function AskGiftDialog(type:int) {
			this.type = type;
			if(UserStaticData.from == "v") {
				Main.VK.api("friends.get", {user_id:UserStaticData.id, order:"hints",fields:"photo_100"}, onGetFriends, onFailFriends);
			}
			this.scroll.source = cont;
			this.title.filters = [new GlowFilter(0x0, 1, 3, 3)];
			this.addChild(this.title);
			this.closeBtn = new BaseButton(15);
			this.addChild(this.closeBtn);
			this.closeBtn.x = 410;
			this.closeBtn.y = 400;
		}
		
		private function onGetFriends(e:Array):void {
			UserStaticData.ASK_FRIENDS = e;
			Report.addMassage(JSON.stringify(e));
			users_arr = new Array();
			for (var i:int = 0; i < e.length; i++) {
				users_arr[i] = new AskGiftFriend(i,this.type, 1 + int(i % 7) * 52, 1 + int(i / 7) * 52);
			}
		}
		
		private function onFailFriends(e:Object):void {
			Report.addMassage("getFriends failed: " + JSON.stringify(e));
		}
		
		public function init(stoneNum:int):void {
			Functions.compareAndSet(this.title, Lang.getTitle(199 + this.type) + " " + Lang.getTitle(43, stoneNum));
			App.spr.addChild(this);
			this.st = KyzChestStoneGraph.getStone(stoneNum, 392, 42, 1.5);
			this.addChild(st);
			if (UserStaticData.ASK_FRIENDS != null) {
				AskGiftDialog.stoneNum = stoneNum;
				for (var i:int = 0; i < UserStaticData.ASK_FRIENDS.length; i++) {
					this.cont.addChild(users_arr[i]);
				}
				this.scroll.update();
			}
			this.closeBtn.addEventListener(MouseEvent.CLICK, this.onClick);
		}
		
		private function onClick(e:MouseEvent):void {
			this.frees();
		}
		
		public function frees():void {
			if(this.parent) {
				App.spr.removeChild(this);
				//this.removeChild(AskGiftDialog.images[AskGiftDialog.stoneNum]);
				for (var i:int = 0; i < UserStaticData.ASK_FRIENDS.length; i++) {
					this.cont.removeChild(users_arr[i]);
				}
				this.closeBtn.removeEventListener(MouseEvent.CLICK, this.onClick);
				this.st.frees();
			}
		}
	}

}