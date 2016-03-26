package artur.display 
{
	import artur.RasterClip;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Som911
	 */
	public class UpPanel extends Sprite
	{
		private var bg:Bitmap 
		private var btns:Array 
		public function UpPanel() 
		{
			var mc:MovieClip  =new  bgTopMenu()
			bg = RasterClip.raster(mc, mc.width, mc.height);
			this.addChild(bg);
		    btns = [new BaseButton(51), new BaseButton(52), new BaseButton(53), new BaseButton(54), new BaseButton(55)];
			var xps:Array = [127.5,257.5,387.5,517.5,659.75];
			for (var i:int = 0; i < 5; i++) 
			{
				btns[i].x  = xps[i];
				btns[i].y  = 38;
				this.addChild(btns[i])
			}
		}

		
	}

}