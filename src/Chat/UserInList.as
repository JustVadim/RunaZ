package Chat 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.MouseCursor;
	import report.Report;

	public class UserInList extends Sprite
	{
		
		private var from_socnet:MovieClip = new MovieClip();
		private var level_sign:Sprite = new Sprite();
		private var level_textfield:TextField = new TextField();
		private var title:TextField = new TextField();
		
		private var user_id:String = "";
		
		public function UserInList(array_num:int) 
		{
			this.y = 25 * array_num;
			this.tabEnabled = false;
			this.mouseEnabled = false;
			this.from_socnet.tabEnabled = false;
			this.from_socnet.mouseEnabled = false;
			this.from_socnet.mouseChildren = false;
			this.from_socnet.width = this.from_socnet.height = 18;
			this.addChild(from_socnet);
			//Functions.makeSpriteAtributes(this.level_sign, false, false, false, this.from_socnet.width + 1, 0, false);
			this.level_sign.width = this.level_sign.height = 17;
			this.addChild(level_sign);
			
			this.level_textfield = new TextField();
			this.title = new TextField();
			this.title.tabEnabled = false;
			this.title.x = 0;
			this.title.y = -2;
			this.addChild(this.title);
			this.addChild(this.level_textfield);
			
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
			this.level_textfield.x = this.level_sign.x + (this.level_sign.width - level_textfield.width) / 2;
			this.level_textfield.cacheAsBitmap = true;
			this.title.htmlText = "<font size = \"14\"><a href= 'event:'>" + UserStaticData.users_info[id]["sn"] + " " + UserStaticData.users_info[id]["fn"] + "</a></font>";
			this.title.x = level_sign.x + level_sign.width;
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