package artur.win 
{
	import artur.App;
	import artur.RasterClip;
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author Som911
	 */
	public class WinKyz 
	{
		private var bg:Bitmap = RasterClip.raster(new mc_bg_kyz(), 800, 440);
		public var bin:Boolean = true;
		public function WinKyz() 
		{
			
		}
		public function init():void
		{
			App.spr.addChild(bg);
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