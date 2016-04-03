package artur.display 
{
	import artur.App;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Som911
	 */
	public class Swaper extends Sprite
	{
		private var btn1:BaseButton
		private var btn2:BaseButton
		private var btnRemove:BaseButton;
		private var yps:Array = [11,107.25,202.4,297.45];
		public function Swaper() 
		{
			btn1 = new BaseButton(56);
			btn2 = new BaseButton(56);
			btnRemove = new BaseButton(31);
			
			btn2.scaleY = -1;
			this.x = 54.15;
			btn1.x = 11.6;
			btn2.x = 11.6;
			btn1.y = 7.6
			btn2.y = 105;
			btnRemove.x = -38.75;
			btnRemove.y = 52.15;
			this.addChild(btnRemove);
			this.addChild(btn1);
			this.addChild(btn2);
		}
		public function init( indexSlot:int=0):void
		{
			this.y = yps[indexSlot];
			App.spr.addChild(this);
		}
	
		
	}

}