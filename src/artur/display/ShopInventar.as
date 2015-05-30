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
			this.tabEnabled = false;
			this.tabChildren = false;
			this.scroll_sprite.mouseEnabled = false;
			this.scroll.source = this.scroll_sprite;
			//this.cacheAsBitmap = true;
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
			var item_obj:Object;
			
			if (itemType < 5)
			{
			    currPart = parts_of_parts [itemType];
			}
			else if (itemType == 5)
			{   
				currPart = guns1[unitType];
			}
			else
			{
				currPart = guns2[unitType];
			}
			var h:int = 0;
			for (var i:int = 1; i <= currPart.length; i++) 
			{
				var it_obj:Object = UserStaticData.magazin_items[this.unitType][this.itemType][i];
				
				
				
				if(it_obj!=null)
				{
					var mov:ShopItemBG = this.getBg();
					var img:Sprite = currPart[i-1];
					mov.init(this.scroll_sprite, img, it_obj);
					mov.y = h;
					h += mov.height;
				}
				
				
				
				/*
				var mov:bgBlankItemShop = new bgBlankItemShop();
				mov.y = h;
				mov.gotoAndStop(2);
				mov.cacheAsBitmap = true;
				mov.buttonMode = true;
				mov.mouseChildren = false;
				h += mov.height;
				this.scroll_sprite.addChild(mov);*/
			}
			
			this.scroll.update();
			
			
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
			 this.addChild(btnClosed);
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
			return new_bg;
		}
		
		private function onOut(e:MouseEvent):void 
		{
			/*e.currentTarget.scaleX = 1;
			e.currentTarget.scaleY = 1;
			e.currentTarget.filters  = [];
			App.info.frees();*/
		}
		
		private function onOver(e:MouseEvent):void 
		{
			/*e.currentTarget.scaleX  = 1.1;
			e.currentTarget.scaleY  = 1.1;
			App.btnOverFilter.color = 0xFBFBFB;
			e.currentTarget.filters   = [App.btnOverFilter];
			var obj:Object = UserStaticData.magazin_items[unitType][itemType][int(e.currentTarget.name)];
			if (int(e.currentTarget.name) < 4)
				App.info.init(e.currentTarget.x + e.currentTarget.width, e.currentTarget.y +e.currentTarget.height , {title:"Шмотка", type:2, chars:obj.c, bye:true});//236, 115, "SomeItem", true, true, obj.c)
			else
				App.info.init(e.currentTarget.x  - 236 , e.currentTarget.y +e.currentTarget.height ,{title:"Шмотка", type:2, chars:obj.c, bye:true});*/
		}   
		
		private function onClick(e:MouseEvent):void 
		{
			/*var _gold:int = UserStaticData.hero.gold;
			var _silver:int = UserStaticData.hero.silver;
			var gold:int = UserStaticData.magazin_items [unitType] [itemType] [int(e.currentTarget.name)].c[101];
			var silver:int =  UserStaticData.magazin_items [unitType] [itemType] [int(e.currentTarget.name)].c[100];
			 if (!WinCastle.isMoney(gold,silver)) 
			 {
				 App.byeWin.init("");
			 }
			 else
			 {
				 App.byeWin.init("Желаю купить", "hren", gold, silver, int(e.currentTarget.name), 1, itemType);
			 }
			 
			 */
			
		}
		public function update():void
		{
			
		}
		public function frees():void
		{
			/*for (var i:int = 0; i < currPart.length; i++) 
			{
				var img:Sprite = currPart[i];
				 this.removeChild(img);
				 img.removeEventListener(MouseEvent.CLICK, onClick);
				 img.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
				 img.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
			}
			App.spr.removeChild(this);*/
		}
		
	}

}