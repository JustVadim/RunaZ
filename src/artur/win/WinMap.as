package artur.win 
{
	import artur.App;
	import artur.display.BaseButton;
	import artur.display.MapTown;
	import artur.display.TownList;
	import artur.PrepareGr;
	import artur.RasterClip;
	import artur.util.GetServerData;
	import artur.util.Maker;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class WinMap 
	{
		public static var currMap:int = 0;
		private var bgs:Array = [Maker.raster(new mapBg1(), 800, 420)];
		private var maps:Array = [];
		private var sprsXY:Array = [new mcBuildsCoordinate1()];
		public var bin:Boolean = false;
		private var bg:Bitmap;
	    private var names:Array =
		[
			['Арагон','Бригас','Наом','Тамкар','Травинкал','Апром','Мигор','Квонг','Сагос','Неаро','Валк','Валес']
		]
		public var townList:TownList 
		
		public function WinMap() 
		{
			////
			townList = new TownList();
			for (var j:int = 0; j < bgs.length; j++) 
			{
				 var b:Bitmap = bgs[j];
				 b.smoothing = true;
			     b.scaleX /= PrepareGr.scaleFactor;
			     b.scaleY /= PrepareGr.scaleFactor;
			}
			
			////
			 for (var i:int = 0; i < sprsXY.length; i++) 
			 {
				var cClip:Sprite = sprsXY[i];
				maps[i] = [];
				for (var z:int = 0; z < cClip.numChildren; z++) 
				{
					 var town:MapTown = new MapTown(new BaseButton(17 +z),names[currMap][z]);
					 town.x = cClip.getChildAt(z).x+ town.width/2;
					 town.y = cClip.getChildAt(z).y + town.height / 2;
					 town.name = String(z);
					 maps[i].push(town);
				}
			 }
		}
		public function init():void
		{
			bg = bgs[currMap];
			App.spr.addChild(bg);
			var lastTown:int = GetServerData.getLastTown();
			WinMap.currMap = int(lastTown/12);
			for (var i:int = 0; i < maps[currMap].length; i++) 
			{
				var town:MapTown = maps[currMap][i];
				App.spr.addChild(town);
				switch(true)
				{
					case lastTown == i:
						town.updateTable(MapTown.CURR_TOWN);
						town.addEventListener(MouseEvent.CLICK, onTown);
						break;
					case lastTown < i:
						town.updateTable(MapTown.HOLD_TOWN);
						break;
					 case lastTown > i:
						town.addEventListener(MouseEvent.CLICK, onTown);
						town.updateTable(MapTown.WINN_TOWN);
						break;
				}
			}
			App.spr.addChild(App.btnRoot); 
		}
		
		private function onTown(e:MouseEvent):void 
		{
			var num:int = int(e.currentTarget.name);
			townList.init(currMap, num , names[currMap][num]);
		}
		public function update():void
		{
			
		}
		public function frees():void
		{
			for (var i:int = 0; i < 12; i++) 
			{
				var town:MapTown = maps[currMap][i];
				town.removeEventListener(MouseEvent.CLICK, onTown);
			}
			
		}
		
	}

}