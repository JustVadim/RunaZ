package artur.win 
{
	import artur.App;
	import artur.display.BaseButton;
	import artur.display.MyBitMap;
	import com.greensock.easing.Circ;
	import com.greensock.easing.Cubic;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Utils.Functions;
	/**
	 * ...
	 * @author Som911
	 */
	public class WinFortuna extends Sprite
	{
		public var bin:Boolean = false;
		private var circle:Sprite = new Sprite();
		private var currStep:int = 0;
		private var maxStep:int = 120;
		private var maxDist:int;
		private var arr:Array = [];
		private var arrow:mcFortuna = new mcFortuna();
		private var bgCircle:mcBgFortuna = new mcBgFortuna();
		private var bg:Bitmap;
		private var btnClose:BaseButton;
		private var btnDonate:BaseButton;
		private var btnFree:BaseButton;
		public function WinFortuna() 
		{
			//circle.addChild();
			bg = new MyBitMap(App.prepare.cach[62]);
			btnClose = new BaseButton(63);
			btnFree = new BaseButton(64);
			btnDonate = new BaseButton(65);
			btnClose.x = 79;
			btnClose.y = 30;
			btnFree.x = 658.65;
			btnFree.y = 358.6;
			btnDonate.x = 682.9;
			btnDonate.y = 310.1;
			this.addChild(bg);
			this.addChild(btnClose);
			this.addChild(btnFree);
			this.addChild(btnDonate);
			this.addChild(bgCircle);
		//	bgCircle.rotation = 90;
		     var arr:Array = 
			 [
			 {frame:'none' },
			 {frame:'gold', num:5 },
			 {frame:'none' },
			 {frame:'energy', num:99 },
			  {frame:'none' },
			 {frame:'silver'   , num:50 },
			 
			  {frame:'none' },
			 {frame:'gold', num:3 },
			 {frame:'none' },
			 {frame:'energy', num:50 },
			  {frame:'none' },
			 {frame:'silver'   , num:25 },
			 
			  {frame:'none' },
			 {frame:'gold', num:1 },
			 {frame:'none' },
			 {frame:'energy', num:10 },
			  {frame:'none' },
			 {frame:'silver'   ,num:10 }
			 ]
			 var f:GlowFilter = new GlowFilter(0x000000, 1, 3, 3, 2);
			for (var i:int = 0; i < arr.length; i++) 
			{
				var slot:mcSlotRullet = new mcSlotRullet();
				circle.addChildAt(slot, 0);
				slot.rotation = i * 20;
				slot.gotoAndStop(arr[i].frame)
				
				
					
				if (slot.currentLabel != 'none')
				{
					var txt:TextField =  Functions.getTitledTextfield( 148, -26.9, 51.5, 27, new Art().fontName, 24, 0xFFFFFF, TextFormatAlign.CENTER, "000/000", 1, Kerning.AUTO, 0, false, 2);
				    txt.text = arr[i].num;
				    txt.rotation = 90;
				    slot.addChild(txt);
					txt.filters = [f];
				}
			}
			
		
			bgCircle.x = 400;
			bgCircle.y = 210;
			bgCircle.addChild(circle);
			bgCircle.addChild(arrow);
			bgCircle.rotation = - 90;
		}
		public function init(rot:int = 0 ):void
		{
			maxDist = 360;
			var step:int = 0;
			var p:Number = 1.2
			for (var i:int = 0; i < maxDist; i++) 
			{
				step += maxDist / maxStep;
				step += step*p;
				p -= 0.01;
				arr[i] = step; 
			}
			App.spr.addChild(this);
			bin = true;
			currStep = 0;
			TweenLite.to(this.circle, 5, { rotation :- (rot*20+360), ease: Cubic.easeOut });
		}
		public function update():void
		{
		
		}
		public function frees():void
		{
			App.spr.removeChild(this);
			bin = false;
		}
		
	}

}