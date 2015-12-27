package artur.win 
{
	import artur.App;
	import artur.display.MyBitMap;
	/**
	 * ...
	 * @author Som911
	 */
	public class WinArena 
	{
		public var bin:Boolean = false;
		private var bg:MyBitMap;
		public function WinArena() 
		{
			bg = new MyBitMap(App.prepare.cach[39]);
		}
		public function init():void 
		{
			App.spr.addChild(bg);
		
			//WinCastle.txtCastle.scroll.visible = false;
			//WinCastle.txtCastle.txtGold.text = String(UserStaticData.hero.gold);
			//WinCastle.txtCastle.txtSilver.text = String(UserStaticData.hero.silver);
			App.topPanel.init(this);
		}
		public function update():void
		{
			
		}
		public function frees():void
		{
			
		}
	}

}