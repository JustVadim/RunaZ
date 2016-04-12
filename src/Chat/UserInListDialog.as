package Chat 
{
	import Utils.Functions;
	import _SN_vk.api.DataProvider;
	import artur.App;
	import artur.display.BaseButton;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import report.Report;


	public class UserInListDialog extends Sprite {
		private var btns:Array;
		private var user_id:String;
		private var bg:mcChatDialog = new mcChatDialog();
		
		public function UserInListDialog() {
			this.addChild(bg);
			Functions.SetPriteAtributs(this, true, true);
			this.btns = new Array();
			for (var i:int = 0; i < 3; i++) {
				var btn:BaseButton = new BaseButton(58 + i, 1.05,1);
				Functions.SetPriteAtributs(btn, true, false, -63.35, -49.8 + 19 * i);
				this.addChild(this.btns[i] = btn);
			}
		}
		
		public function init(xx:Number, yy:Number, id:String, side:int = 1):void {
			//if (id != UserStaticData.from + UserStaticData.id) 
			{
				this.x = xx;
				this.y = yy;
				this.user_id = id;
				this.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
				var changeX:Boolean = false;
				if(side != this.bg.scaleX) {
					this.bg.scaleX = side;
					changeX = true;
				}
				for (var i:int = 0; i < this.btns.length; i++) {
					BaseButton(this.btns[i]).addEventListener(MouseEvent.CLICK, this.onBtnClick);
					if(changeX) {
						BaseButton(this.btns[i]).x = -BaseButton(this.btns[i]).x;
					}
				}
				Main.THIS.chat.addChild(this);
			}
		}
		
		public function frees():void {
			if(this.parent) {
				this.parent.removeChild(this);
				this.removeEventListener(MouseEvent.ROLL_OUT, this.onOut);
				for (var i:int = 0; i < this.btns.length; i++) {
					BaseButton(this.btns[i]).removeEventListener(MouseEvent.CLICK, this.onBtnClick);
				}
			}
		}
		
		private function onBtnClick(e:MouseEvent):void {
			this.frees();
			var btn:BaseButton = BaseButton(e.target);
			switch(btn) {
				case this.btns[0]:
					Main.THIS.chat.find_user.insertUser(this.user_id);
					Main.THIS.chat.is_private.selected = false;
					Main.THIS.stage.focus = Main.THIS.chat.enter_massage;
					break;
				case this.btns[1]:
					Main.THIS.chat.find_user.insertUser(this.user_id);
					Main.THIS.chat.is_private.selected = true;
					Main.THIS.stage.focus = Main.THIS.chat.enter_massage;
					break;
				case this.btns[2]:
					App.profile.init(this.user_id);
					break;
			}
		}
		
		private function onOut(e:MouseEvent):void {
			this.frees();
		}
	}

}