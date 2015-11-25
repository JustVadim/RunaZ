package artur.display 
{
	import artur.App;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Som911
	 */
	public class SprSelectLevel extends mcSelect
	{
		
		private var btn:BaseButton = new BaseButton(15); // close win
		
		private var b1:BaseButton = new BaseButton(35); // btn noob
		private var b2:BaseButton = new BaseButton(36); // btn voin
		private var b3:BaseButton = new BaseButton(37); // btn strateg
		private var b4:BaseButton = new BaseButton(38); // btn king
		//  зелени галочкы s0 s1 s2 s3
		public function SprSelectLevel() 
		{
			btn.x = 405;
			btn.y = 302;
			btn.name = 'close'
			b1.x  = 361.95
			b2.x  = 361.95
			b3.x  = 361.95
			b4.x  = 361.95
			
			b1.y = 159.25
			b2.y = 189.75
			b3.y = 220.25
			b4.y = 250.75
			this.mouseChildren = false;
			this.mouseEnabled = false;
			btn.addEventListener(MouseEvent.CLICK, onBtn);
			b1.addEventListener(MouseEvent.CLICK, onBtn);
			b2.addEventListener(MouseEvent.CLICK, onBtn);
			b3.addEventListener(MouseEvent.CLICK, onBtn);
			b4.addEventListener(MouseEvent.CLICK, onBtn);
		}
		
		private function onBtn(e:MouseEvent):void 
		{
			switch(e.currentTarget.name)
			{
				case 'close':
					frees();
					break;
			}
		}
		public function init():void
		{
			App.spr.addChild(this);
			App.spr.addChild(btn);
			App.spr.addChild(b1);
			App.spr.addChild(b2);
			App.spr.addChild(b3);
			App.spr.addChild(b4);
		}
		public function frees():void
		{
			App.spr.removeChild(this);
			App.spr.removeChild(btn);
			App.spr.removeChild(b1);
			App.spr.removeChild(b2);
			App.spr.removeChild(b3);
			App.spr.removeChild(b4);
		}
		
	}

}