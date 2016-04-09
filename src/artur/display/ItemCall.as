package artur.display 
{
	import Server.Lang;
	import adobe.utils.CustomActions;
	import artur.App;
	import artur.RasterClip;
	import artur.win.WinCastle;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import report.Report;
	
	public class ItemCall extends Sprite {
		public static var cache:Array = [];
		public var free:Boolean = true;
		private var itemImage:ItemCallImage;
		
		
		
		public static var sounds:Array =
		[
			['gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1'],
			['gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1'],
			['gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1'],
			['gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1'],
			['gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1'],
			['gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1'],
			['gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1'],
			['gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1', 'gloves1'],
		]
		
		public function ItemCall() {
			this.tabEnabled = this.tabChildren = this.mouseChildren = false;
			this.buttonMode = true;
		}
		
		public function init(unitType:int, itemType:int, index:int):void {
			if(unitType == -1 && itemType == -1 && index==-1) {
				this.free = false;
				this.itemImage.free = false;
				this.addChild(this.itemImage);
				return;
			}
			this.free = false;
			this.addChild(this.itemImage = ItemCallImage.getItemCallImage(unitType, itemType, index));
			Main.THIS.stage.addChild(this);
		}
		
		public function out(e:MouseEvent=null):void {
			this.scaleX = 1;
			this.scaleY = 1;
			this.filters = [];
			App.info.frees();
		}
		
		public function over(e:MouseEvent):void {
			this.filters = [App.btnOverFilter];
			var item:Object = UserStaticData.hero.chest[int(e.currentTarget.name)];
			App.info.init(this.x+WinCastle.chest.x- 236,this.y+WinCastle.chest.y+this.height, { title:Lang.getItemTitle(item.c[103], item.id, item.c[102]), type:2, chars:item.c, bye:false } )
		}
		
		
		public function frees():void {
			//Report.addMassage("freeesss");
			free = true;
			this.itemImage.free = true;
			if (this.itemImage.parent) {
				this.itemImage.parent.removeChild(this.itemImage);
			}
			if (this.parent) {
				this.parent.removeChild(this);
			}
		}
		
		public static function getCall():ItemCall {
			for (var i:int = 0; i < cache.length; i++) {
				if (cache[i].free == true) {
					ItemCall(cache[i]).mouseEnabled = true;
					return cache[i]; 
				}
			}
			var call:ItemCall = new ItemCall();
			cache.push(call);
			return call;
		}
		
	}

}