package artur.units 
{
	import artur.App;
	import artur.PrepareGr;
	import artur.RasterClip;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class BotGolem extends GolemDoll
	{
		public  var normScale:Number = 1;
		private var heads        :Array;
		private var bodys        :Array;
		private var hends1R    :Array;
		private var hends2R    :Array;
		private var hends1L    :Array;
		private var hends2L    :Array;
		private var legs1R       :Array;
		private var legs2R       :Array;
		private var legs1L       :Array;
		private var legs2L       :Array;
		public var type:String = 'BotGolem';
		public var free:Boolean = true;
		private var parts:Array ;
		private var parts_of_parts:Array;
		private var sh:Bitmap = RasterClip.getMovedBitmap(new mcShawdow());
		private static var sounds:Array = [{id:'fow2',frame:93},{id:'golemHurt',frame:160},{id:'golemAtack',frame:83}, { id:'bot1_fs1', frame:55 }, { id:'bot1_fs2', frame:76 },{id:'golemHurt',frame:105}];
		private var isOver:Boolean;
		 
		public function BotGolem() 
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.shawdow.addChild(sh);
			
			heads 	= RasterClip.getAnimationBitmaps(new itemHeadGolem());// PrepareGr.creatBms();
			bodys 	= RasterClip.getAnimationBitmaps(new itemBodyGolem());// PrepareGr.creatBms();
			hends1R = RasterClip.getAnimationBitmaps(new itemHand1RGolem());// PrepareGr.creatBms();
			hends2R = RasterClip.getAnimationBitmaps(new itemHand2RGolem());// PrepareGr.creatBms();
			hends1L = RasterClip.getAnimationBitmaps(new itemHand1LGolem());// PrepareGr.creatBms();
			hends2L = RasterClip.getAnimationBitmaps(new itemHand2LGolem());// PrepareGr.creatBms();
			legs1R 	= RasterClip.getAnimationBitmaps(new itemLeg1RGolem());// PrepareGr.creatBms();
			legs2R 	= RasterClip.getAnimationBitmaps(new itemLeg2RGolem());// PrepareGr.creatBms();
			legs1L 	= RasterClip.getAnimationBitmaps(new itemLeg1LGolem());// PrepareGr.creatBms();
			legs2L 	= RasterClip.getAnimationBitmaps(new itemLeg2LGolem());// PrepareGr.creatBms();
			
			parts =                [this._head, this._body, this._hend1R, this._hend2R,  this._hend1L , this._hend2L, this._leg1R, this._leg2R, this._leg1L, this._leg2L];
			parts_of_parts =  [heads       , bodys      , hends1R       , hends2R       ,  hends1L       , hends2L       ,  legs1R      , legs2R       , legs1L      , legs2L];
			
			this._head.addChild(heads[0]);
			this._body.addChild(bodys[0]);
		   
		    this._hend1R.addChild(hends1R[0]);
			this._hend2R.addChild(hends2R[0]);
			
			this._hend1L.addChild(hends1L[0]);
			this._hend2L.addChild(hends2L[0]);
			
			this._leg1R.addChild(legs1R[0]);
			this._leg2R.addChild(legs2R[0]);
			
			this._leg1L.addChild(legs1L[0]);
			this._leg2L.addChild(legs2L[0]);
			
		}
			public function out(e:MouseEvent=null):void 
		 {
			//isOver = false;
		 }
		 public function onWalk():void
		 {
			 //App.sound.playSound('bot1_init', App.sound.onVoice, 1);
		 }
		public function over(e:MouseEvent=null):void 
		{
			isOver = true;
			TweenLite.to(this, 0.25, { scaleX:1.3, scaleY:1.3} );
			App.btnOverFilter.color = 0xFFFFFF;
			this.filters = [App.btnOverFilter];
		}
		public function init(parr:DisplayObjectContainer=null,lvl:int=0):void
		{
			scaleX = normScale;
			scaleY = normScale;
			filters = [];
			free = false;
			this.gotoAndPlay('idle');
			if (parr) 
			{
				parr.addChild(this);
			}
		}
		public function update():void
		{
			if (!isOver && this.scaleX == 1.3)
			{
				TweenLite.to(this, 0.25, { scaleX:1, scaleY:1 } );
				this.filters = [];
			}
			for (var i:int = 0; i < sounds.length; i++) 
			{
				if (sounds[i].frame == currentFrame) 
				{
					App.sound.playSound(sounds[i].id, App.sound.onVoice, 1);
				}
			}
		}
		public function frees():void
		{
			free = true;
			gotoAndStop(1);
			if (parent) 
			{
				parent.removeChild(this);
			}
			this.removeEventListener(MouseEvent.MOUSE_OVER, over);
			this.removeEventListener(MouseEvent.MOUSE_OUT, out);
		}
		public function itemUpdate(obj:Object):void
		{
		     
		}
		
		
		
	}

}