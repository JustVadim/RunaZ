package rabbit.utils 
{
	
	/**
	 * ...
	 * @author Thomas John (thomas.john@open-design.be)
	 */
	public class StringUtils
	{
		
		public function StringUtils() 
		{
			
		}
		
		/**
		 * Add leading characters in 'string' until 'finalLength' is reached.
		 * @param	string Main string to add characters to.
		 * @param	lead String that is going to be added to the main string. This string will be cut if too big to reach the final length.
		 * @param	finalLength Final length that the main string should have
		 * @return	A string with leading characters added to main string
		 */
		
		public static function addLeadingChars(string:String, lead:String, finalLength:int):String
		{
			var need:int = finalLength - string.length;
			var leadingChars:String = "";
			
			var i:int = 0;
			var n:int = need;
			
			for (i = 0; i < n; i++) 
			{
				var j:int = 0;
				var m:int = lead.length;
				
				for (j = 0; j < m; j++) 
				{
					leadingChars += lead.substr(j, 1);
				}
			}
			
			return leadingChars + string;
		}
		
		public static function addEndingChars(string:String, end:String, finalLength:int):String
		{
			var need:int = finalLength - string.length;
			var endingChars:String = "";
			
			var i:int = 0;
			var n:int = need;
			
			for (i = 0; i < n; i++) 
			{
				var j:int = 0;
				var m:int = end.length;
				
				for (j = 0; j < m; j++) 
				{
					endingChars += end.substr(j, 1);
				}
			}
			
			return endingChars + string;
		}
		
		/**
		 * Check if a string is empty.
		 * @param	value String to check.
		 * @return True if empty, False if not.
		 */
		public static function isEmpty(value:String):Boolean 
		{
			if (value == null) return true;
			return !value.length;
		}
		
		public static function trim(value:String):String
		{ 
			if (value == null) return null;
			return rtrim(ltrim(value));
		} 
		
        public static function ltrim(value:String):String
        { 
			if (value == null) return null;
			var pattern:RegExp = /^\s*/;
			return value.replace(pattern, "");
		} 
		
        public static function rtrim(value:String):String
        { 
			if (value == null) return null;
			var pattern:RegExp = /\s*$/;
			return value.replace(pattern, "");
		}
		
		public static function isEmail(value:String):Boolean
		{
			value = trim(value);
			var pattern:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
			var result:Object = pattern.exec(value);
			if (result == null) return false;
			return true;
		}
		
		public static function generateRandomString(length:int = 4, chars:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"):String
		{
			var s:String = "";
			
			while (length--)
			{
				s += chars.substr(Math.floor(Math.random() * chars.length), 1);
			}
			
			return s;
		}
		
		public static function getFileName(path:String, keepExtension:Boolean = true):String
		{
			var fSlash:int = path.lastIndexOf("/");
			var bSlash:int = path.lastIndexOf("\\");
			var sIndex:int = fSlash > bSlash ? fSlash : bSlash;
			
			var fileName:String = path.substring(sIndex + 1);
			
			trace(fSlash, bSlash, sIndex, fileName);
			
			if ( !keepExtension )
			{
				sIndex = fileName.lastIndexOf(".");
				fileName = fileName.substring(0, sIndex);
			}
			
			return fileName;
		}
		
		public static function getAfter(text:String, after:String, lastIndex:Boolean = false):String
		{
			var pos:int = -1;
			
			if ( lastIndex )
			{
				pos = text.lastIndexOf(after);
			}
			else
			{
				pos = text.indexOf(after);
			}
			
			if ( pos >= 0 )
			{
				text = text.substr(pos + after.length);
			}
			
			return text;
		}
		
		public static function getBefore(text:String, before:String, lastIndex:Boolean = false):String
		{
			var pos:int = -1;
			
			if ( lastIndex )
			{
				pos = text.lastIndexOf(before);
			}
			else
			{
				pos = text.indexOf(before);
			}
			
			if ( pos >= 0 )
			{
				text = text.substr(0, pos);
			}
			
			return text;
		}
		
		public static function left(text:String, length:int):String
		{
			if ( text.length <= length ) return text;
			return text.substr(0, length);
		}
		
		public static function right(text:String, length:int):String
		{
			if ( text.length <= length ) return text;
			return text.substr(text.length - length, length);
		}
	}
	
}