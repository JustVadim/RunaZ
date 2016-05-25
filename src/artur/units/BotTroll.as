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
	
	public class BotTroll extends TrollDoll {
		public  var normScale:Number = 1;
		private var heads:Array;
		private var bodys:Array;
		private var hends1R    :Array;
		private var hends2R    :Array;
		private var hends1L    :Array;
		private var hends2L    :Array;
		private var legsL       :Array;
		private var legsR       :Array; 
		public var type:String = 'BotTroll';
		public var free:Boolean = true;
		private var parts:Array ;
		private var parts_of_parts:Array; 
		private var sh:Bitmap = RasterClip.getMovedBitmap(new mcShawdow());
		private static var sounds:Array = [{id:'fow2',frame:83},{id:'golemAtack',frame:88}, { id:'bot1_fs1', frame:45 }, { id:'bot1_fs2', frame:60 },{id:'golemHurt',frame:151}];
		private var isOver:Boolean;
		private var lvl:int = 0;
		private static var normalScales:Array = [0.8, 1, 1, 1, 1, 1, 1, 1]; 
		
		public function BotTroll() {
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.shawdow.addChild(sh);
			
			heads 	= RasterClip.getAnimationBitmaps(new itemHeadTroll());// PrepareGr.creatBms();
			bodys 	= RasterClip.getAnimationBitmaps(new itemBodyTroll());//PrepareGr.creatBms();
			hends1R = RasterClip.getAnimationBitmaps(new itemHand1Troll());//PrepareGr.creatBms();
			hends2R = RasterClip.getAnimationBitmaps(new itemHand2Troll());//PrepareGr.creatBms();
			hends1L = RasterClip.getAnimationBitmaps(new itemHand1Troll());//PrepareGr.creatBms();
			hends2L = RasterClip.getAnimationBitmaps(new itemHand2Troll());//PrepareGr.creatBms();
			legsL 	= RasterClip.getAnimationBitmaps(new itemLegTroll());//PrepareGr.creatBms();
			legsR 	= RasterClip.getAnimationBitmaps(new itemLegTroll());//PrepareGr.creatBms();
			
			
			parts =                [this._head, this._body, this._hand1R, this._hand2R,  this._hand1L , this._hand2L, this._legR , this._legL];
			parts_of_parts =  [heads       , bodys      , hends1R       , hends2R       ,  hends1L       ,  hends2L       ,  legsR      , legsL];
			this._head.addChild(heads[0]);
			this._body.addChild(bodys[0]);
		   
		    this._hand1R.addChild(hends1R[0]);
			this._hand2R.addChild(hends2R[0]);
			
			this._hand1L.addChild( hends1L[0]);
			this._hand2L.addChild( hends2L[0]);
			
			this._legR.addChild(legsR[0]);
			this._legL.addChild(legsL[0]);
			for (var i:int = 0; i < this.parts_of_parts.length; i++) 
			{
				parts_of_parts[i].x += 20;
			}
			
		}
		
		public function out(e:MouseEvent=null):void {
			//isOver = false;
		}
		
		public function onWalk():void
		{
			//App.sound.playSound('bot1_init', App.sound.onVoice, 1);
		}
		
		public function over(e:MouseEvent=null):void {
			isOver = true;
			TweenLite.to(this, 0.25, { scaleX:1.3, scaleY:1.3} );
			App.btnOverFilter.color = 0xFFFFFF;
			this.filters = [App.btnOverFilter];
		}
		
		public function init(parr:DisplayObjectContainer=null,lvl:int=0):void
		{
			this.lvl = lvl;
			normScale = normalScales[lvl-1]
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