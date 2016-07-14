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
	import report.Report;
	
	public class BotMag extends MagDoll
	{
		public  var normScale:Number = 1;
		private var heads			:Array;
		private var bodys         	:Array;
		private var sikirs          :Array;
		private var appArmsR   		:Array;
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
		private var sikirs2       	:Array;
		public var type:String = 'BotMag';
		public var free:Boolean = true;
		private var isOver:Boolean = false;
		private var parts:Array ;
		private var parts_of_parts:Array;
		private var sh:Bitmap = RasterClip.getMovedBitmap(new mcShawdow()); //PrepareGr.creatBms(new mcShawdow(),true)[0];
		private static var sounds:Array = [ {id:'fow1', frame:55},{ id:'bot1_fs1', frame:40 }, { id:'bot1_fs2', frame:50 },{id:'shok',frame:59},{id:'magHurt',frame:72},{id:'blade1',frame:68},{id:'magDie',frame:75}];
		//public static var andAtackFrame:int = 72;
		
		public function BotMag() 
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.shawdow.addChild(sh)
			var arr:Array = [U_Lyk.f];
			heads 		= RasterClip.getAnimationBitmaps(new ItemHeadMagBot(), arr);// PrepareGr.creatBms(, false, U_Lyk.f);
			bodys 		= RasterClip.getAnimationBitmaps(new ItemBodyMagBot(), arr);// PrepareGr.creatBms(,false,U_Lyk.f);
			sikirs 		= RasterClip.getAnimationBitmaps(new ItemGun1MagBot(), arr);// PrepareGr.creatBms(,false,U_Lyk.f);
			appArmsR 	= RasterClip.getAnimationBitmaps(new ItemUpArmMagBot(), arr);// PrepareGr.creatBms(,false,U_Lyk.f);
			hends1R  	= RasterClip.getAnimationBitmaps(new ItemHand1RMagBot(), arr);// PrepareGr.creatBms(,false,U_Lyk.f);
			hends2R  	= RasterClip.getAnimationBitmaps(new ItemHand2RMagBot(), arr);// PrepareGr.creatBms(,false,U_Lyk.f);
			hends1L  	= RasterClip.getAnimationBitmaps(new ItemHand1LMagBot(), arr);// PrepareGr.creatBms(,false,U_Lyk.f);
			hends2L  	= RasterClip.getAnimationBitmaps(new ItemHand2LMagBot(), arr);// PrepareGr.creatBms(,false,U_Lyk.f);
			legs1R 		= RasterClip.getAnimationBitmaps(new ItemLeg1RMagBot(), arr);// PrepareGr.creatBms(,false,U_Lyk.f);
			legs2R 		= RasterClip.getAnimationBitmaps(new ItemLeg2RMagBot(), arr);//  PrepareGr.creatBms(,false,U_Lyk.f);
			legs3R 		= RasterClip.getAnimationBitmaps(new ItemLeg3RMagBot(), arr);//  PrepareGr.creatBms(,false,U_Lyk.f);
			legs1L 		= RasterClip.getAnimationBitmaps(new ItemLeg1LMagBot(), arr);//  PrepareGr.creatBms(,false,U_Lyk.f);
			legs2L 		= RasterClip.getAnimationBitmaps(new ItemLeg2LMagBot(), arr);//  PrepareGr.creatBms(,false,U_Lyk.f);
			legs3L 		= RasterClip.getAnimationBitmaps(new ItemLeg3LMagBot(), arr);//  PrepareGr.creatBms(,false,U_Lyk.f);
			sikirs2 	= RasterClip.getAnimationBitmaps(new ItemPlaschMagBot(), arr);//  PrepareGr.creatBms(,false,U_Lyk.f);
			parts = [this._head, this._body, this._sikira, this._appArmR, this._appArmL, this._hend1R, this._hend2R, this._hend2L,  this._leg1R, this._leg2R, this._leg3R, this._leg1L, this._leg2L, this._leg3L,_sikira2];
			parts_of_parts = [heads, bodys, sikirs, appArmsR, hends1L, hends1R, hends2R,  hends2L, legs1R, legs2R, legs3R, legs1L, legs2L, legs3L, sikirs2];
			
			
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
		
		public function init(parr:DisplayObjectContainer=null, lvl:int=0):void {
			this.free = false;
			this.scaleX = normScale;
			this.scaleY = normScale;
			this.filters = [];
			this.gotoAndPlay('idle');
			if (parr) {
				parr.addChild(this);
			}
		}
		
		public function update():void {
			if (!isOver && this.scaleX == 1.3) {
				TweenLite.to(this, 0.25, { scaleX:1, scaleY:1 } );
				this.filters = [];
			} 
			for (var i:int = 0; i < sounds.length; i++) {
				if (sounds[i].frame == currentFrame) {
					App.sound.playSound(sounds[i].id, App.sound.onVoice, 1);
				}
			}
		}
		public function frees():void {
			this.free = true;
			this.gotoAndStop(1);
			if (this.parent) {
				this.parent.removeChild(this);
			}
			for (var i:int = 0; i < parts.length; i++) {
				if (Sprite(parts[i]).numChildren > 1) {
					var item:B_MagItemsCash = B_MagItemsCash(Sprite(parts[i]).getChildAt(1));
					item.frees();
				}
			}
			
		}
		public function itemUpdate(obj:Object):void {
			for (var i:int = 0; i < parts.length; i++) {
				switch(true) {
				    case (i == 0):
						this.setItem(i, int(obj[0]));
						break;
					case(i == 1):
						this.setItem(i, int(obj[1]))
					    break;
					case(i == 2):
						this.setItem(i, int(obj[5]));
					    break;
					case(i == 3 || i == 4):
						this.setItem(i, int(obj[3]));
					    break;
					case(i > 4 && i < 8):
						this.setItem(i, int(obj[4]));
					    break;
					case(i > 7 && i < 14):
						this.setItem(i, int(obj[2]));
					    break;
					case(i == 14):
						this.setItem(i, int(obj[6]));
						break;
			   }
			}
		}
		
		private function setItem(type:int, frame:int):void {
			if (Sprite(parts[type]).numChildren > 1) {
				var item:B_MagItemsCash = B_MagItemsCash(Sprite(parts[type]).getChildAt(1));
				if(item.getId != frame) {
					item.frees();
					Sprite(parts[type]).addChild(B_MagItemsCash.getItem(type, frame));
				}
				return;
			}
		   Sprite(parts[type]).addChild(B_MagItemsCash.getItem(type, frame));
		}
		
	}

}