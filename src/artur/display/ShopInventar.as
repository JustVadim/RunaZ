package artur.display {
	import artur.App;
	import artur.PrepareGr;
	import artur.win.WinCastle;
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import Server.Lang;
	
	public class ShopInventar extends mcShopInventar {
		private var heads:Array           	= 	PrepareGr.creatBms(new Shop_Head(),true)
		private var bodys:Array           	= 	PrepareGr.creatBms(new Shop_Bodys(),true) 
		private var boots:Array            	= 	PrepareGr.creatBms(new Shop_Boots(),true)
		private var hends_top:Array 		=	PrepareGr.creatBms(new Shop_HendTop(),true)
		private var hends_down:Array 		= 	PrepareGr.creatBms(new Shop_HendDown,true) 
		private var guns1:Array            	=	[	PrepareGr.creatBms(new Shop_Gun, true),	PrepareGr.creatBms(new Shop_Gun1Pall, true)	, PrepareGr.creatBms(new Shop_Lyk(), true)	,	PrepareGr.creatBms(new Shop_Totem(), true)	];
		private var guns2:Array            	=	[	[]                                    , 	PrepareGr.creatBms(new Shop_Gun2Pall(), true), []										,	[]											];
		private var invent:Array 			= 	PrepareGr.creatBms(new Shop_Inv, true);
		private var parts_of_parts:Array 	= 	[heads, bodys, boots, hends_top, hends_down];
		private var btnClosed:BaseButton 	= 	new BaseButton(15);
		private var currPart:Array;
		private var itemType:int;
		private var itemIdex:int;
		private var unitType:int;
		private var invPlace:int
		private var scroll_sprite:Sprite = new Sprite();
		private var bgs_array:Array = new Array();

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
					mov.init(this.scroll_sprite, Sprite(currPart[i-1]), it_obj, "Вещица");
					mov.y = h;
					h += mov.height;
				}
			}
			this.scroll.update();
			this.addChild(btnClosed);
			if (UserStaticData.hero.demo == 1) {
				App.tutor.init(5);
			}
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
			var _gold:int = UserStaticData.hero.gold;
			var _silver:int = UserStaticData.hero.silver;
			var gold:int = UserStaticData.magazin_items [unitType] [itemType] [item_id].c[101];
			var silver:int =  UserStaticData.magazin_items [unitType] [itemType] [item_id].c[100];
			if (!WinCastle.isMoney(gold, silver)) {
				App.closedDialog.init1(Lang.getTitle(4), false, true, true);
			}
			else {
				App.byeWin.init(Lang.getTitle(72), "Вещицу", gold, silver, item_id, 1, this.itemType, this.invPlace);
			}
		}
		
		public function update():void {
			
		}
		public function frees():void {
			
			for (var i:int = 0; i < bgs_array.length; i++)  {
				if (!ShopItemBG(bgs_array[i]).free) {
					ShopItemBG(bgs_array[i]).frees();
				}
			}
			App.spr.removeChild(this);
		}
		
	}

}