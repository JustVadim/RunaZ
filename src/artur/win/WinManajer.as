package artur.win 
{
	import artur.App;
	import artur.display.MyBitMap;
	import flash.display.Bitmap;
	import report.Report;
	import Utils.json.JSON2;
	
	public class WinManajer 
	{
		public var windows:Array = [new WinRoot(), new WinCastle(), new WinMap(),new WinBattle];
		public var currWin:int=0;
		public var neadWin:int=0;
		private var brama:mcAnimBrama = new mcAnimBrama();
		private var swapMode:Boolean = false;
		public function WinManajer() 
		{
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
				}
			}
		}
		
		
	}

}