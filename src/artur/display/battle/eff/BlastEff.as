package artur.display.battle.eff 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Som911
	 */
	public class BlastEff extends MovieClip
	{
		public var free:Boolean = true;
		public var type:String = 'blast1';
		public function BlastEff() 
		{
			
		}
		public function init(parr:Sprite, xp:int=0, yp:int=0,index:int=0):void
		{
			this.x = xp;
			this.y = yp;
			free = false;
			parr.addChild(this);
			this.addChild(currMovie);
			this.gotoAndPlay(1);
		}
		public function update():void
		{
			if (!free) 
			{
				if(currentFrame == totalFrames)
				   frees();
			}
		}
		public function frees():void
		{
			 free = true;
			 if (parent)
			    parent.removeChild(this);
		}
		
	}

}