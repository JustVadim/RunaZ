package artur.units 
{
	import artur.App;
	import artur.PrepareGr;
	import com.greensock.TweenLite;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class U_LykBot extends  LykDoll
	{
		public  var normScale:Number = 1;
		 private var heads         	:Array ;
		 private var bodys         	:Array ;
		 private var bows          	:Array;
		 private var appArmsR   	:Array;
		 private var hends1R     	:Array;
		 private var hends2R     	:Array;
		 private var hends1L     	:Array;
		 private var hends2L     	:Array;
		 private var legs1R       	:Array;
		 private var legs2R       	:Array;
		 private var legs3R       	:Array;
		 private var legs1L       	:Array;
		 private var legs2L       	:Array;
		 private var legs3L       	:Array;
		 private var arrows       	:Array;
		 public var type:String = 	'LykBot';
		 public var free:Boolean = 	true;
		 
		 private var isOver:Boolean = false;
		 private var parts:Array ;
		 private var parts_of_parts:Array;
		 public var vector:String = 'right';
		 private var sh:Sprite = PrepareGr.creatBms(new mcShawdow(), true)[0];
		 private static var sounds:Array = [{id:'bot1_fs1',frame:40},{id:'bot1_fs2',frame:50},{id:'bow1',frame:64},{ id:'bot1_hurt', frame:66 },{id:'blade1',frame:67},{id:'bot1_die',frame:77},{id:'blade1',frame:74}];
		  private static var normalScales:Array = [1, 1.5, 1, 1, 1, 1, 1, 1];
		  private var lvl:int=1;
		public function U_LykBot() 
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.shawdow.addChild(sh);
			heads = PrepareGr.creatBms(new ItemHeadBot3());
			bodys = PrepareGr.creatBms(new ItemBodyBot3());
			bows  = PrepareGr.creatBms(new ItemGun1Bot3());
			
			appArmsR = PrepareGr.creatBms(new ItemUpArmBot3());
			hends1L  = PrepareGr.creatBms(new ItemHand1LBot3());
			
			hends1R  = PrepareGr.creatBms(new ItemHand1RBot3());
			hends2R  = PrepareGr.creatBms(new ItemHand2RBot3());
			 
			hends2L  = PrepareGr.creatBms(new ItemHand2LBot3());
			legs1R =  PrepareGr.creatBms(new ItemLeg1RBot3());
			legs2R =  PrepareGr.creatBms(new ItemLeg2RBot3());
			legs3R =  PrepareGr.creatBms(new ItemLeg3RBot3());
			legs1L =  PrepareGr.creatBms(new ItemLeg1LBot3());
			legs2L =  PrepareGr.creatBms(new ItemLeg2LBot3());
			legs3L =  PrepareGr.creatBms(new ItemLeg3LBot3());
			arrows =  PrepareGr.creatBms(new ItemArrows());
			parts = 				[this._head, this._body, this._bow, this._appArmR, this._appArmL, this._hend1R, this._hend2R, this._hend2L,  this._leg1R, this._leg2R, this._leg3R, this._leg1L, this._leg2L, this._leg3L, this._arrow];
			parts_of_parts = [	heads,         bodys,     bows,         appArmsR,         hends1L,         hends1R,        hends2R,         hends2L,        legs1R,       legs2R,         legs3R,       legs1L,        legs2L,       legs3L,       arrows];
			
			this._head.addChild(heads[0]);
			this._body.addChild(bodys[0]);
		    this._bow.addChild(bows[0]);
			
			this._appArmR.addChild(appArmsR[0]);
			this._appArmL.addChild(hends1L[0]);
			
			this._hend1R.addChild(hends1R[0]);
			this._hend2R.addChild(hends2R[0]);
			this._hend2L.addChild(hends2L[0]);
			
			
			
			this._leg1R.addChild(legs1R[0]);
			this._leg2R.addChild(legs2R[0]);
			this._leg3R.addChild(legs3R[0]);
			this._leg1L.addChild(legs1L[0]);
			this._leg2L.addChild(legs2L[0]);
			this._leg3L.addChild(legs3L[0]);
			this._arrow.addChild(arrows[0]);
		
			itemUpdate ( 0 );
			
		}
		 public function onWalk():void
		 {
			// App.sound.playSound('bot1_init', App.sound.onVoice, 1);
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
		public function init(parr:DisplayObjectContainer=null,lvl:int=0):void
		{
			this.lvl = lvl;
			normScale = normalScales[lvl - 1];
			scaleX = normScale;
			scaleY = normScale;
			vector = 'right';
			filters = [];
			free = false;
			this.gotoAndPlay('idle');
			if (parent) 
			{
				parent.addChild(this);
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
			 
		}
	    public function itemUpdate(ix:int=0):void
		{
			
			for (var i:int = 0; i < parts.length; i++) 
			{
			   Sprite(parts[i]).removeChildAt(1);
			   Sprite(parts[i]).addChild(this.parts_of_parts[i][lvl-1]);
			}

			
		}
		
	}

}