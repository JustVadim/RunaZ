package Chat 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.filters.GlowFilter;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.MouseCursor;
	import report.Report;
	import Utils.Functions;

	public class UserInList extends chatBlank
	{
		private var level_textfield:TextField = new TextField();
		private var title:TextField = new TextField();
		
		private var user_id:String = "";
		
		public function UserInList(array_num:int) 
		{
			this.mouseChildren = false;
			this.gotoAndStop(1);
			this.y = 25 * array_num;
			this.tabEnabled = false;
			this.buttonMode = true;
			this.addChild(this.title = Functions.getTitledTextfield(36, 2, 120, 20, new Art().fontName, 11, 0xFFFFFF, TextFormatAlign.LEFT, "", 1));
			this.addChild(this.level_textfield = Functions.getTitledTextfield(15, 2, 22, 20, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.CENTER, "", 1));
			this.title.filters = [new GlowFilter(0x0, 1, 2, 2)];
			this.level_textfield.filters = [new GlowFilter(0x0, 1, 2, 2)];
			
			/*this.addChild(this.level_textfield = Functions.TitleTextfield(0, 1, "", 11, 1, 0xFFFFFF, true));
			this.addChild(this.title = Functions.TitleTextfield(0, -2, "", 10, 0.7, 0xFFFFFF, false)); this.title.mouseEnabled = true;*/
		}
		
		public function update(id:String):void
		{
			this.user_id = id;
			if (!this.stage)
			{
				Main.THIS.chat.users_online_sprite.addChild(this);
				this.title.addEventListener(MouseEvent.CLICK, onNickNameClick);
			}
			this.level_textfield.text = UserStaticData.users_info[id]["lvl"];
			
			this.level_textfield.cacheAsBitmap = true;
			this.title.htmlText = UserStaticData.users_info[id]["sn"] + " " + UserStaticData.users_info[id]["fn"];
			//this.title.x = level_sign.x + level_sign.width;
			title.cacheAsBitmap = true;
			
		}
		
		public function remove():void
		{
			if (this.stage)
			{
				this.parent.removeChild(this);
			}
		}
		
		private function onNickNameClick(e:MouseEvent):void 
		{
			Main.THIS.chat.addChild(new UserInListDialog(this.user_id));
		}		
	}

}