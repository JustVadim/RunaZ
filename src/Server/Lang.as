package Server 
{
	public class Lang 
	{
		public static var lang:int = 0;
		private static var lang_table:Array = new Array();
		
		private static function init():void
		{
			Lang.lang_table[0] = new Array();
			lang_table[0][0] = ["Начало пути", "", "", ""];
		}
		
		public function Lang()
		{
			
		}
		
		public static function getTitle(id1:int, id2:int = -1, id3:int = -1):String
		{
			
		}
	}
}