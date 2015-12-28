package artur.win 
{
	import artur.App;
	import artur.display.BaseButton;
	import artur.display.MyBitMap;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Som911
	 */
	public class WinArena 
	{
		public var bin:Boolean = false;
		private var bg:MyBitMap;
		private var btn1:BaseButton;
		private var mcFound:mcFounMovie = new mcFounMovie();
		public function WinArena() 
		{
			bg = new MyBitMap(App.prepare.cach[39]);
			btn1 = new BaseButton(40);
			btn1.x = 400;
			btn1.y = 100;
			mcFound.x = 400;
			mcFound.y = 250;
			mcFound.gotoAndStop(1);
			btn1.addEventListener(MouseEvent.CLICK, onBtn);
		}
		
		private function onBtn(e:MouseEvent):void 
		{
			mcFound.rotation = 0;
			mcFound.rot.visible = false;
			mcFound.gotoAndPlay(1);
		}
		public function init():void 
		{
			App.spr.addChild(bg);
		    App.spr.addChild(btn1);
			App.spr.addChild(mcFound);
			mcFound.gotoAndStop(1);
			mcFound.rotation = 0;
			mcFound.rot.visible = false;
			//WinCastle.txtCastle.scroll.visible = false;
			//WinCastle.txtCastle.txtGold.text = String(UserStaticData.hero.gold);
			//WinCastle.txtCastle.txtSilver.text = String(UserStaticData.hero.silver);
			App.topPanel.init(this);
		}
		public function update():void
		{
			if (mcFound.currentFrame == mcFound.totalFrames) 
			{
			 	 mcFound.rotation += 2;
				 mcFound.rot.visible = true;
				 mcFound.rot.rotation = -mcFound.rotation;
			}
		}
		public function frees():void
		{
			
		}
	}

}