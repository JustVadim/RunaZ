package Chat 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;


	public class UserInListDialog extends Sprite
	{
		public function UserInListDialog(user_id:String) 
		{
			/*this.user_id = user_id;
			if (this.stage) onThisAddedToStage();
			else this.addEventListener(Event.ADDED_TO_STAGE, onThisAddedToStage);*/
		}
		/*private var user_inlist_dialog_graph:MovieClip = new Graphics.UserInListDialogGraph();
		private var user_id:String = "";
		private var haur_ban:AddBunBtn;
		
		
		
		private function onThisAddedToStage(e:Event=null):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, this.onThisAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.onThisRemovedFromStage);
			this.addEventListener(MouseEvent.ROLL_OUT, this.onThisMouseOut);
			this.tabEnabled = false;
			this.mouseEnabled = false;
			this.x = mouseX + 5;
			this.y = mouseY;
			this.addChild(user_inlist_dialog_graph);
			this.user_inlist_dialog_graph.massage_btn.addEventListener(MouseEvent.ROLL_OVER, onMouseOverButton);
			this.user_inlist_dialog_graph.massage_btn.addEventListener(MouseEvent.ROLL_OUT, onMouseOutButton);
			this.user_inlist_dialog_graph.massage_btn.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownButton);
			this.user_inlist_dialog_graph.massage_btn.addEventListener(MouseEvent.MOUSE_UP, onMassageMouseClick);
			setButtonName(this.user_inlist_dialog_graph.massage_btn, ChatBasic.chat_lang_table['dialog_send_mass_btn'][UserStaticData.my_set.l]);
			
			this.user_inlist_dialog_graph.profile_btn.addEventListener(MouseEvent.ROLL_OVER, onMouseOverButton);
			this.user_inlist_dialog_graph.profile_btn.addEventListener(MouseEvent.ROLL_OUT, onMouseOutButton);
			this.user_inlist_dialog_graph.profile_btn.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownButton);
			this.user_inlist_dialog_graph.profile_btn.addEventListener(MouseEvent.MOUSE_UP, onProfileClick);
			setButtonName(this.user_inlist_dialog_graph.profile_btn, ChatBasic.chat_lang_table['dialog_prof_btn'][UserStaticData.my_set.l]);
			
			this.user_inlist_dialog_graph.private_massage_btn.addEventListener(MouseEvent.ROLL_OVER, onMouseOverButton);
			this.user_inlist_dialog_graph.private_massage_btn.addEventListener(MouseEvent.ROLL_OUT, onMouseOutButton);
			this.user_inlist_dialog_graph.private_massage_btn.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownButton);
			this.user_inlist_dialog_graph.private_massage_btn.addEventListener(MouseEvent.MOUSE_UP, onPrivateMassageClick);
			setButtonName(this.user_inlist_dialog_graph.private_massage_btn, ChatBasic.chat_lang_table['dialog_send_priv_btn'][UserStaticData.my_set.l]);
			if (UserStaticData.my_set.t == 1)
			{
				this.addChild(this.haur_ban = new AddBunBtn(this.user_id));
			}
		}
		
		private function onThisMouseOut(e:MouseEvent):void 
		{
			parent.removeChild(this);
		}
		
		private function onPrivateMassageClick(e:MouseEvent):void 
		{
			this.parent.removeChild(this);
			Main.THIS.chat.find_user.insertUser(String(this.user_id));
			Main.THIS.chat.chat_graphics.is_private.selected = true;
			Main.THIS.stage.focus = Main.THIS.chat.enter_massage;
		}
		
		private function onProfileClick(e:MouseEvent):void 
		{
			this.user_inlist_dialog_graph.profile_btn.gotoAndStop(2);
			this.parent.removeChild(this);
			Main.THIS.stage.focus = Main.THIS.chat.enter_massage;
		}
		
		private function onMassageMouseClick(e:MouseEvent):void 
		{
			this.user_inlist_dialog_graph.massage_btn.gotoAndStop(2);
			this.parent.removeChild(this);
			Main.THIS.chat.find_user.insertUser(this.user_id);
			Main.THIS.chat.chat_graphics.is_private.selected = false;
			Main.THIS.stage.focus = Main.THIS.chat.enter_massage;
		}
			
		private function onMouseDownButton(e:MouseEvent):void 
		{
			e.target.gotoAndStop(3);			
		}
		
		private function onMouseOutButton(e:MouseEvent):void 
		{
			e.target.gotoAndStop(1);	
		}
		
		private function onMouseOverButton(e:MouseEvent):void 
		{
			e.target.gotoAndStop(2);
		}
		
		private function onThisRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onThisRemovedFromStage);
			this.removeEventListener(MouseEvent.ROLL_OUT, onThisMouseOut);
			
			
			this.user_inlist_dialog_graph.massage_btn.removeEventListener(MouseEvent.ROLL_OVER, onMouseOverButton);
			this.user_inlist_dialog_graph.massage_btn.removeEventListener(MouseEvent.ROLL_OUT, onMouseOutButton);
			this.user_inlist_dialog_graph.massage_btn.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDownButton);
			this.user_inlist_dialog_graph.massage_btn.removeEventListener(MouseEvent.MOUSE_UP, onMassageMouseClick);
			
			this.user_inlist_dialog_graph.profile_btn.removeEventListener(MouseEvent.ROLL_OVER, onMouseOverButton);
			this.user_inlist_dialog_graph.profile_btn.removeEventListener(MouseEvent.ROLL_OUT, onMouseOutButton);
			this.user_inlist_dialog_graph.profile_btn.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDownButton);
			this.user_inlist_dialog_graph.profile_btn.removeEventListener(MouseEvent.MOUSE_UP, onProfileClick);
			
			this.user_inlist_dialog_graph.private_massage_btn.removeEventListener(MouseEvent.ROLL_OVER, onMouseOverButton);
			this.user_inlist_dialog_graph.private_massage_btn.removeEventListener(MouseEvent.ROLL_OUT, onMouseOutButton);
			this.user_inlist_dialog_graph.private_massage_btn.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDownButton);
			this.user_inlist_dialog_graph.private_massage_btn.removeEventListener(MouseEvent.MOUSE_UP, onPrivateMassageClick);
			
		}
		
		private function setButtonName(obj:Sprite, str:String):void
		{
			var temp_textfield:TextField = new TextField();
			temp_textfield.selectable = false;
			temp_textfield.tabEnabled = false;
			temp_textfield.textColor = 0xFFFFFF;
			temp_textfield.alpha = 0.8;
			temp_textfield.autoSize = "left";
			temp_textfield.htmlText = "<font size=\"15\">"+str;
			temp_textfield.x = (obj.width - temp_textfield.width) / 2;
			obj.addChild(temp_textfield);
			obj.useHandCursor = true;
			obj.mouseChildren = false;
			obj.buttonMode = true;
		}
	}*/
	}

}