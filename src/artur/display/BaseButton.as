package artur.display 
{
	import artur.App;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class BaseButton extends Sprite
	{
		private var bm:MyBitMap
		public var index:int;
		private var active:Boolean = true;
		private var color:uint;
		private var soundCLick:String;
		private var soundOver:String;
		private var scaleClick:Number;
		private var glowPawer:Number = 1;
		
		public function BaseButton(index:int,scaleClick:Number=0.9,glowPawer:Number=5,soundCLick:String='click1',soundOver:String ='over1',color:uint = 0xFFFFFF ) 
		{
			this.glowPawer = glowPawer;
			this.scaleClick = scaleClick;
			this.soundCLick = soundCLick;
			this.soundOver = soundOver;
			this.color = color;
			this.index = index;
			bm = new MyBitMap(App.prepare.cach[index]);
			bm.x = - bm.width / 2;
			bm.y = -bm.height / 2;
			this.addChild(bm);
			this.addEventListener(MouseEvent.MOUSE_OVER, over);
			this.addEventListener(MouseEvent.MOUSE_OUT, out);
			this.addEventListener(MouseEvent.MOUSE_DOWN, down);
			App.btns.push(this);
			this.buttonMode = true;
		}
		
		public function down(e:MouseEvent=null):void 
		{
			if (active)
			{
			   this.scaleX = scaleClick;
			   this.scaleY = scaleClick;
			   App.sound.playSound(soundCLick, App.sound.onVoice, 1);
			}
		}
		
		public function out(e:MouseEvent=null):void 
		{
			this.filters = [];
			
		}
		
		public function over(e:MouseEvent=null):void 
		{
			if (active)
			{
				App.btnOverFilter.color = color;
				App.btnOverFilter.strength = glowPawer;
				this.filters = [App.btnOverFilter];
				App.sound.playSound(soundOver, App.sound.onVoice, 1);
			}
		}
		
		public function swap(index:int):void
		{
			//bm.bitmapData = BmdFrames(Main.prepare.cach[10]).frames[index];
			//bm.x = - bm.width / 2;
			//bm.y = -bm.height / 2;
		}
		
		public function setActive(val:Boolean ):void
		{
			active = val;
			this.buttonMode = val;
			this.mouseChildren = val;
			this.mouseEnabled = val;
			this.scaleX = 1;
			this.scaleY = 1;
			this.filters = [];
		}
	}
}