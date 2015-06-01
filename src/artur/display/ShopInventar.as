package artur.display 
{
	import artur.App;
	import artur.PrepareGr;
	import artur.win.WinCastle;
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import report.Report;
	
	public class ShopInventar extends mcShopInventar
	{
		 private var heads:Array           = PrepareGr.creatBms(new Shop_Head(),true)
		 private var bodys:Array           = PrepareGr.creatBms(new Shop_Bodys(),true) 
		private var boots:Array            = PrepareGr.creatBms(new Shop_Boots(),true)
		private var hends_top:Array     =PrepareGr.creatBms(new Shop_HendTop(),true)
		private var hends_down:Array  =PrepareGr.creatBms(new Shop_HendDown,true) 
		private var guns1:Array            =	[	PrepareGr.creatBms(new Shop_Gun, true),	PrepareGr.creatBms(new Shop_Gun1Pall, true)	, PrepareGr.creatBms(new Shop_Lyk(), true)	,	PrepareGr.creatBms(new Shop_Totem(), true)	];
		private var guns2:Array            =	[	[]                                   , 	PrepareGr.creatBms(new Shop_Gun2Pall(),true), []										,	[]											];
		private var parts_of_parts:Array = [heads, bodys, boots, hends_top, hends_down];
		private var btnClosed:BaseButton = new BaseButton(15);
		private var currPart:Array;
		private var itemType:int;
		private var itemIdex:int;
		private var unitType:int;
		private var scroll_sprite:Sprite = new Sprite();
		private var bgs_array:Array = new Array();

		public function ShopInventar() 
		{
			this.tabEnabled = this.tabChildren = this.scroll_sprite.mouseEnabled = false; 
			this.scroll.source = this.scroll_sprite;
			btnClosed.addEventListener(MouseEvent.CLICK, closClick);
		}
		
		private function closClick(e:MouseEvent):void 
		{
			frees();
		}
		
		public function init(itemType:int=0,unitType:int=0 ):void
		{
			App.spr.addChild(this);
			this.itemType = itemType;
			this.unitType = unitType;
			switch(true)
			{
				case(itemType < 5):
					currPart = parts_of_parts [itemType];
				break;
				case (itemType == 5):
					currPart = guns1[unitType];
				break;
				case (itemType == 6):
					currPart = guns2[unitType];
				break;
				
				
			}
			var h:int = 0;
			var item_obj:Object;
			for (var i:int = 1; i <= currPart.length; i++) 
			{
				var it_obj:Object = UserStaticData.magazin_items[this.unitType][this.itemType][i];	
				if(it_obj !=null)
				{
					var mov:ShopItemBG = this.getBg();
					mov.init(this.scroll_sprite, Sprite(currPart[i-1]), it_obj);
					mov.y = h;
					h += mov.height;
				}
			}
			
			this.scroll.update();
			this.addChild(btnClosed);
			btnClosed.x = btnClosed.y = 200;
			
			/*
			 * 
		    var wd:Number = currPart.length * (currPart[0].width+5);
		 	var stX:Number = (800 - wd) / 2;
			var stY:Number = 180;
			var dist1:int = 8;
			var dist2:int = 16;
			
			_bg.x = stX-dist1; _bg.y = stY- dist1; _bg.width = wd+dist1 ; _bg.height = currPart[0].height + dist1;
			
			_1.x = _bg.x - dist1; _1.y = _bg.y - dist1;
			_2.x = _bg.x+ _bg.width + dist1 ; _2.y = _1.y;
			_3.x = _1.x; _3.y = _1.y + _bg.height + dist2;
			_4.x = _2.x; _4.y = _3.y;
			
		    downLine.x = _3.x + dist1 ; downLine.y = _3.y -8; downLine.width = _bg.width;
			topLine.x =    _1.x + dist1 ; topLine.y = _1.y + 8; topLine.width = _bg.width;
			leftLine.x = _1.x+4; leftLine.y = _1.y + 8; leftLine.height = _bg.height;
			rightLine.x = _2.x-4 ; rightLine.y = _2.y + 8; rightLine.height = _bg.height;
			btnClosed.x = 800 / 2; btnClosed.y = topLine.y - 5 - btnClosed.height ;
			 for (var i:int = 0; i < currPart.length; i++) 
			 {
				 var img:Sprite = currPart[i];
				 this.addChild(img);
				 wd += img.width;
				 img.x = (stX - dist1 / 4) + (img.width+5) * i ;
				 img.y = stY -  dist1/2;
				 img.addEventListener(MouseEvent.CLICK, onClick);
				 img.addEventListener(MouseEvent.MOUSE_OVER, onOver);
				 img.addEventListener(MouseEvent.MOUSE_OUT, onOut);
				 img.buttonMode = true;
			 }
			 
             */
		}
		
		private function getBg():ShopItemBG
		{
			for (var i:int = 0; i < bgs_array.length; i++) 
			{
				if (ShopItemBG(bgs_array[i]).free)
				{
					return bgs_array[i];
				}
			}
			var new_bg:ShopItemBG = new ShopItemBG();
			bgs_array.push(new_bg);
			new_bg.addEventListener(MouseEvent.CLICK, onClick);
			return new_bg;
		}
		
		private function onClick(e:MouseEvent):void 
		{
			var item_id:int = int(e.currentTarget.name);
			var _gold:int = UserStaticData.hero.gold;
			var _silver:int = UserStaticData.hero.silver;
			var gold:int = UserStaticData.magazin_items [unitType] [itemType] [item_id].c[101];
			var silver:int =  UserStaticData.magazin_items [unitType] [itemType] [item_id].c[100];
			if (!WinCastle.isMoney(gold,silver)) 
			{
				App.byeWin.init("");
			}
			else
			{
				App.byeWin.init("Желаю купить", "hren", gold, silver, item_id, 1, itemType);
			}
		}
		public function update():void
		{
			
		}
		public function frees():void
		{
			
			for (var i:int = 0; i < bgs_array.length; i++) 
			{
				if (!ShopItemBG(bgs_array[i]).free)
				{
					ShopItemBG(bgs_array[i]).frees();
				}
			}
			App.spr.removeChild(this);
		}
		
	}

}