package artur.display {
	import artur.App;
	import artur.PrepareGr;
	import artur.RasterClip;
	import artur.win.WinCastle;
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import Server.Lang;
	
	public class ShopInventar extends mcShopInventar {
		private var heads:Array           	= 	RasterClip.getAnimationBitmaps(new Shop_Head);// PrepareGr.creatBms(new Shop_Head(), true)
		private var bodys:Array           	= 	RasterClip.getAnimationBitmaps(new Shop_Bodys());//PrepareGr.creatBms(,true) 
		private var boots:Array            	= 	RasterClip.getAnimationBitmaps(new Shop_Boots());
		private var hends_top:Array 		=	RasterClip.getAnimationBitmaps(new Shop_HendTop());
		private var hends_down:Array 		= 	RasterClip.getAnimationBitmaps(new Shop_HendDown());
		private var guns1:Array            	=	[RasterClip.getAnimationBitmaps(new Shop_Gun()), RasterClip.getAnimationBitmaps(new Shop_Gun1Pall), RasterClip.getAnimationBitmaps(new Shop_Lyk()), RasterClip.getAnimationBitmaps(new Shop_Totem())];
		private var guns2:Array            	=	[[],RasterClip.getAnimationBitmaps(new Shop_Gun2Pall), [], []];
		private var invent:Array 			= 	RasterClip.getAnimationBitmaps(new Shop_Inv());
		private var parts_of_parts:Array 	= 	[heads, bodys, boots, hends_top, hends_down];
		private var btnClosed:BaseButton 	= 	new BaseButton(15);
		private var currPart:Array;
		private var itemType:int;
		private var itemIdex:int;
		private var unitType:int;
		private var invPlace:int
		private var scroll_sprite:Sprite = new Sprite();
		private var bgs_array:Array = new Array();
		private var bin:Boolean = false;

		public function ShopInventar() {
			this.tabEnabled = this.tabChildren = this.scroll_sprite.mouseEnabled = false; 
			this.scroll.source = this.scroll_sprite;
			this.btnClosed.addEventListener(MouseEvent.CLICK, closClick);
			this.btnClosed.x = 415 - 85;
			this.btnClosed.y = 407.5
		}
		
		private function closClick(e:MouseEvent):void {
			frees();
		}
		
		public function init(itemType:int = 0, unitType:int = 0, invPlace:int = -1):void {
			this.bin = true;
			App.sound.playSound('inventar', App.sound.onVoice, 1);
			App.spr.addChild(this);
			this.itemType = itemType;
			this.unitType = unitType;
			this.invPlace = invPlace;
			switch(true) {
				case(itemType < 5):
					currPart = this.parts_of_parts[itemType];
					break;
				case (itemType == 5):
					currPart = this.guns1[unitType];
					break;
				case (itemType == 6):
					currPart = this.guns2[unitType];
					break;
				case (itemType == 7):
					currPart = this.invent;
					break;	
			}
			var h:int = 0;
			var item_obj:Object;
			for (var i:int = 1; i <= currPart.length; i++) {
				var it_obj:Object = UserStaticData.magazin_items[this.unitType][this.itemType][i];	
				if(it_obj !=null) {
					var mov:ShopItemBG = this.getBg();
					mov.init(this.scroll_sprite, Bitmap(currPart[i-1]), it_obj);
					mov.y = h;
					h += mov.height;
				}
			}
			this.scroll.update();
			this.addChild(btnClosed);
			if (UserStaticData.hero.demo == 1) {
				App.tutor.init(5);
			}
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
		}
		
		private function onRemoved(e:Event):void {
			this.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
			this.frees();
		}
		
		private function getBg():ShopItemBG {
			for (var i:int = 0; i < bgs_array.length; i++) {
				if (ShopItemBG(bgs_array[i]).free) {
					return bgs_array[i];
				}
			}
			var new_bg:ShopItemBG = new ShopItemBG();
			bgs_array.push(new_bg);
			new_bg.addEventListener(MouseEvent.CLICK, onClick);
			return new_bg;
		}
		
		private function onClick(e:MouseEvent):void  {
			var mc:MovieClip = MovieClip(e.currentTarget);
			var item_id:int = int(mc.name);
			var item:Object = UserStaticData.magazin_items [unitType] [itemType] [item_id];
			var _gold:int = UserStaticData.hero.gold;
			var _silver:int = UserStaticData.hero.silver;
			var gold:int = item.c[101];
			var silver:int =  item.c[100];
			if (!WinCastle.isMoney(gold, silver)) {
				App.closedDialog.init1(Lang.getTitle(4), false, true, true);
			} else if(item.c[108] > UserStaticData.hero.units[WinCastle.currSlotClick].lvl) {
				App.closedDialog.init1(Lang.getTitle(17), false, true, false);
			} else {
				App.byeWin.init(Lang.getTitle(72), Lang.getItemTitle(this.itemType, item_id, this.unitType), gold, silver, item_id, 1, this.itemType, this.invPlace);
			}
		}
		
		public function update():void {
			
		}
		
		public function frees():void {
			if (this.bin) {
				this.bin = false;
				for (var i:int = 0; i < bgs_array.length; i++)  {
					if (!ShopItemBG(bgs_array[i]).free) {
						ShopItemBG(bgs_array[i]).frees();
					}
				}
				if(this.parent) {
					App.spr.removeChild(this);
				}
			}
		}
		
	}

}