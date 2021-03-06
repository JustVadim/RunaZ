package artur.display 
{
	import artur.PrepareGr;
	import artur.RasterClip;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	
	public class RasterMovie extends Sprite
	{
		public var frames:Array = [];
		public var currFrame:int = 0;
		public var maxFrame:int;
		public var free:Boolean = false;
		
		
		public function RasterMovie(baseClip:MovieClip,getSprite:Boolean = false, filter:Object = null) 
		{
			if(filter) {
				frames = RasterClip.getAnimationBitmaps(baseClip, [filter]);
			} else {
				frames = RasterClip.getAnimationBitmaps(baseClip);
			}
			this.addChild(frames[currFrame]);
			maxFrame = frames.length -2 ;
		}
		public function gotoAndStop(frm:int):void
		{
			frm--;
			if (frm < 0) 
				frm =0;
			this.removeChild(frames[currFrame]);
			currFrame = frm
			this.addChild(frames[currFrame]);
		}
		
	}

}