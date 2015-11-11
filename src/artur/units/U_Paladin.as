package artur.units 
{
	import artur.App;
	import artur.PrepareGr;
	import com.greensock.TweenLite;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class U_Paladin extends PallDoll
	{
		public  var normScale:Number = 1;
		private var heads         :Array ;
		private var bodys         :Array ;
		private var sikirs          :Array;
		private var appArmsR   :Array;
		private var hends1R     :Array;
		private var hends2R     :Array;
		private var hends1L     :Array;
		private var hends2L     :Array;
		private var legs1R       :Array;
		private var legs2R       :Array;
		private var legs3R       :Array;
		private var legs1L       :Array;
		private var legs2L       :Array;
		private var legs3L       :Array;
		private var sikirs2       :Array;
		public var type:String = 'Paladin';
		public var free:Boolean = true;
		private var isOver:Boolean = false;
		private var parts:Array ;
		private var parts_of_parts:Array;
		private var sh:Sprite = PrepareGr.creatBms(new mcShawdow(),true)[0];
		private static var sounds:Array = [ {id:'fow1', frame:55},{ id:'bot1_fs1', frame:40 }, { id:'bot1_fs2', frame:50 }, { id:'pall_hurt', frame:75 },{id:'blade1',frame:78},{id:'pall_death',frame:81}];
		public static var andAtackFrame:int = 72;
		 
		public function U_Paladin() 
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.shawdow.addChild(sh)
			heads = PrepareGr.creatBms(new ItemHeadPall());
			bodys = PrepareGr.creatBms(new ItemBodyPall());
			sikirs = PrepareGr.creatBms(new ItemGun1Pall());
			appArmsR = PrepareGr.creatBms(new ItemUpArmPall());
			hends1R  = PrepareGr.creatBms(new ItemHand1RPall());
			hends2R  = PrepareGr.creatBms(new ItemHand2RPall());
			hends1L  = PrepareGr.creatBms(new ItemHand1LPall());
			hends2L  = PrepareGr.creatBms(new ItemHand2LPall());
			legs1R =  PrepareGr.creatBms(new ItemLeg1RPall());
			legs2R =  PrepareGr.creatBms(new ItemLeg2RPall());
			legs3R =  PrepareGr.creatBms(new ItemLeg3RPall());
			legs1L =  PrepareGr.creatBms(new ItemLeg1LPall());
			legs2L =  PrepareGr.creatBms(new ItemLeg2LPall());
			legs3L =  PrepareGr.creatBms(new ItemLeg3LPall());
			sikirs2 =  PrepareGr.creatBms(new ItemShildPall());
			parts = [this._head, this._body, this._sikira, this._appArmR, this._appArmL, this._hend1R, this._hend2R, this._hend2L,  this._leg1R, this._leg2R, this._leg3R, this._leg1L, this._leg2L, this._leg3L,_sikira2];
			parts_of_parts = [heads, bodys, sikirs, appArmsR, hends1L, hends1R, hends2R,  hends2L, legs1R, legs2R, legs3R, legs1L, legs2L, legs3L,sikirs2];
			//parts = [heads,bodys,sikirs,appArmsR,hends1R,hends2R,hends3R,appArmsL,hends1L,hends2L,hends3L];
			this._head.addChild(heads[0]);
			this._body.addChild(bodys[0]);
		    this._sikira.addChild(sikirs[0]);
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
			this._sikira2.addChild(sikirs2[0]);
			itemUpdate ( [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] );
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
		
		public function init(parr:DisplayObjectContainer = null,lvl:int=0):void
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