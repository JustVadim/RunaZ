package artur.win 
{
	import artur.App;
	import artur.display.MyBitMap;
	import flash.display.Bitmap;
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
		new WinKyz()//4
		];
		public var currWin:int=0;
		public var neadWin:int=0;
		private var brama:mcAnimBrama = new mcAnimBrama();
		private var swapMode:Boolean = false;
		
		public function WinManajer() 
		{
			Report.addMassage(UserStaticData.hero.bat)
			Report.addMassage(JSON2.encode(UserStaticData.hero.mbat));
			if (UserStaticData.hero.bat == -1)
			{
				swapWin(0)
			}
			else
			{
			    swapWin(3)	 
			}
			
			var bm1:MyBitMap = new MyBitMap(App.prepare.cach[16]);
			var bm2:MyBitMap = new MyBitMap(App.prepare.cach[16]);
			brama.mc.addChild(bm1); brama.mc2.addChild(bm2);
		}
		public function swapWin(neadWin:int):void
		{
			 windows[currWin].bin = false;
			 this.neadWin = neadWin;
		     App.spr.addChild(brama);
			 brama.gotoAndPlay(1);
			 swapMode = true;
		}
		public function update():void
		{
			windows[currWin].update();
			if (swapMode) 
			{
				if (brama.currentFrame == 2 || brama.currentFrame == 25)
				   App.sound.playSound('move', App.sound.onVoice,1);
				
				if (brama.currentFrame==20) 
				{
					 App.clear();
				     App.topPanel.frees();
				 	 windows[currWin].frees();
					 currWin = neadWin;
					 windows[currWin].init();
				     App.spr.addChild(brama);
				}
				else if (brama.currentFrame == brama.totalFrames)
				{
					App.spr.removeChild(brama);
					brama.stop();
					swapMode = false;
					if (this.currWin < 3)
					{
						this.isLevelUp();
					}
				}
			}
		}
		
		private function isLevelUp():void 
		{
			for (var key:Object in UserStaticData.hero.units)
			{
				var unit:Object = UserStaticData.hero.units[key];
				if (unit.exp >= unit.nle)
				{
					var data:DataExchange = new DataExchange();
					data.addEventListener(DataExchangeEvent.ON_RESULT, this.onLevelUpRes);
					data.sendData(COMMANDS.UNIT_LEVEL_UP, key.toString(), true);
				}
			}
		}
		
		private function onLevelUpRes(e:DataExchangeEvent):void 
		{
			DataExchange(e.target).removeEventListener(DataExchangeEvent.ON_RESULT, this.onLevelUpRes);
			var obj:Object = JSON2.decode(e.result);
			if (obj.error == null)
			{
				var unit:Object = UserStaticData.hero.units[obj.num];
				unit.exp = 0;
				unit.lvl = obj.lvl;
				unit.nle = obj.nle;
				unit.fs = obj.fs;
				App.closedDialog.init(Lang.getTitle(2), true);
				
			}
			else
			{
				App.lock.init(obj.error);
			}
		}
		
		
	}

}