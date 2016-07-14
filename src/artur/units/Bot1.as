package artur.units 
{
	import artur.App;
	import artur.PrepareGr;
	import artur.RasterClip;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import report.Report;
	
	public class Bot1 extends BarbDoll {
		public  var normScale:Number = 1;
		private var heads		:Array;
		private var bodys       :Array;
		private var sikirs      :Array;
		private var appArmsR  	:Array;
		private var hends1R    	:Array;
		private var hends2R    	:Array;
		private var hends3R    	:Array;
		private var appArmsL  	:Array;
		private var hends1L    	:Array;
		private var hends2L    	:Array;
		private var hends3L    	:Array;
		private var legs1R      :Array;
		private var legs2R      :Array;
		private var legs3R      :Array;
		private var legs1L      :Array;
		private var legs2L      :Array;
		private var legs3L      :Array;
		public var type:String = 'Bot1';
		public var free:Boolean = true;
		 
		 //private var parts:Array 
		private var isOver:Boolean = false;
		private var parts:Array ;
		private var parts_of_parts:Array;
		private var sh:Bitmap = RasterClip.getMovedBitmap(new mcShawdow());//PrepareGr.creatBms(new mcShawdow(), true)[0];
		private static var sounds:Array = [{id:'fow2',frame:67},{id:'bot1_hurt',frame:85},{id:'blade1',frame:83},{id:'blade2',frame:94},{ id:'bot1_attack', frame:64 }, { id:'bot1_fs1', frame:47 }, { id:'bot1_fs2', frame:56 },{id:'bot1_die',frame:95} ];
		public var my_filter:ColorMatrixFilter
		private static var normalScales:Array = [1, 1.5, 1, 1, 1, 1, 1, 1];
		private var lvl:int = 0;
		
		public function Bot1() 
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.shawdow.addChild(sh)
			heads 		= RasterClip.getAnimationBitmaps(new itemHead_bot1(), [U_Lyk.f]);//PrepareGr.creatBms(, false, U_Lyk.f);
			bodys 		= RasterClip.getAnimationBitmaps(new itemBody_bot1(), [U_Lyk.f]);//PrepareGr.creatBms(, false, U_Lyk.f);
			sikirs 		= RasterClip.getAnimationBitmaps(new itemSikir_bot1(), [U_Lyk.f]);//PrepareGr.creatBms(, false, U_Lyk.f);
			appArmsR 	= RasterClip.getAnimationBitmaps(new itemAppArm_bot1(), [U_Lyk.f]);//PrepareGr.creatBms(, false, U_Lyk.f);
			hends1R  	= RasterClip.getAnimationBitmaps(new itemHend1R_bot1(), [U_Lyk.f]);//PrepareGr.creatBms(, false, U_Lyk.f);
			hends2R  	= RasterClip.getAnimationBitmaps(new itemHend2R_bot1(), [U_Lyk.f]);//PrepareGr.creatBms(, false, U_Lyk.f);
			hends3R  	= RasterClip.getAnimationBitmaps(new itemHend3R_bot1(), [U_Lyk.f]);//PrepareGr.creatBms(, false, U_Lyk.f);
			appArmsL 	= RasterClip.getAnimationBitmaps(new itemAppArm2_bot1(), [U_Lyk.f]);//PrepareGr.creatBms(, false, U_Lyk.f);
			hends1L  	= RasterClip.getAnimationBitmaps(new itemHend1L_bot1(), [U_Lyk.f]);//PrepareGr.creatBms(, false, U_Lyk.f);
			hends2L  	= RasterClip.getAnimationBitmaps(new itemHend2L_bot1(), [U_Lyk.f]);//PrepareGr.creatBms(, false, U_Lyk.f);
			hends3L  	= RasterClip.getAnimationBitmaps(new itemHend3L_bot1(), [U_Lyk.f]);//PrepareGr.creatBms(, false, U_Lyk.f);
			legs1R 		= RasterClip.getAnimationBitmaps(new itemLeg1R_bot1(), [U_Lyk.f]);//PrepareGr.creatBms(, false, U_Lyk.f);
			legs2R 		= RasterClip.getAnimationBitmaps(new itemLeg2R_bot1(), [U_Lyk.f]);//PrepareGr.creatBms(, false, U_Lyk.f);
			legs3R 		= RasterClip.getAnimationBitmaps(new itemLeg3R_bot1(), [U_Lyk.f]);//PrepareGr.creatBms(, false, U_Lyk.f);
			legs1L 		= RasterClip.getAnimationBitmaps(new itemLeg1L_bot1(), [U_Lyk.f]);//PrepareGr.creatBms(, false, U_Lyk.f);
			legs2L 		= RasterClip.getAnimationBitmaps(new itemLeg2L_bot1(), [U_Lyk.f]);//PrepareGr.creatBms(, false, U_Lyk.f);
			legs3L		= RasterClip.getAnimationBitmaps(new itemLeg3L_bot1(), [U_Lyk.f]);//PrepareGr.creatBms(, false, U_Lyk.f);
			
			parts = [this._head, this._body, this._sikira, this._appArmR, this._hend1R, this._hend2R, this._hend3R, this._appArmL, this._hend1L, this._hend2L, this._hend3L, this._leg1R, this._leg2R, this._leg3R, this._leg1L, this._leg2L, this._leg3L];
			parts_of_parts = [heads, bodys, sikirs, appArmsR, hends1R, hends2R, hends3R, appArmsL, hends1L, hends2L, hends3L, legs1R, legs2R, legs3R, legs1L, legs2L, legs3L];
			//parts = [heads,bodys,sikirs,appArmsR,hends1R,hends2R,hends3R,appArmsL,hends1L,hends2L,hends3L];
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
			
			var matrix:Array = new Array();
			matrix=matrix.concat([0,1,0,0,0]);// red
			matrix=matrix.concat([0,0,1,0,0]);// green
			matrix=matrix.concat([1,0,0,0,0]);// blue
			matrix=matrix.concat([0,0,0,1,0]);// alpha
			my_filter = new ColorMatrixFilter(matrix);
			//this.filters
	           for (var i:int = 0; i < parts_of_parts.length; i++) 
			   {
				   for (var j:int = 0; j < parts_of_parts[i].length; j++) 
				   {
					  // parts_of_parts[i][j].filters = [my_filter];
				   }
			   }
			
		//	 this.addEventListener(MouseEvent.MOUSE_OVER, over);
		//	 this.addEventListener(MouseEvent.MOUSE_OUT, out);
			// itemUpdate([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
			// this.scaleX = 1.5;
			// this.scaleY = 1.5;
			 //this.gotoAndPlay('run');
			 //this.addFrameScript(125, frees);
			 
		}
		public function out(e:MouseEvent=null):void 
		 {
			isOver = false;
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
	
		public function init(parr:DisplayObjectContainer=null, lvl:int=0):void
		{
			
			this.lvl = lvl;
			Report.addMassage(lvl);
			itemUpdate(lvl);
			//Report.addMassage(lvl+' lvl BOSS')
			normScale = normalScales[lvl - 1];
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
				this.filters = [my_filter];
			}
			for (var i:int = 0; i < sounds.length; i++) 
			{
				if (sounds[i].frame == currentFrame) 
				{
					App.sound.playSound(sounds[i].id, App.sound.onVoice, 1);
				}
			}
			//filters = [my_filter];
		}
		
		public function frees():void {
			free = true;
			gotoAndStop(1);
			if (this.parent) {
				parent.removeChild(this);
			}
			this.removeEventListener(MouseEvent.MOUSE_OVER, over);
			this.removeEventListener(MouseEvent.MOUSE_OUT, out);
		}
		
		public function itemUpdate(obj:Object = null):void {
			for (var i:int = 0; i < parts.length; i++) {
			   Sprite(parts[i]).removeChildAt(1);
			   Sprite(parts[i]).addChild(this.parts_of_parts[i][lvl-1]);
			}	
		}
		
	}

}