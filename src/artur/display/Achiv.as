package artur.display 
{
	import artur.PrepareGr;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Som911
	 */
	public class Achiv extends Sprite
	{
		private var frames:Array = PrepareGr.creatBms(new mcAchivs, false);
		private var index:int = 0;
		private var star1:Bitmap = PrepareGr.creatBms(new mcStarAchiv, false)[0];
		private var star2:Bitmap = PrepareGr.creatBms(new mcStarAchiv, false)[0];
		private var star3:Bitmap = PrepareGr.creatBms(new mcStarAchiv, false)[0];
		public function Achiv() 
		{
			addChild(frames[index]);
			this.addChild(star1);
			this.addChild(star2);
			this.addChild(star3);
			star1.width = 16.4; star1.height = 15.6;
			star2.width = 16.4; star2.height = 15.6;
			star3.width = 16.4; star3.height = 15.6;
			star1.x = 0.6; star1.y = 36;
			star2.x = 17.4; star2.y = 42.45;
			star3.x = 34.35; star3.y = 35.75;
		}
		public function init(index:int=0,xp:int=0,yp:int=0,st1:Boolean=false,st2:Boolean=false,st3:Boolean=false):void
		{
			removeChild(frames[this.index]);
			this.index = index;
			addChild(frames[index]);
			this.addChild(star1);
			this.addChild(star2);
			this.addChild(star3);
			star1.visible = st1;
			star2.visible = st2;
			star3.visible = st3;
			this.x = xp;
			this.y = yp;
		}
		
	}

}