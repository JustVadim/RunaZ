package artur 
{
	import artur.display.btnClosedShopExtended;
	import artur.display.BtnHeroExtend;
	import artur.display.btnSel1Extend;
	import artur.display.MyBitMap;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import Server.Lang;
	
	public class PrepareGr 
	{
		public var cach:Array = [];
		public  var clips:Array = 
		[
			new bg1Root(), //0
			new btnBank,//1
			new btnTop,//2
			new btnCastle,//3
			new btnArena,//4
			new btnShop, //5
			new btnSend,//6
			new bgCastle1,//7
			new btnAddHero,//8
			new BtnHeroExtend,//9
			new bgBlankUnit,//10;
			new btnExit(),//11
			new btnBye(),//12
			new mcBgHeroInv(),//13
			new btnTown(),//14
			new btnClosedShopExtended(),//15
			new mcBrmPart(),//16
			new t1(), // 17
			new t2(), // 18
			new t3(), //19
			new t4(), //20
			new t5(),//21
			new t6(),//22
			new t7(),//23
			new t8(),//24
			new t9(),//25
			new t10(),//26
			new t11(),//27
			new t12(),//28
			new btnMap(),//29
			new btnToBatle(),//30
			new btnCloseList(),//31
			new imgBtnCastle(),//32
			new btnTakes(),//33
			new btnPlus(),//34
			new btnSel1Extend(Lang.getTitle(40, 0)),//35
			new btnSel1Extend(Lang.getTitle(40, 1)),//36
			new btnSel1Extend(Lang.getTitle(40, 2)),//37
			new btnSel1Extend(Lang.getTitle(40, 3)),//38
		];
		
		public static var scaleFactor:Number = 2;
		
		private static var spr:Sprite;
		private static var bmd:BitmapData;
		public static var scaleFactor2:Number = 3;
		private static var drawSpr:Sprite = new Sprite();
		private static var rect : Rectangle = new Rectangle();
		private var flooredX : int;
		private var flooredY : int;
		private static var mtx : Matrix;
		private static var bm:Bitmap;
	       
		public function PrepareGr() {
			while (clips.length > 0) {
				spr = clips.shift();
				spr.width *= scaleFactor;
				spr.height *= scaleFactor;
				drawSpr.addChild(spr);
				bmd = new BitmapData(drawSpr.width, drawSpr.height, true, 0);
				bmd.draw(drawSpr);
				cach.push(bmd);
				drawSpr.removeChild(spr);
				spr = null;
			}
		}
		
		public static function creatBms(clip:MovieClip,getSprites:Boolean = false,filter:Object=null ):Array {
			var bms:Array = [];
			clip.width *= scaleFactor;
			clip.height *= scaleFactor;
			if (filter)
			  clip.filters = [filter];
			  
			for (var i:int = 0; i < clip.totalFrames; i++) {
				clip.gotoAndStop(i + 1);
				drawSpr.addChild(clip);
				for (var j:int = 0; j < clip.numChildren; j++) {
					if(clip.getChildAt(j) is MovieClip) {
						MovieClip(clip.getChildAt(j)).gotoAndStop(i + 1)
					}
				}
				rect = drawSpr.getBounds(drawSpr);
				mtx = new Matrix();
				mtx.tx = -rect.x;
				mtx.ty = -rect.y;
				bmd = new BitmapData(drawSpr.width, drawSpr.height, true, 0);
				bmd.draw(drawSpr, mtx);
				drawSpr.removeChild(clip);
				bm = new Bitmap(bmd, PixelSnapping.AUTO, true);
				bm.width /= scaleFactor; 
				bm.height /= scaleFactor;
				bm.x -= mtx.tx/scaleFactor;
				bm.y -= mtx.ty / scaleFactor;
				 
				if (clip.currentLabel) {
					bm.name = clip.currentLabel;
				} else  {
					bm.name = String(clip.currentFrame);
				}
				if (getSprites) {
					var spr:Sprite = new Sprite();
					spr.addChild(bm);
					spr.name = bm.name;
					bms.push(spr); 
				} else {
				   bms.push(bm);
				}
			}
			clip = null;
			return bms;
		}
	}

}