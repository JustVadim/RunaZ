package artur.util 
{
	import report.Report;
	public class GetServerData 
	{
		
		public static function getLastTown():int
		{
			var i:int = 0;
			do
			{
				if (UserStaticData.hero.miss[i] == null)
					break;
				i++;
			}
			while (true);
			return i-1;
		}
		
		public static function getUserIsReadyToBattle():Boolean
		{
			var units:Object = UserStaticData.hero.units;
			for (var key:Object in units)
			{
				if (units[key].it[5] != null)
				{return true; }
			}
			return false;
		}
	}

}