package artur.units 
{	
	public class UnitCache 
	{
		private static var typeUnits:Array = 
		[ 
			{ className:U_Warwar, type:'Barbarian' }, 
			{ className:U_Paladin, type:'Paladin' }, 
			{ className:U_Lyk, type:'Lyk' }, 
			{ className:U_Mag, type:'Mag' }, 
			{ className:Bot1, type:'Bot1' },
			{ className:Bot2, type:'Bot2' }, 
			{ className:BotGolem, type:'BotGolem' },
			{ className:U_LykBot, type:'LykBot' } ,
			{ className:BotGhost, type:'BotGhost' },
			{ className:BotGhost2, type:'BotGhost2' }	
		];
		public static var unitCache:Array = [];
		
		public static function getUnit(str:String):Object {
			for (var i:int = 0; i < unitCache.length; i++) {
				if (unitCache[i].type == str && unitCache[i].free) {
					return unitCache[i]; 
				}
			}
			for (var j:int = 0; j < typeUnits.length; j++) {
				if (typeUnits[j].type == str ) {
					var obj:Object = new typeUnits[j].className;
					unitCache.push(obj);
					return obj;
				}
			} 
			throw new Error("Cant find unit type: " + str);
		}
		
		public static function update():void {
			for (var i:int = 0; i < unitCache.length; i++) {
				if (!unitCache[i].free) {
				   unitCache[i].update();
				}
			}
		}
	}

}