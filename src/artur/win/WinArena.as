package artur.win {
	import artur.App;
	import artur.display.BaseButton;
	import artur.display.MyBitMap;
	import artur.util.GetServerData;
	import flash.events.MouseEvent;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Server.Lang;
	import Utils.Functions;
	import Utils.json.JSON2;
	
	public class WinArena {
		
		public var bin:Boolean = false;
		private var bg:MyBitMap;
		private var btn1:BaseButton;
		private var btnClose:BaseButton 
		private var mcFound:mcFounMovie = new mcFounMovie();
		public static const NEEDED_LVL:int = 2;
		
		
		public function WinArena() {
			bg = new MyBitMap(App.prepare.cach[39]);
			btn1 = new BaseButton(40);
			btnClose = new BaseButton(31);
			btn1.x = 400;
			btn1.y = 100;
			mcFound.x = 400;
			mcFound.y = 250;
			mcFound.gotoAndStop(1);
		}
		
		private function onBtnClose(e:MouseEvent):void {
			App.info.frees();
			App.lock.init();
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, this.onRes1);
			data.sendData(COMMANDS.FIND_BATTLE, "", true);
		}
		
		private function onRes1(e:DataExchangeEvent):void 
		{
			App.spr.removeChild(mcFound);
			mcFound.gotoAndStop(1);
			App.spr.removeChild(btnClose);
			App.lock.frees();
		}
		
		private function onBtn(e:MouseEvent):void {
			App.info.frees();
			if(UserStaticData.hero.level >= WinArena.NEEDED_LVL && GetServerData.getUserIsReadyToBattle()) {
				mcFound.rotation = 0;
				mcFound.rot.visible = false;
				mcFound.gotoAndPlay(1);
				App.spr.addChild(mcFound);
				App.spr.addChild(btnClose);
				btnClose.x = e.currentTarget.x;
				btnClose.y = e.currentTarget.y + 50;
				var data:DataExchange = new DataExchange();
				data.addEventListener(DataExchangeEvent.ON_RESULT, this.onRes);
				data.sendData(COMMANDS.FIND_BATTLE, "", true);
				App.lock.init()
				
			} else {
				if(UserStaticData.hero.level < WinArena.NEEDED_LVL) {
					App.closedDialog.init(Lang.getTitle(44), false, true, false);
				} else if(!GetServerData.getUserIsReadyToBattle()) {
					App.closedDialog.init(Lang.getTitle(36), true, false, false);
				}
			}
		}
		
		private function onRes(e:DataExchangeEvent):void {
			var obj:Object = JSON2.decode(e.result);
			if (obj.res == null) {
				App.spr.removeChild(this.mcFound);
				App.spr.removeChild(this.btnClose);
				App.lock.init("ERRRORRRR!!!!!!");
			} else {
				App.lock.frees();
			}
		}
		
		public function init():void {
			App.spr.addChild(bg);
		    App.spr.addChild(btn1);
			mcFound.gotoAndStop(1);
			mcFound.rotation = 0;
			mcFound.rot.visible = false;
			App.topPanel.init(this);
			btn1.addEventListener(MouseEvent.CLICK, onBtn);
			btnClose.addEventListener(MouseEvent.CLICK, onBtnClose);
			btn1.addEventListener(MouseEvent.ROLL_OVER, this.onBattleOver);
			btn1.addEventListener(MouseEvent.ROLL_OUT, this.onBattleBtnOut);
		}
		
		private function onBattleBtnOut(e:MouseEvent):void 
		{
			App.info.frees();
		}
		
		private function onBattleOver(e:MouseEvent):void {
			var mc:BaseButton = BaseButton(e.target);
			App.info.init(mc.x + mc.width - 130, mc.y + mc.height - 25, { txtInfo_w:110, txtInfo_h:37, txtInfo_t:Lang.getTitle(51), type:0 });
		}
		public function update():void {
			if (mcFound.currentFrame == mcFound.totalFrames) {
				mcFound.rotation += 2;
				mcFound.rot.visible = true;
				mcFound.rot.rotation = -mcFound.rotation; 
			}
		}
		
		public function frees():void {
			App.info.frees();
			btn1.removeEventListener(MouseEvent.CLICK, onBtn);
			btnClose.removeEventListener(MouseEvent.CLICK, onBtnClose);
			btn1.removeEventListener(MouseEvent.ROLL_OVER, this.onBattleOver);
			btn1.removeEventListener(MouseEvent.ROLL_OUT, this.onBattleBtnOut);
		}
	}

}