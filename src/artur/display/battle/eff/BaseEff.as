package artur.display.battle.eff 
{
	import artur.display.RasterMovie;
	import artur.RasterClip;
	import artur.win.WinBattle;
	import flash.display.Sprite;
	
	public class BaseEff extends Sprite
	{
		private var movs:Array = [new RasterMovie(new mcDamage1(),true)];
		public var free:Boolean = true;
		public var type:String = 'base';
		private var currMovie:RasterMovie = null
		private var currFrame:int;
		public function BaseEff() 
		{
			
		}
		public function init(parr:Sprite,xp:int=0, yp:int=0,index:int=0):void
		{
			this.x = xp;
			this.y = yp;
			free = false;
			currMovie = movs[index];
			currFrame = 1;
			currMovie.gotoAndStop(currFrame);
			
			
			parr.addChild(this);
			this.addChild(currMovie);
		}
		public function update():void
		{
			if (!free) 
			{
				currFrame++
				if ( currFrame < currMovie.maxFrame) 
				{
					currMovie.gotoAndStop(currFrame);	
				}
				else
				   frees();
			}
		}
		public function frees():void
		{
			free = true;
			if (parent)
			  parent.removeChild(this);
			  if (currMovie)
			  {
			     this.removeChild(currMovie);
				 currMovie = null;
			  }
			 
		}
		
	}

}