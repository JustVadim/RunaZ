package artur.display 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ShopItemBG extends bgBlankItemShop
	{
		public var free:Boolean = true;
		private var item_image:Sprite = new Sprite();
		
		public function ShopItemBG() 
		{
			this.tabEnabled = this.tabChildren = this.mouseChildren = this.inc.visible = false;
			this.addChild(this.item_image);
			this.makeInvisiblePlussAndNumber(this.hp);
			this.makeInvisiblePlussAndNumber(this.mp);
			this.makeInvisiblePlussAndNumber(this.dmg);
			this.makeInvisiblePlussAndNumber(this.f_fiz);
			this.makeInvisiblePlussAndNumber(this.f_mag);
			this.makeInvisiblePlussAndNumber(this.inc);
			this.makeInvisiblePlussAndNumber(this.speed);
			this.hp.txt1.text = "1";
			this.buttonMode = true;
			this.cacheAsBitmap = true;
		}	
		
		private function makeInvisiblePlussAndNumber(hp:MovieClip):void 
		{
			hp.txtPlus.visible = false;
			hp.txt2.visible = false;
		}
		
		public function init(par:Sprite, image:Sprite, item_obj:Object):void
		{
			this.name = item_obj.id;
			this.free = false;
			this.item_image.addChild(image);
			par.addChild(this);
			this.gotoAndStop(1);
			var i:int = 0;
			if (this.showChars(0, i, item_obj, this.hp)) i++;
			if (this.showChars(1, i, item_obj, this.mp)) i++;
			if (this.showChars(2, i, item_obj, this.dmg)) i++;
			if (this.showChars(3, i, item_obj, this.f_fiz)) i++;
			if (this.showChars(4, i, item_obj, this.f_mag)) i++;
			if (this.showChars(5, i, item_obj, this.speed)) i++;
			this.price.txtGold.text = item_obj.c[101];
			this.price.txtSilver.text = item_obj.c[100];
			this.addEventListener(MouseEvent.ROLL_OVER, this.onOver);
			this.addEventListener(MouseEvent.ROLL_OUT, this.onOut)
		}
		
		private function onOut(e:MouseEvent):void 
		{
			this.btn.gotoAndStop(1);
		}
		
		private function onOver(e:MouseEvent):void 
		{
			this.btn.gotoAndStop(2);
		}
		
		private function showChars(char:int, i:int, obj:Object, mc:MovieClip):Boolean 
		{
			if (obj.c[char] != null)
			{
				mc.visible = true;
				mc.y = 5 + i * 16;
				mc.txt1.text = obj.c[char];
			}
			else
			{
				mc.visible = false;
			}
			return mc.visible;
		}
		
		public function frees():void
		{
			this.free = true;
			this.parent.removeChild(this);
			while (this.item_image.numChildren > 0)
				this.item_image.removeChildAt(0);
		}
	}
}