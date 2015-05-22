package artur.units 
{
	import artur.App;
	import artur.PrepareGr;
	import artur.win.WinBattle;
	import com.greensock.easing.Back;
	import com.greensock.events.LoaderEvent;
	import com.greensock.TweenLite;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import report.Report;
	
	
	public class U_Warwar extends BarbDoll
	{
		
		 private var heads       :Array ;
		 private var bodys       :Array ;
		 private var sikirs         :Array;
		 private var appArmsR :Array;
		 private var hends1R    :Array;
		 private var hends2R    :Array;
		 private var hends3R    :Array;
		 private var appArmsL  :Array;
		 private var hends1L    :Array;
		 private var hends2L    :Array;
		 private var hends3L    :Array;
		 private var legs1R       :Array;
		 private var legs2R       :Array;
		 private var legs3R       :Array;
		 private var legs1L       :Array;
		 private var legs2L       :Array;
		 private var legs3L       :Array;
		 public var type:String = 'Barbarian';
		 public var free:Boolean = true;
		 
		 public var currHead:String      = 'simple';
		 public var currBody:String      = 'simple';
		 public var currSikir:String       = 'simple';
		 public var currAppArm:String  = 'simple';
		 public var currBoot:String       = 'simple';
		 public var currHend:String      = 'simple';
		 public var currHend2:String    = 'simple';
		 public var currHend3:String    = 'simple';
		 
		 //private var parts:Array 
		 private var isOver:Boolean = false;
		 private var parts:Array ;
		 private var parts_of_parts:Array;
	     private var sh:Sprite = PrepareGr.creatBms(new mcShawdow(),true)[0];
		 private static var sounds:Array = [{id:'war_hurt',frame:85},{id:'blade2',frame:82}, {id:'fow2',frame:67}, { id:'bot1_fs1', frame:47 }, { id:'bot1_fs2', frame:56 } ];
		 public static var andAtackFrame:int = 72;
		 public var buffs:Array = PrepareGr.creatBms(new mcBaff, true);
		 
		 
		public function U_Warwar() 
		{
		   this.mouseEnabled = false;
			this.mouseChildren = false;
			heads = PrepareGr.creatBms(new itemHead());
			bodys = PrepareGr.creatBms(new itemBody());
			sikirs = PrepareGr.creatBms(new itemSikir());
			appArmsR = PrepareGr.creatBms(new itemAppArm());
			hends1R  = PrepareGr.creatBms(new itemHend1R());
			hends2R  = PrepareGr.creatBms(new itemHend2R());
			hends3R  = PrepareGr.creatBms(new itemHend3R());
			appArmsL = PrepareGr.creatBms(new itemAppArm2());
			hends1L  = PrepareGr.creatBms(new itemHend1L());
			hends2L  = PrepareGr.creatBms(new itemHend2L());
			hends3L  = PrepareGr.creatBms(new itemHend3L());
			legs1R =  PrepareGr.creatBms(new itemLeg1R());
			legs2R =  PrepareGr.creatBms(new itemLeg2R());
			legs3R =  PrepareGr.creatBms(new itemLeg3R());
			legs1L =  PrepareGr.creatBms(new itemLeg1L());
			legs2L =  PrepareGr.creatBms(new itemLeg2L());
			legs3L =  PrepareGr.creatBms(new itemLeg3L());
			parts = [this._head, this._body, this._sikira, this._appArmR, this._hend1R, this._hend2R, this._hend3R, this._appArmL, this._hend1L, this._hend2L, this._hend3L, this._leg1R, this._leg2R, this._leg3R, this._leg1L, this._leg2L, this._leg3L];
			parts_of_parts = [heads, bodys, sikirs, appArmsR, hends1R, hends2R, hends3R, appArmsL, hends1L, hends2L, hends3L, legs1R, legs2R, legs3R, legs1L, legs2L, legs3L];
			this.shawdow.addChild(sh)
			this._head.addChild(heads[0]);
			this._body.addChild(bodys[0]);
		    this._sikira.addChild(sikirs[0]);
			this._appArmR.addChild(appArmsR[0]);
			this._hend1R.addChild(hends1R[0]);
			this._hend2R.addChild(hends2R[0]);
			this._hend3R.addChild(hends3R[0]);//
			this._appArmL.addChild(appArmsL[0]);
			this._hend1L.addChild(hends1L[0]);
			this._hend2L.addChild(hends2L[0]);
			this._hend3L.addChild(hends3L[0]);
			this._leg1R.addChild(legs1R[0]);
			this._leg2R.addChild(legs2R[0]);
			this._leg3R.addChild(legs3R[0]);
			this._leg1L.addChild(legs1L[0]);
			this._leg2L.addChild(legs2L[0]);
			this._leg3L.addChild(legs3L[0]);
			itemUpdate([0,0,0,0,0,0,0,0,0,0,0,0,0,0]);
		}
		
		public function showBuff(num:int):void
		{
			_
			switch(num)
			{
				
			}
		}
		public function hideBuff():void
		{
			
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
				   case i == 0:
					   Sprite(parts[i]).addChild(this.parts_of_parts[i][int(obj[0])]);
					   break;
					case i == 1:
						Sprite(parts[i]).addChild(this.parts_of_parts[i][int(obj[1])]);
						break;
					case i == 2:
						Sprite(parts[i]).addChild(this.parts_of_parts[i][int(obj[5])]);
						break;
					case (i == 3 || i == 7):
						Sprite(parts[i]).addChild(this.parts_of_parts[i][int(obj[3])]);
						break;
					case (i == 14 || i == 4 || i == 11 || i == 8):
						Sprite(parts[i]).addChild(this.parts_of_parts[i][0]);
						break;
					case (i == 10 || i == 9 || i == 6 || i == 5):
						Sprite(parts[i]).addChild(this.parts_of_parts[i][int(obj[4])]);
						break;
					case(i == 12 || i == 13 || i == 15 || i == 16):
						Sprite(parts[i]).addChild(this.parts_of_parts[i][int(obj[2])]);
						break;
			   }
			}
		}
	}

}