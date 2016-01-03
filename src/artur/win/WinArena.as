package artur.win {
	import artur.App;
	import artur.display.BaseButton;
	import artur.display.MyBitMap;
	import artur.util.GetServerData;
	import flash.events.MouseEvent;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Utils.Functions;
	import Utils.json.JSON2;
	
	public class WinArena {
		
		public var bin:Boolean = false;
		private var bg:MyBitMap;
		private var btn1:BaseButton;
		private var btnClose:BaseButton 
		private var mcFound:mcFounMovie = new mcFounMovie();
		
		
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
			if(UserStaticData.hero.level >= 1 && GetServerData.getUserIsReadyToBattle()) {
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
				//add dialog
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
		}
		public function update():void {
			if (mcFound.currentFrame == mcFound.totalFrames) {
				mcFound.rotation += 2;
				mcFound.rot.visible = true;
				mcFound.rot.rotation = -mcFound.rotation; 
			}
		}
		
		public function frees():void {
			btn1.removeEventListener(MouseEvent.CLICK, onBtn);
			btnClose.removeEventListener(MouseEvent.CLICK, onBtnClose);
		}
	}

}