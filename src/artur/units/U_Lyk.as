package artur.units 
{
	import artur.App;
	import artur.PrepareGr;
	import com.greensock.TweenLite;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author art
	 */
	public class U_Lyk extends LykDoll
	{
		 private var heads         :Array ;
		 private var bodys         :Array ;
		 private var bows          :Array;
		 private var appArmsR   :Array;
		 private var hends1R     :Array;
		 private var hends2R     :Array;
	//	 private var hends3R     :Array;
	//	 private var appArmsL   :Array;
		 private var hends1L     :Array;
		 private var hends2L     :Array;
	//	 private var hends3L     :Array;
		 private var legs1R       :Array;
		 private var legs2R       :Array;
		 private var legs3R       :Array;
		 private var legs1L       :Array;
		 private var legs2L       :Array;
		 private var legs3L       :Array;
		 private var arrows       :Array;
		 public var type:String = 'Lyk';
		 public var free:Boolean = true;
		 
		 private var isOver:Boolean = false;
		 private var parts:Array ;
		 private var parts_of_parts:Array;
		 public var vector:String = 'right';
		 private var sh:Sprite = PrepareGr.creatBms(new mcShawdow(), true)[0];
		 private static var sounds:Array = [{id:'bot1_fs1',frame:40},{id:'bot1_fs2',frame:50},{id:'bow1',frame:64},{ id:'pall_hurt', frame:69 },{id:'blade1',frame:66}];
		 
		public function U_Lyk() 
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.shawdow.addChild(sh);
			heads = PrepareGr.creatBms(new ItemHeadLyk());
			bodys = PrepareGr.creatBms(new ItemBodyLyk());
			bows  = PrepareGr.creatBms(new ItemGun1Lyk());
			
			appArmsR = PrepareGr.creatBms(new ItemUpArmLyk());
			hends1L  = PrepareGr.creatBms(new ItemHand1LLyk());
			
			hends1R  = PrepareGr.creatBms(new ItemHand1RLyk());
			hends2R  = PrepareGr.creatBms(new ItemHand2RLyk());
			 
			hends2L  = PrepareGr.creatBms(new ItemHand2LLyk());
			legs1R =  PrepareGr.creatBms(new ItemLeg1RLyk());
			legs2R =  PrepareGr.creatBms(new ItemLeg2RLyk());
			legs3R =  PrepareGr.creatBms(new ItemLeg3RLyk());
			legs1L =  PrepareGr.creatBms(new ItemLeg1LLyk());
			legs2L =  PrepareGr.creatBms(new ItemLeg2LLyk());
			legs3L =  PrepareGr.creatBms(new ItemLeg3LLyk());
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
		
			itemUpdate ( [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] );
			
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
		public function init(parr:DisplayObjectContainer=null):void
		{
			scaleX = 1;
			scaleY = 1;
			vector = 'right';
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
			 
		}
		public function itemUpdate(obj:Object):void
		{
			for (var i:int = 0; i < parts.length; i++) 
			{
				Sprite(parts[i]).removeChildAt(1);
				switch(true)
			    {
				    case (i == 0):
					   Sprite(parts[i]).addChild(this.parts_of_parts[i][int(obj[0])]);
					   break;
					case(i == 1):
						Sprite(parts[i]).addChild(this.parts_of_parts[i][int(obj[1])]);
					    break;
					case(i == 2):
					    Sprite(parts[i]).addChild(this.parts_of_parts[i][int(obj[5])]);
					    break;
					case(i == 3 || i == 4):
						 Sprite(parts[i]).addChild(this.parts_of_parts[i][int(obj[3])]);
					    break;
					case(i > 4 && i < 8):
						Sprite(parts[i]).addChild(this.parts_of_parts[i][int(obj[4])]);
					    break;
					case(i > 7 && i < 14):
						Sprite(parts[i]).addChild(this.parts_of_parts[i][int(obj[2])]);
					    break;
					case(i == 14):
					     Sprite(parts[14]).addChild(this.parts_of_parts[i][int(obj[6])]);
						 break;
			   }
			}
		}
		
	}

}