package artur.display 
{
	import artur.PrepareGr;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	public class MyBitMap extends Bitmap
	{

		public function MyBitMap(bmd:BitmapData) 
		{
			super(bmd,'auto', true);
			this.width /= PrepareGr.scaleFactor;
			this.height /= PrepareGr.scaleFactor;
	    }
		
		
	}

}