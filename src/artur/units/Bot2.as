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
	
	public class Bot2 extends PallDoll
	{
		public  var normScale:Number = 1;
		private var heads         	:Array ;
		private var bodys         	:Array ;
		private var sikirs        	:Array;
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
		private var parts			:Array;
		private var parts_of_parts	:Array;
		public var type:String = 'Bot2';
		public var free:Boolean = true;
		private var isOver:Boolean = false;
		private var sh:Bitmap = RasterClip.getMovedBitmap(new mcShawdow());//PrepareGr.creatBms(new mcShawdow(),true)[0];
		private static var sounds:Array = [ {id:'fow1', frame:55},{ id:'bot1_fs1', frame:40 }, { id:'bot1_fs2', frame:50 }, { id:'pall_hurt', frame:75 },{id:'blade1',frame:78},{id:'pall_death',frame:81}];
		private var lvl:int;
		private static var normalScales:Array = [1, 1.5, 1, 1, 1, 1, 1, 1];
		
		public function Bot2() {
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.shawdow.addChild(sh)
			var arr:Array = [U_Lyk.f];
			heads 		= RasterClip.getAnimationBitmaps(new ItemHeadBot2(), arr);// PrepareGr.creatBms(, false, U_Lyk.f);
			bodys 		= RasterClip.getAnimationBitmaps(new ItemBodyBot2(), arr);// PrepareGr.creatBms(,false,U_Lyk.f);
			sikirs 		= RasterClip.getAnimationBitmaps(new ItemGun1Bot2(), arr);// PrepareGr.creatBms(,false,U_Lyk.f);
			appArmsR 	= RasterClip.getAnimationBitmaps(new ItemUpArmBot2(), arr);// PrepareGr.creatBms(,false,U_Lyk.f);
			hends1R  	= RasterClip.getAnimationBitmaps(new ItemHand1RBot2(), arr);// PrepareGr.creatBms(,false,U_Lyk.f);
			hends2R  	= RasterClip.getAnimationBitmaps(new ItemHand2RBot2(), arr);// PrepareGr.creatBms(,false,U_Lyk.f);
			hends1L  	= RasterClip.getAnimationBitmaps(new ItemHand1LBot2(), arr);// PrepareGr.creatBms(,false,U_Lyk.f);
			hends2L  	= RasterClip.getAnimationBitmaps(new ItemHand2LBot2(), arr);// PrepareGr.creatBms(,false,U_Lyk.f);
			legs1R 		= RasterClip.getAnimationBitmaps(new ItemLeg1RBot2(), arr);// PrepareGr.creatBms(,false,U_Lyk.f);
			legs2R 		= RasterClip.getAnimationBitmaps(new ItemLeg2RBot2(), arr);// PrepareGr.creatBms(,false,U_Lyk.f);
			legs3R 		= RasterClip.getAnimationBitmaps(new ItemLeg3RBot2(), arr);// PrepareGr.creatBms(,false,U_Lyk.f);
			legs1L 		= RasterClip.getAnimationBitmaps(new ItemLeg1LBot2(), arr);// PrepareGr.creatBms(,false,U_Lyk.f);
			legs2L 		= RasterClip.getAnimationBitmaps(new ItemLeg2LBot2(), arr);// PrepareGr.creatBms(,false,U_Lyk.f);
			legs3L 		= RasterClip.getAnimationBitmaps(new ItemLeg3LBot2(), arr);// PrepareGr.creatBms(,false,U_Lyk.f);
			sikirs2 	= RasterClip.getAnimationBitmaps(new ItemShildBot2, arr);// PrepareGr.creatBms(,false,U_Lyk.f);
			
			parts = [this._head, this._body, this._sikira, this._appArmR, this._appArmL, this._hend1R, this._hend2R, this._hend2L,  this._leg1R, this._leg2R, this._leg3R, this._leg1L, this._leg2L, this._leg3L,_sikira2];
			parts_of_parts = [heads, bodys, sikirs, appArmsR, hends1L, hends1R, hends2R,  hends2L, legs1R, legs2R, legs3R, legs1L, legs2L, legs3L, sikirs2];
			this.lvl = 1;
			this.itemUpdate(this.lvl);
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
			//Report.addMassage("bot2 vllv: " + lvl);
			this.lvl = lvl;
			this.itemUpdate(lvl);
			//normalScales = normalScales[lvl]
			scaleX = normScale;
			scaleY = normScale;
			filters = [];
			free = false;
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
			for (var i:int = 0; i < sounds.length; i++)  {
				if (sounds[i].frame == currentFrame) {
					App.sound.playSound(sounds[i].id, App.sound.onVoice, 1);
				}
			}
		}
		
		public function frees():void {
			free = true;
			gotoAndStop(1);
			if (parent) {
				parent.removeChild(this);
			}
		}
		
		public function itemUpdate(obj:Object):void
		{
			
			Report.addMassage(this.lvl)
			for (var i:int = 0; i < parts.length; i++) 
			{
				if (Sprite(parts[i]).numChildren < 0){
					Sprite(parts[i]).removeChildAt(1);
				}
				switch(true)
			    {
				    case (i == 0):
					   Sprite(parts[i]).addChild(this.parts_of_parts[i][this.lvl-1]);
					   break;
					case(i == 1):
						Sprite(parts[i]).addChild(this.parts_of_parts[i][this.lvl-1]);
					    break;
					case(i == 2):
					    Sprite(parts[i]).addChild(this.parts_of_parts[i][this.lvl-1]);
					    break;
					case(i == 3 || i == 4):
						 Sprite(parts[i]).addChild(this.parts_of_parts[i][this.lvl-1]);
					    break;
					case(i > 4 && i < 8):
						Sprite(parts[i]).addChild(this.parts_of_parts[i][this.lvl-1]);
					    break;
					case(i > 7 && i < 14):
						Sprite(parts[i]).addChild(this.parts_of_parts[i][this.lvl-1]);
					    break;
					case(i == 14):
						Sprite(parts[14]).addChild(this.parts_of_parts[i][this.lvl-1]);
						break;
			   }
			}
		}
		
		
	}

}