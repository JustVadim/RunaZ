package artur.display.battle.eff 
{
	import artur.App;
	import artur.display.RasterMovie;
	import artur.RasterClip;
	import artur.win.WinBattle;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	
	public class BaseEff extends Sprite
	{
		private var movs:Array = [
		                                         new RasterMovie(new mcDamage1(), true,new GlowFilter(0x000000,1,3,3)), //0
		                                         new RasterMovie(new effHill(), true), //1
												 new RasterMovie(new effBAttleCry(), true), //2 
												 new RasterMovie(new mcEffArrow(), true,new GlowFilter(0x000000,1,3,3)), //3
		                                         new RasterMovie(new mcEffBlast1(), true, new GlowFilter(0x000000, 1, 3, 3)), //4
												 new RasterMovie(new EffMaxDamage(), false), //5
												 new RasterMovie(new EffSpeed(), false) //6
												 ];
		public var free:Boolean = true;
		public var type:String = 'base';
		private var currMovie:RasterMovie = null
		private var currFrame:int;
		public function BaseEff() 
		{
			
		}
		public function init(parr:Sprite, xp:int=0, yp:int=0,index:int=0):void
		{
			if (index == 5)
			App.sound.playSound('EffMaxDamage', App.sound.onVoice, 1);
			else if (index == 6)
			App.sound.playSound('MaxSpeed', App.sound.onVoice, 1);
			
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