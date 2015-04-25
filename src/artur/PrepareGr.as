package artur 
{
	import artur.display.MyBitMap;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import report.Report;
	/**
	 * ...
	 * @author art
	 */
	public class PrepareGr 
	{
		public var cach:Array = [];
		public  var clips:Array = 
		[new bg1Root(), //0
		new btnBank,//1
		new btnTop,//2
		new btnCastle,//3
		new btnArena,//4
		new btnShop, //5
		new btnSend,//6
		new bgCastle1,//7
		new btnAddHero,//8
		new btnAddHero2,//9
		new bgBlankUnit,//10;
		new btnExit(),//11
		new btnBye(),//12
		new mcBgHeroInv(),//13
		new btnTown(),//14
		new btnClosedShop(),//15
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
		new btnCloseList()//31
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
	     
		  
		public function PrepareGr() 
		{
			while (clips.length > 0)
			{
				
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
		public static function creatBms(clip:MovieClip,getSprites:Boolean = false ):Array
		{
			 var bms:Array = [];
			 clip.width *= scaleFactor;
			 clip.height *= scaleFactor;
			for (var i:int = 0; i < clip.totalFrames; i++) 
			{
				 clip.gotoAndStop(i + 1);
				 drawSpr.addChild(clip);
				 rect = drawSpr.getBounds(drawSpr);
				 mtx = new Matrix();
				 mtx.tx = -rect.x;
				 mtx.ty = -rect.y;
				 bmd = new BitmapData(drawSpr.width, drawSpr.height, true, 0);
				 bmd.draw(drawSpr, mtx);
				 drawSpr.removeChild(clip);
				 bm = new Bitmap(bmd, 'auto', true);
				 bm.width /= scaleFactor; 
				 bm.height /= scaleFactor;
				 bm.x -= mtx.tx/scaleFactor;
				 bm.y -= mtx.ty / scaleFactor;
				 
				 if(clip.currentLabel)
				     bm.name = clip.currentLabel;
				 else
				     bm.name = String(clip.currentFrame);
				 
				 if (getSprites)
				 {
					 var spr:Sprite = new Sprite();
					 spr.addChild(bm);
					 spr.name = bm.name;
					 bms.push(spr); 
				 }
				 else
				   bms.push(bm);
				   
				
				
			}
			return bms;
		}

		
	}

}
/*
var myCircle:Shape = new Shape();
myCircle.graphics.beginFill(0xFF0000, 1.0);
myCircle.graphics.drawCircie(0, 0, 100);
myCircle.graphics.endFill();

var matrix:Matrix = new Matrix();
matrix.tx = myCircle.width / 2;
matrix.ty = myCircle.height / 2;

var myCircleBitmapData:BitmapData = new BitmapData(myCircle.width, myCircle.height, true, 0x00FFFFFF);
myCircleBitmapData.draw(myCircle, matrix);

var myCircleBitmap:Bitmap = new Bitmap(myCircleBitmapData, PixelSnapping.AUTO, true);
myCircleBitmap.x -= matrix.tx;
myCircleBitmap.y -= matrix.ty;

var circleContainer:Sprite = new Sprite();
circleContainer.addChild(myCircleBitmap);*/