package artur.units 
{	
	import artur.RasterClip;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import report.Report;
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
			{ className:BotMag, type:'LykBot' } ,
			{ className:BotGhost, type:'BotGhost' },
			{ className:BotGhost2, type:'BotGhost2' },
			{ className:BotTroll, type:'BotTroll' }
			//{ className:BotMag, type:'MagBot' }
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
		
		public static function getItem(host:Bitmap, itemsVector:Array, type:int, frame:int):void{
			var vector:MovieClip = MovieClip(itemsVector[type]);
			vector.gotoAndStop(frame);
			vector.filters = [U_Lyk.f];
			if(vector.scaleX != RasterClip.unitItemsScale) {
				vector.scaleX = vector.scaleY = RasterClip.unitItemsScale;
			}
			if(vector.width > 5) {
				var cont:Sprite = new Sprite();
				cont.addChild(vector);
				var rect:Rectangle = cont.getBounds(cont);
				vector.x = -rect.x;
				vector.y = -rect.y;
				var bmd:BitmapData = new BitmapData(cont.width, cont.height, true, 0);
				bmd.draw(cont);
				host.bitmapData = bmd;
				host.pixelSnapping = PixelSnapping.AUTO;
				host.smoothing = true;
				host.scaleX /= RasterClip.unitItemsScale; 
				host.scaleY /= RasterClip.unitItemsScale;
				host.x = rect.x / RasterClip.unitItemsScale;
				host.y = rect.y / RasterClip.unitItemsScale;
				vector.x = 0;
				vector.y = 0;
				cont.removeChild(vector);
			}
		}
	}

}