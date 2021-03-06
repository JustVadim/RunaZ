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
	/**
	 * ...
	 * @author Som911
	 */
	public class BotGhost2 extends Ghost2Doll
	{
		 public  var normScale:Number = 1.1;

		 private var bodys1       :Array;
		 private var bodys2       :Array;
		 private var hendsL       :Array;
		 private var hendsR       :Array;
		 private var heads         :Array;
		 private var centers       :Array;
		 private var blades       :Array;
		 public var type:String = 'BotGhost2';
		 public var free:Boolean = true;
		 
		 private var isOver:Boolean = false;
		 private var parts:Array ;
		 private var parts_of_parts:Array;
		 private var sh:Bitmap = RasterClip.getMovedBitmap(new mcShawdow());//PrepareGr.creatBms(new mcShawdow(), true)[0];
		 private static var sounds:Array = [{id:'gAtack', frame:55}, {id:'gHurt', frame:62}, {id:'blade2', frame:59}, {id:'gDie', frame:74}, {id:'blade1', frame:71}];
		 private static var normalScales:Array = [1, 1, 1.5, 1, 1, 1, 1, 1];
		 private var lvl:int=1;
		public function BotGhost2() 
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.shawdow.addChild(sh);
			bodys1 	= RasterClip.getAnimationBitmaps(new Item_body1G2());// PrepareGr.creatBms();
			bodys2 	= RasterClip.getAnimationBitmaps(new Item_body2G2());//PrepareGr.creatBms();
			hendsR 	= RasterClip.getAnimationBitmaps(new Item_handsG2());//PrepareGr.creatBms();
			hendsL 	= RasterClip.getAnimationBitmaps(new Item_handsG2());//PrepareGr.creatBms();
			heads 	= RasterClip.getAnimationBitmaps(new Item_headG2());//PrepareGr.creatBms();
			centers = RasterClip.getAnimationBitmaps(new Item_centerG2());//PrepareGr.creatBms();
			blades 	= RasterClip.getAnimationBitmaps(new Item_bladeG2());//PrepareGr.creatBms();
			
			parts =               [this.body1, this.body2, this.handL,this.handR,this._head,this.center, this.blade];
			parts_of_parts = [bodys1,bodys2, hendsL , hendsR,heads,centers,blades ];
			
			this.body1.addChild(bodys1[0]);
			this.body2.addChild(bodys2[0]);
			this.handL.addChild(hendsL[0]);
		    this.handR.addChild(hendsR[0]);
			this._head.addChild(heads[0]);
			this.center.addChild(centers[0]);
			this.blade.addChild(blades[0]);
		//	 itemUpdate([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
			 this.scaleX = 1.5;
			 this.scaleY = 1.5;
		}
		public function onWalk():void
		 {
			 //App.sound.playSound('bot1_init', App.sound.onVoice, 1);
		 }
		public function out(e:MouseEvent=null):void 
		 {
			isOver = false;
		 }
		public function over(e:MouseEvent=null):void 
		{
			isOver = true;
			TweenLite.to(this, 0.25, { scaleX:1.3, scaleY:1.3} );
			App.btnOverFilter.color = 0xFFFFFF;
			this.filters = [App.btnOverFilter];
		}
		public function init(parr:DisplayObjectContainer=null, lvl:int=1):void
		{
			this.lvl = lvl;
			normScale = normalScales[this.lvl - 1];
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
			if (this.parent) 
			{
				parent.removeChild(this);
			}
			
			 this.removeEventListener(MouseEvent.MOUSE_OVER, over);
		     this.removeEventListener(MouseEvent.MOUSE_OUT, out);
		}
		public function itemUpdate(obj:Object):void
		{
			for (var i:int = 0; i < parts.length; i++) 
			{
			   Sprite(parts[i]).removeChildAt(1);
			    Sprite(parts[i]).addChild(this.parts_of_parts[i][lvl-1]);
			  
			}
			
		}
	
		
	}

}