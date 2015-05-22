package artur.units 
{
	import artur.App;
	import artur.PrepareGr;
	import com.greensock.TweenLite;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import report.Report;
	
	public class BotGolem extends GolemDoll
	{
		 private var heads        :Array ;
		 private var bodys        :Array ;
		
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
		 
		 private var sh:Sprite = PrepareGr.creatBms(new mcShawdow(), true)[0];
		 private static var sounds:Array = [  ];
		 private var isOver:Boolean;
		 
		public function BotGolem() 
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.shawdow.addChild(sh);
			heads = PrepareGr.creatBms(new itemHeadGolem());
			bodys = PrepareGr.creatBms(new itemBodyGolem());
			
			hends1R = PrepareGr.creatBms(new itemHand1RGolem());
			hends2R = PrepareGr.creatBms(new itemHand2RGolem());
			
			hends1L = PrepareGr.creatBms(new itemHand1LGolem());
			hends2L = PrepareGr.creatBms(new itemHand2LGolem());
			
			legs1R = PrepareGr.creatBms(new itemLeg1RGolem());
			legs2R = PrepareGr.creatBms(new itemLeg2RGolem());
			
			legs1L = PrepareGr.creatBms(new itemLeg1LGolem());
			legs2L = PrepareGr.creatBms(new itemLeg2LGolem());
			
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
		public function init(parr:DisplayObjectContainer=null):void
		{
			scaleX = 1;
			scaleY = 1;
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
				Report.addMassage("bot_golem removed");
			}
			this.removeEventListener(MouseEvent.MOUSE_OVER, over);
			this.removeEventListener(MouseEvent.MOUSE_OUT, out);
		}
		public function itemUpdate(obj:Object):void
		{
		     
		}
		
		
		
	}

}