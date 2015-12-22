package artur.display 
{
	import artur.App;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import report.Report;
	
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
		private var cont:Sprite = new Sprite();
		
		public function BaseButton(index:int,scaleClick:Number= 1.05,glowPawer:Number=5,soundCLick:String='click1',soundOver:String ='over1',color:uint = 0xFFFFFF ) 
		{
			this.glowPawer = glowPawer;
			this.scaleClick = scaleClick;
			this.soundCLick = soundCLick;
			this.soundOver = soundOver;
			this.color = color;
			this.index = index;
			this.mouseChildren = false;
			bm = new MyBitMap(App.prepare.cach[index]);
			bm.width += 1;
			bm.height += 1;
			bm.x = - bm.width / 2;
			bm.y = -bm.height / 2;
			this.cont.addChild(bm);
			this.addEventListener(MouseEvent.ROLL_OVER, over);
			this.addEventListener(MouseEvent.ROLL_OUT, out);
			this.addEventListener(MouseEvent.MOUSE_DOWN, down);
			this.addEventListener(MouseEvent.MOUSE_UP, up);
			this.buttonMode = true;
			this.addChild(this.cont);
		}
		
		private function up(e:MouseEvent):void 
		{
			if (this.active) {
				this.cont.scaleX = this.cont.scaleY = 1;
			}
			
		}
		
		public function down(e:MouseEvent=null):void {
			if (this.active) {
			   this.cont.scaleX = this.cont.scaleY = scaleClick;
			   App.sound.playSound(soundCLick, App.sound.onVoice, 1);
			}
		}
		
		
		
		public function out(e:MouseEvent = null):void {
			if (this.active) {
				this.cont.scaleX = this.cont.scaleY = 1;
				this.filters = [];
			}
		}
		
		public function over(e:MouseEvent=null):void {
			if (active) {
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