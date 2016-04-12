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
			this.addChild(this.title = Functions.getTitledTextfield(38, 2, 120, 20, new Art().fontName, 10, 0xFFFFFF, TextFormatAlign.LEFT, "", 1));
			this.addChild(this.level_textfield = Functions.getTitledTextfield(14, 1, 22, 20, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.CENTER, "", 1));
			this.title.filters = [new GlowFilter(0x0, 1, 2, 2)];
			this.level_textfield.filters = [new GlowFilter(0x0, 1, 2, 2)];
		}
		
		public function update(id:String):void {
			this.user_id = id;
			this.addEventListener(MouseEvent.CLICK, onNickNameClick);
			if (!this.stage) {
				Main.THIS.chat.users_online_sprite.addChild(this);
			}
			var userObj:Object = UserStaticData.users_info[id];
			Functions.compareAndSet(this.level_textfield, userObj["lvl"]);
			Functions.compareAndSet(this.title, userObj["sn"] + " " + userObj["fn"]);
		}
		
		public function remove():void {
			if (this.stage) {
				this.parent.removeChild(this);
				this.title.removeEventListener(MouseEvent.CLICK, onNickNameClick);
			}
		}
		
		private function onNickNameClick(e:MouseEvent):void {
			ChatBasic.userDialog.init(e.stageX + 15, e.stageY + 5, this.user_id, 1);
		}		
	}

}