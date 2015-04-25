package artur.util 
{
	import artur.PrepareGr;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Artur
	 */
	public class Maker 
	{
		
		public function Maker() 
		{
			
		}
		public static function getTextField(wd:Number = 100,hg:Number= 100,color:uint =0xFFFFFF, selec:Boolean= false,border:Boolean = true,ww:Boolean = true,size:int = 15,bgColor:uint= 0x252525,borderColor:uint = 0x5D5D5D ,alpha:Number = 0.7,align:String = TextFormatAlign.CENTER):TextField
		{
			 var myFont:Font = new Art();
			 var myFormat:TextFormat = new TextFormat();
			 myFormat.align = align
             myFormat.size = size;
			 myFormat.font = myFont.fontName;
			 var txt:TextField = new TextField();
			 txt.embedFonts = true;
             txt.antiAliasType = AntiAliasType.ADVANCED;
			 txt.wordWrap = ww;
			 
		     
			 txt.width  = wd
			 txt.height = hg
			 txt.textColor = color
			 if (border) 
			 {
				  txt.border = border;
				  txt.borderColor = borderColor
				  txt.background = true;
				  txt.backgroundColor =bgColor
				  myFormat.align = align
				  //txt.alpha = 0.6;
			 }
			 txt.defaultTextFormat = myFormat;
			 txt.selectable = false
			 txt.mouseEnabled = false;
			 txt.alpha = alpha;
			 return txt;
		}
		
		public static function raster(mc:Sprite, wd:Number , hg:Number , alpha:Boolean = true):Bitmap
		{
			 var bm:Bitmap
             var tmp_bitmap:BitmapData = new BitmapData( wd*PrepareGr.scaleFactor, hg*PrepareGr.scaleFactor , alpha, 0x00000000);
			 var clip:Sprite = new Sprite();
			 mc.width *= PrepareGr.scaleFactor;
			 mc.height *= PrepareGr.scaleFactor;
			 clip.addChild(mc);
             tmp_bitmap.draw(clip);
             bm = new Bitmap(tmp_bitmap);
			 mc = null;
			 clip = null;
             return bm;
		}
		
		public static function clone(source:Object):* 
		{
		    var copier:ByteArray = new ByteArray();
		    copier.writeObject(source);
		    copier.position = 0;
		    return(copier.readObject());
		}
		
		
	}
	
}