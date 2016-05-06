package artur.win 
{
	import artur.App;
	import artur.display.MyBitMap;
	import artur.display.Task;
	import flash.display.Bitmap;
	import flash.events.Event;
	import report.Report;
	import Server.Lang;
	
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Utils.json.JSON2;
	
	
	public class WinManajer 
	{
		public var windows:Array = 
		[
			new WinRoot(),//0 
			new WinCastle(), //1
			new WinMap(), //2
			new WinBattle(),//3
			new WinKyz(),//4
			new WinArena(),//5
		    new WinFortuna()//6
		];
		public var currWin:int=0;
		public var neadWin:int=0;
		private var brama:mcAnimBrama = new mcAnimBrama();
		public var swapMode:Boolean = false;
		public static var taskWasShown:Boolean = false;
		private var is_fb_checked:Boolean = false;
		
		public function WinManajer() {
			if (UserStaticData.hero.bat == -1) {
				swapWin(6)
			} else {
			    swapWin(3)	 
			}
			
			var bm1:MyBitMap = new MyBitMap(App.prepare.cach[16]);
			var bm2:MyBitMap = new MyBitMap(App.prepare.cach[16]);
			brama.mc.addChild(bm1); brama.mc2.addChild(bm2);
		}
		
		public function swapWin(neadWin:int):void {
			windows[currWin].bin = false;
			this.neadWin = neadWin;
			App.spr.addChild(brama);
			brama.gotoAndPlay(1);
			swapMode = true;
		}
		
		public function update():void {
			windows[currWin].update();
			if (swapMode) {
				if (brama.currentFrame == 2 || brama.currentFrame == 25) {
					App.sound.playSound('move', App.sound.onVoice,1);
				}
				if (brama.currentFrame == 20) {
					App.clear();
					App.topPanel.frees();
					windows[currWin].frees();
					currWin = neadWin;
					windows[currWin].init();
					
					App.spr.addChild(brama);
				} else if (brama.currentFrame == brama.totalFrames) {
					App.spr.removeChild(brama);
					brama.stop();
					swapMode = false;
					if(currWin != 3) {
						App.dialogManager.canShow();
					}
				}
			}
		}
		
		private function checkFriendBonus():void {
			this.is_fb_checked = true;
			if(UserStaticData.hero.sett.app_i == 1 && UserStaticData.hero.sett.app_m == 1 && UserStaticData.hero.sett.app_g && UserStaticData.hero.sett.app_fq > 9) {
				new DataExchange().sendData(COMMANDS.CHECK_FRIENDS_BONUS, "", false);
			}
		}
		
		
		public static function checkTask():void {
			if(UserStaticData.hero.t.tn != 0) {
				if (UserStaticData.hero.t.tp == 0 && !WinManajer.taskWasShown) {
					WinManajer.taskWasShown = true;
					App.task.init();
					Main.THIS.chat.addBtn();
				} else if(UserStaticData.hero.t.tp == UserStaticData.hero.t.pa) {
					App.task.init();
				}
			}
		}
	}

}