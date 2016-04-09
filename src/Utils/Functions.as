package Utils {
	import flash.display.MovieClip;
	import flash.text.AntiAliasType;
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Functions {
		
		public static function SetPriteAtributs(mc:Object, mouseUnabled:Boolean, mouseChildren:Boolean, xx:Number = 0, yy:Number = 0):void {
			mc.tabEnabled = false;
			mc.tabChildren = false;
			mc.mouseEnabled = mouseUnabled;
			mc.mouseChildren = mouseChildren;
			if (xx != 0) {1
				mc.x = xx;
			}
			if (yy != 0) {
				mc.y = yy;
			}
		}
		
		public static function GetHeroChars():Array {
			var chars:Array = [0, UserStaticData.hero.skills.energy * 10 , UserStaticData.hero.skills.attack, UserStaticData.hero.skills.defence, UserStaticData.hero.skills.defence];
			return chars;
		}
		
		public static function getTitledTextfield(xx:Number, yy:Number, ww:Number, hh:Number, fontName:String, size:int, text_color:int, align:String, str:String = "", alpha:Number = 1, kerning:Object = Kerning.AUTO, letterSpacing:Object = 0, bold:Boolean = false, leading:int = 0):TextField {
			var textf:TextFormat = new TextFormat();
			textf.font = fontName;
			textf.size = size;
			textf.color = text_color;
			textf.align = align;
			textf.kerning = kerning;
			textf.letterSpacing = letterSpacing; 
			textf.bold = bold;
			textf.leading = leading;
			var title:TextField = new TextField();
			title.embedFonts = true;
			title.antiAliasType = AntiAliasType.ADVANCED
			title.defaultTextFormat = textf;
			title.x = xx;
			title.y = yy;
			title.textColor = text_color;
			title.selectable = false;
			title.tabEnabled = false;
			title.mouseEnabled = false;
			title.mouseWheelEnabled = false;
			title.width = ww;
			title.height = hh;
			title.text = str;
			//title.border = true;
			title.borderColor = 0xFFFFFF;
			title.alpha = alpha;
			if (title.text.length > 1) {
				title.cacheAsBitmap = true;
			}
			return title;
		}
		
		public static function compareAndSet(textf:TextField, text:String):void {
			if(textf.text != text) {
				textf.text = text;
				textf.cacheAsBitmap = true;
			}
		}

		public static function compareAndSetHTML(textf:TextField, text:String):void {
			if(textf.htmlText != text) {
				textf.htmlText= text;
				textf.cacheAsBitmap = true;
			}
		}
		
		
	}
}