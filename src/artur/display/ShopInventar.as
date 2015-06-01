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
	/**
	 * ...
	 * @author art
	 */
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
		 //private var names:Array = [['Nhasd'],['Nhasd'],['Nhasd'],['Nhasd'],['Nhasd'],['Nhasd']];
		public function ShopInventar() 
		{
			btnClosed.addEventListener(MouseEvent.CLICK, closClick);
			
		}
		
		private function closClick(e:MouseEvent):void 
		{
			frees();
		}
		public function init(itemType:int=0,unitType:int=0 ):void
		{
			this.itemType = itemType;
			this.unitType = unitType;
			
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
			
			
		    var wd:Number = currPart.length * (currPart[0].width+5);
		 	var stX:Number = (800 - wd) / 2;
			var stY:Number = 180;
			var dist1:int = 8;
			var dist2:int = 16;
			
		
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
             App.spr.addChild(this);
		}
		
		private function onOut(e:MouseEvent):void 
		{
			e.currentTarget.scaleX = 1;
			e.currentTarget.scaleY = 1;
			e.currentTarget.filters  = [];
			App.info.frees();
		}
		
		private function onOver(e:MouseEvent):void 
		{
			e.currentTarget.scaleX  = 1.1;
			e.currentTarget.scaleY  = 1.1;
			App.btnOverFilter.color = 0xFBFBFB;
			e.currentTarget.filters   = [App.btnOverFilter];
			var obj:Object = UserStaticData.magazin_items[unitType][itemType][int(e.currentTarget.name)];
			if (int(e.currentTarget.name) < 4)
				App.info.init(e.currentTarget.x + e.currentTarget.width, e.currentTarget.y +e.currentTarget.height , {title:"Шмотка", type:2, chars:obj.c, bye:true});//236, 115, "SomeItem", true, true, obj.c)
			else
				App.info.init(e.currentTarget.x  - 236 , e.currentTarget.y +e.currentTarget.height ,{title:"Шмотка", type:2, chars:obj.c, bye:true});
		} 
		
		private function onClick(e:MouseEvent):void 
		{
			var _gold:int = UserStaticData.hero.gold;
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
			 
			 
			
		}
		public function update():void
		{
			
		}
		public function frees():void
		{
			for (var i:int = 0; i < currPart.length; i++) 
			{
				var img:Sprite = currPart[i];
				 this.removeChild(img);
				 img.removeEventListener(MouseEvent.CLICK, onClick);
				 img.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
				 img.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
			}
			App.spr.removeChild(this);
		}
		
	}

}