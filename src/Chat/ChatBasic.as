package Chat 
{
	import Adds.VKAdds;
	import Utils.Functions;
	import artur.App;
	import artur.display.BaseButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import report.Report;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Utils.json.JSON2;
	
	public class ChatBasic extends mcChat {
		public var users_online_sprite:Sprite = new Sprite();
		public var massages_sprite:Sprite = new Sprite();
		public var enter_massage:TextField = new TextField();
		private var users_array:Array = new Array();
		private var send_massage_de:DataExchange = new DataExchange();
		private var sended_massage:Boolean = true;
		private var last_mass_YY:int = 0;
		public var is_battle:Boolean = false;
		public var find_user:FindUser;
		public var send_btn:BaseButton;
		public var btnQ:BaseButton;
		public var btnAds:BaseButton;
		public static var userDialog:UserInListDialog = new UserInListDialog();
		
		
		public function ChatBasic() {
			this.name = "chat";
			this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
			this.tabEnabled = false;
			this.massages_scrollbar.addEventListener(MouseEvent.CLICK, setFocus);
			this.users_online_scrollbar.addEventListener(MouseEvent.CLICK, setFocus);
			this.clear_nickname_btn.gotoAndStop(1);
			this.clear_nickname_btn.buttonMode = true;
			this.users_online_scrollbar.source = users_online_sprite;
			this.massages_scrollbar.source = massages_sprite;
			
			this.enter_massage.tabEnabled = true;
			this.enter_massage.y = 573.10;
			this.enter_massage.x = 172.45;
			this.enter_massage.width = 392;
			this.enter_massage.height = 19;
			this.enter_massage.textColor = 0xFFFFFF;
			this.enter_massage.type = "input";
			this.enter_massage.maxChars = 150;
			//this.enter_massage.border = true;
			this.enter_massage.addEventListener(FocusEvent.FOCUS_IN, onEnterMassFocusIn);
			this.enter_massage.addEventListener(FocusEvent.FOCUS_OUT, onEnterMassFocusOut);
			this.addChild(enter_massage);
			this.is_private.enabled = false;
			this.find_user = new FindUser();
			this.clear_nickname_btn.addChild(this.find_user);
			this.clear_nickname_btn.tabChildren = false;
			this.is_private.addEventListener(MouseEvent.CLICK, this.onIsPrivateClick);
			this.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
			this.addChild(this.send_btn = new BaseButton(6));
			this.btnQ = new BaseButton(47);
			Functions.SetPriteAtributs(this.btnQ, true, false, 14.2, 424.2);
			this.btnAds = new BaseButton(57);
			Functions.SetPriteAtributs(this.btnAds, true, false, 40, 424.2);
			var animQvest:AnimBtn = new AnimBtn(); animQvest.mouseChildren = false; animQvest.mouseEnabled = true;
			this.btnQ.addChild(animQvest); 
			this.addChild(btnAds)
			this.send_btn.x = 586.7;
			this.send_btn.y = 582.4;
			this.send_btn.addEventListener(MouseEvent.CLICK, onSendBtnClick);
			this.send_btn.tabEnabled = false;
			this.users_online_scrollbar.tabEnabled = false;
			this.massages_scrollbar.tabEnabled = false;
			this.massages_sprite.mouseChildren = true;
			this.setFocus();
			if(UserStaticData.hero.t.tn != 0 && UserStaticData.hero.t.tp < UserStaticData.hero.t.pa) {
				this.addChild(this.btnQ);
			}
			this.btnQ.addEventListener(MouseEvent.CLICK, this.onAddedBtnQCLick);
			this.btnAds.addEventListener(MouseEvent.CLICK, this.onAdds);
		}
		
		private function onAdds(e:MouseEvent):void {
			App.achievm.init();
		}
		
		public function addBtn():void 
		{
			this.addChild(this.btnQ);
		}
		
		public function removeBtn():void {
			if(this.btnQ.parent) {
				this.removeChild(this.btnQ);
			}
		}
		
		private function onAddedBtnQCLick(e:MouseEvent):void 
		{
			App.task.init(true);
		}
		
		
		private function onSendBtnClick(e:MouseEvent):void {
			this.sendMassage();
		}
		
		private function onAddedToStage(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
			App.prop.x = 0;
			App.prop.y = 0;
			this.addChild(App.prop);
			this.updateUserList();
		}
		
		private function onKeyDown(e:KeyboardEvent):void {
			if (e.keyCode == 13) {
				this.sendMassage();
			}
		}
		
		public function updateUserList(str:String = ""):void {
			var temp_array:Array = new Array();
			var cc:int = 0;
			for (var key:Object in UserStaticData.users_info) {
				if (UserStaticData.users_info[key][6] == 1) {
					if (str == "" || String(UserStaticData.users_info[key]["fn"] + " " + UserStaticData.users_info[key]["sn"]).toLocaleLowerCase().search(str.toLocaleLowerCase())>-1 || String(UserStaticData.users_info[key]["sn"] + " " + UserStaticData.users_info[key]["fn"]).toLocaleLowerCase().search(str.toLocaleLowerCase())>-1) {
						temp_array.push(UserStaticData.users_info[key]);
					}
				}
			}
			temp_array.sort(this.sortonlevel);
			if (this.users_array.length < temp_array.length) {
				while (this.users_array.length != temp_array.length) {
					this.users_array[this.users_array.length] = new UserInList(this.users_array.length);
				}
				for (cc=0; cc < temp_array.length; cc++) {
					UserInList(users_array[cc]).update(temp_array[cc]["id"]);
				}
			} else {
				for (cc = 0; cc < temp_array.length; cc++) {
					UserInList(users_array[cc]).update(temp_array[cc]["id"]);
				}
				for (cc = temp_array.length; cc < users_array.length; cc++) {
					UserInList(this.users_array[cc]).remove();
				}
			}
			this.users_online_scrollbar.update();
		}
		private function sortonlevel(Aobj:Object, Bobj:Object):int {
			var alvl:int = int(Aobj.lvl);
			var blvl:int = int(Bobj.lvl);
			if (alvl < blvl) {
				return 1;
			} else if (alvl > blvl)  {
				return -1;
			}  else {
				return 0;
			}	
		}
		
		private function onIsPrivateClick(e:MouseEvent):void  {
			Main.THIS.stage.focus = this.enter_massage;
		}
		
		private function onEnterMassFocusOut(e:FocusEvent):void {
			if (enter_massage.length == 0) {
				enter_massage.text = "Нажмите что бы набрать сообщение";
			}
			enter_massage.alpha = 0.6;
		}
		
		private function onEnterMassFocusIn(e:FocusEvent):void {
			if (enter_massage.text == "Нажмите что бы набрать сообщение") {
				enter_massage.text = "";
			}
			enter_massage.alpha = 1.0;
		}
		
		public function setFocus(e:MouseEvent = null):void {
			Main.THIS.stage.focus = this.enter_massage;
		}
		
		private function sendMassage():void {
			while (enter_massage.text.charAt(0) == " ") {
				enter_massage.text = enter_massage.text.substr(1);
			}
			if (enter_massage.text != "" && enter_massage.text != "Нажмите что бы набрать сообщение") {	
				var mass:Object = new Object();
				mass.f = UserStaticData.my_info.id;
				mass.t = find_user.user_id;
				mass.p = Boolean(this.is_private.selected);
				mass.m = this.enter_massage.text;
				mass.b = this.is_battle;
				new DataExchange().sendData(COMMANDS.SEND_MASSAGE, JSON2.encode(mass));
				this.enter_massage.text = "";
				Main.THIS.stage.focus = this.enter_massage;
			}
		}
		
		public function addNewMass(str:String):void {
			var temp_obj:Object = JSON2.decode(str);
			var new_massage:TextField = new TextField();
			new_massage.selectable = new_massage.tabEnabled = new_massage.background = false;
			new_massage.multiline = new_massage.wordWrap = true;
			new_massage.width = 580;
			var textf:TextFormat = new TextFormat();
			textf.size = 11;
			textf.color = 0xFFFFFF;
			textf.font = new Art().fontName;
			new_massage.defaultTextFormat = textf;
			new_massage.alpha = 0.9;
			new_massage.filters = [new GlowFilter(0x0, 0.8, 3, 3, 1)];
			new_massage.text = temp_obj.d + " " + "<font size = \"12\"><u><a href = 'event:" + String(temp_obj.f) + "'>" + UserStaticData.users_info[temp_obj.f].fn + " " + UserStaticData.users_info[temp_obj.f].sn + "";
			//new_massage.border = true;
			if (temp_obj.t == "0") {
				new_massage.appendText("</a></u><b>:</b> " + temp_obj.m); 
			} else {
				new_massage.appendText("</a></u><b> -></b> <u><a href='event:" + temp_obj.t + "'>" + UserStaticData.users_info[temp_obj.t].fn + " " + UserStaticData.users_info[temp_obj.t].sn + "</a></u><b>:</b> " + temp_obj.m); 
				if (temp_obj.t == UserStaticData.allId) {
					new_massage.text = "<font color=\"#B0FFB0\">" + new_massage.text + "</font>";
				}
			}
			
			new_massage.htmlText = new_massage.text;
			new_massage.height = new_massage.numLines * 19;
			new_massage.alpha = 0.8;
			
			new_massage.addEventListener(TextEvent.LINK, this.onTextLink);
			if (!temp_obj.b) {
				new_massage.y = last_mass_YY;
				massages_sprite.addChild(new_massage);
				this.last_mass_YY += new_massage.height;
			}
			if (this.massages_scrollbar.verticalScrollPosition == this.massages_scrollbar.maxVerticalScrollPosition) {
				this.massages_scrollbar.update();
				this.massages_scrollbar.verticalScrollPosition = this.massages_scrollbar.maxVerticalScrollPosition;
			} else {
				this.massages_scrollbar.update();
			}
		}
		
		private function onTextLink(e:TextEvent):void {
			if (e.text.length > 0) {
				ChatBasic.userDialog.init(stage.mouseX - 12, stage.mouseY + 5, e.text, -1);
			}
		}
	}

}