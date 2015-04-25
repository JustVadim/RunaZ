package Chat 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;

	public class FindUser extends TextField
	{
		public var inside:Boolean = false;
		public var user_id:String = "0";
		private var chat:ChatBasic;
		
		public function FindUser() 
		{
			this.maxChars = 15;
			this.x = 12;
			this.y = -4;
			this.textColor = 0xFFFFFF;
			this.type = "input";
			this.text = "Поиск игрока";
			this.alpha = 0.6;
			this.height = 22;
			this.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
			this.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			this.addEventListener(KeyboardEvent.KEY_UP, onTextInput);
			this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.chat = ChatBasic(this.parent.parent);
		}
		
		private function onTextInput(e:KeyboardEvent):void 
		{
			//ChatBasic(this.parent.parent).
			this.chat.updateUserList(this.text);
		}
		
		
		
		public function insertUser(user_id:String):void
		{
			this.removeEventListener(FocusEvent.FOCUS_IN, onFocusIn);
			this.removeEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			this.removeEventListener(TextEvent.TEXT_INPUT, onTextInput);
			this.user_id = user_id;
			this.selectable = false;
			this.text = UserStaticData.users_info[this.user_id].sn + " " + UserStaticData.users_info[this.user_id].fn;
			this.inside = true;
			this.chat.clear_nickname_btn.gotoAndStop(2);
			this.chat.clear_nickname_btn.addEventListener(MouseEvent.MOUSE_DOWN, onInsertedUserClick);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onInsertedUserClick);
			this.chat.is_private.enabled = true;
		}
		
		public function onInsertedUserClick(e:MouseEvent = null):void 
		{
			this.chat.clear_nickname_btn.removeEventListener(MouseEvent.MOUSE_DOWN, onInsertedUserClick);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onInsertedUserClick);
			this.alpha = 0.6;
			inside = false;
			this.user_id = "0";
			this.tabEnabled = true;
			this.selectable = true;
			this.text = "Поиск игрока";
			this.chat.is_private.selected = false;
			this.chat.is_private.enabled = false;
			Main.THIS.stage.focus = this.chat.enter_massage;
			this.chat.clear_nickname_btn.gotoAndStop(1);
			this.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
			this.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
		}
		private function onFocusOut(e:FocusEvent):void 
		{
			this.chat.updateUserList();
			if (!inside)
			{
				this.text = "Поиск игрока";
				this.alpha = 0.6;
			}
		}
		
		private function onFocusIn(e:FocusEvent):void 
		{
			this.text = "";
			this.alpha = 1;
		}
		
	}

}