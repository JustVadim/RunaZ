package artur.units 
{
	import report.Report;
	/**
	 * ...
	 * @author art
	 */
	public class UnitCache 
	{
		 private static var typeUnits:Array = [ { className:U_Warwar, type:'Barbarian' },{ className:U_Paladin, type:'Paladin' },{ className:U_Lyk, type:'Lyk' },{ className:Bot1, type:'Bot1' },{className:U_Mag,type:'Mag'} ];
		 public static var unitCache:Array = [];
		
		public static function getUnit(str:String):Object
		{
			for (var i:int = 0; i < unitCache.length; i++) 
			{
				if (unitCache[i].type == str && unitCache[i].free) 
				{
					//Report.addMassage(unitCache.length);
					return unitCache[i]; 
				}
			}
			
			for (var j:int = 0; j < typeUnits.length; j++) 
			{
				if (typeUnits[j].type == str ) 
				{
					var obj:Object = new typeUnits[j].className;
					unitCache.push(obj);
				//	Report.addMassage(unitCache.length+' new');
					return obj;
				}
			} 
			return new Object();
		}
		public static function update():void
		{
			for (var i:int = 0; i < unitCache.length; i++) 
			{
				if (!unitCache[i].free)
				   unitCache[i].update();
			}
		}
		
	}

}