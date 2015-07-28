package artur.display 
{
	import flash.display.Sprite;
	
	public class LockSpr extends Block
	{
		
		public function LockSpr() 
		{
			
		}
		
		public  function init(txt:String ="Loading"):void
		{
			this.txt.txt.text = txt
			Main.THIS.addChild(this);
			this.gotoAndPlay(1);
		}
		
		public function frees():void
		{
			if (parent) 
			{
				parent.removeChild(this);
			}
		}
		
	}

}