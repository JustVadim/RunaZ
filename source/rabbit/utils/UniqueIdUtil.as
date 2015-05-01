package rabbit.utils 
{
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Thomas John (c) thomas.john@open-design.be
	 */
	public class UniqueIdUtil 
	{
		private static var dIds:Dictionary = new Dictionary();
		
		public function UniqueIdUtil() 
		{
			
		}
		
		public static function getUniqueId(length:int = 32):String
		{
			var id:String = "";
			var i:int = 100;
			
			while (i--)
			{
				id = StringUtils.generateRandomString(length);
				
				if ( dIds[id] == null )
				{
					dIds[id] = true;
					break;
				}
			}
			
			return id;
		}
		
		public static function freeId(id:String):void
		{
			delete dIds[id];
		}
	}
	
}