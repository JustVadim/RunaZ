package artur.display 
{
	import adobe.utils.CustomActions;
	import artur.App;
	import artur.RasterClip;
	import artur.win.WinCastle;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import report.Report;
	/**
	 * ...
	 * @author art
	 */
	public class ItemCall extends Sprite
	{
		public static var cache:Array = [];
		
		public var free:Boolean = true;
		
		private var heads:RasterMovie = new RasterMovie(new Cell_Heads())///new RasterMovie(new Cell_Heads())
		private var bodys:RasterMovie = new RasterMovie(new Cell_Bodys())
		private var boots:RasterMovie =  new RasterMovie(new Cell_Boots())
		private var hends_top:RasterMovie =new RasterMovie(new Cell_TopHands())
		private var hends_down:RasterMovie =new RasterMovie(new Cell_DownHands())
		private var guns1:Array = [new RasterMovie(new Cell_Guns()), new RasterMovie(new Cell_Swords()),new RasterMovie(new Cell_Bows()), new RasterMovie(new Cell_Totem())];
		private var guns2:Array = [new RasterMovie(new Cell_Guns()), new RasterMovie(new Cell_Shilds())];
		private var parts_of_parts:Array = [heads, bodys, boots, hends_top, hends_down];
		private var inv:RasterMovie = new RasterMovie(new Cell_Inv());
		
		private var currItem:RasterMovie; 
		
		public static var sounds:Array =
		[
			['gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1'],
			['gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1'],
			['gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1'],
			['gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1'],
			['gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1'],
			['gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1'],
			['gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1'],
			['gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1']
		]
		
		public function ItemCall() 
		{
	
		}
		public function init(unitType:int,itemType:int,index:int):void
		{
			free = false;
			switch(true)
			{
				case (itemType < 5):
					currItem = parts_of_parts[itemType];
					break;
				case (itemType == 5):
					currItem = guns1[unitType];
					break;
				case (itemType == 6):
					currItem = guns2[unitType];
					break;
				case (itemType == 7):
					currItem = this.inv;
					break;
			}
			currItem.gotoAndStop(index);
			while (this.numChildren > 0)
				this.removeChildAt(0);
			this.addChild(currItem);
			Main.THIS.stage.addChild(this);
		}
		
		public function out(e:MouseEvent=null):void 
		{
			this.scaleX = 1;
			this.scaleY = 1;
			this.filters = [];
			App.info.frees();
		}
		
		public function over(e:MouseEvent):void 
		{
			this.filters = [App.btnOverFilter];
			App.info.init(this.x+WinCastle.chest.x- 236,this.y+WinCastle.chest.y+this.height, { title:"Шмотка", type:2, chars:UserStaticData.hero.chest[int(e.currentTarget.name)].c, bye:false } )
		}
		
		
		public function frees():void
		{
			
			 free = true;
			 if(this.parent)
				this.parent.removeChild(this);
		}
		
		public static function getCall():ItemCall
		{
			for (var i:int = 0; i < cache.length; i++) 
			{
				if (cache[i].free == true) 
				{
					return cache[i]; 
				}
			}
			var call:ItemCall = new ItemCall();
			cache.push(call);
			return call;
		}
		
	}

}