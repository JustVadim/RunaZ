package artur.display 
{
	import artur.win.WinCastle;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Server.Lang;
	import Utils.Functions;
	
	public class ShopItemBG extends bgBlankItemShop
	{
		public var free:Boolean = true;
		private var item_image:Sprite = new Sprite();
		public var txtGold:TextField = Functions.getTitledTextfield(65, 1, 45, 18, new Art().fontName, 12, 0xFFF642, TextFormatAlign.LEFT, "", 1, Kerning.OFF, -1);
		public var txtSilver:TextField = Functions.getTitledTextfield(155, 1, 45, 18, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.LEFT, "", 1, Kerning.OFF, -1);
		public var txtBtn:TextField = Functions.getTitledTextfield(0, -2, 77, 20, new Art().fontName, 14, 0xC29A4C, TextFormatAlign.CENTER, Lang.getTitle(84), 1, Kerning.AUTO, 0);
		public var title:TextField = Functions.getTitledTextfield(4, 134, 85, 16, new Art().fontName, 9, 0xFFB119, TextFormatAlign.CENTER, "Вещица", 1, Kerning.AUTO, 0);
		
		public var txtHp:McInfoInfos = new McInfoInfos(Lang.getTitle(63));
		public var txtMp:McInfoInfos = new McInfoInfos(Lang.getTitle(64));
		public var txtDmg:McInfoInfos = new McInfoInfos(Lang.getTitle(65));
		public var txtf_fiz:McInfoInfos = new McInfoInfos(Lang.getTitle(66));
		public var txtf_mag:McInfoInfos = new McInfoInfos(Lang.getTitle(67));
		public var txtInc:McInfoInfos = new McInfoInfos(Lang.getTitle(69));
		public var txtSpeed:McInfoInfos = new McInfoInfos(Lang.getTitle(68));
		public var txtLevel:McInfoInfos = new McInfoInfos(Lang.getTitle(16));
		
		public var descr:TextField = Functions.getTitledTextfield(95, 5, 280, 105, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.CENTER, "", 0.9, Kerning.AUTO, 0);
		
		
		public function ShopItemBG() 
		{
			this.tabEnabled = this.tabChildren = this.mouseChildren = this.inc.visible = false;
			this.addChild(this.item_image);
			this.makeInvisiblePlussAndNumber(this.txtHp);
			this.makeInvisiblePlussAndNumber(this.txtMp);
			this.makeInvisiblePlussAndNumber(this.txtDmg);
			this.makeInvisiblePlussAndNumber(this.txtf_fiz);
			this.makeInvisiblePlussAndNumber(this.txtf_mag);
			this.makeInvisiblePlussAndNumber(this.txtInc);
			this.makeInvisiblePlussAndNumber(this.txtSpeed);
			this.makeInvisiblePlussAndNumber(this.txtLevel)
			this.btn.addChild(this.txtBtn);
			
			this.hp.addChild(this.txtHp);
			this.mp.addChild(this.txtMp);
			this.dmg.addChild(this.txtDmg);
			this.f_fiz.addChild(this.txtf_fiz);
			this.f_mag.addChild(this.txtf_mag);
			this.inc.addChild(this.txtInc);
			this.speed.addChild(this.txtSpeed);
			this.level.addChild(this.txtLevel);
			this.addChild(this.title);
			
			this.buttonMode = true;
			this.cacheAsBitmap = true;
			this.dmg.iconRange.visible = false;
			this.price.addChild(this.txtGold);
			this.price.addChild(this.txtSilver);
			this.descr.multiline = true;
			this.descr.wordWrap = true;
		}	
		
		private function makeInvisiblePlussAndNumber(info:McInfoInfos):void {
			info.txtPlus.visible = false;
			info.txt2.visible = false;
			
		}
		
		public function init(par:Sprite, image:Sprite, item_obj:Object):void {
			//size logic
			this.gotoAndStop(1);
			this.name = item_obj.id;
			this.free = false;
			this.item_image.addChild(image);
			par.addChild(this);
			var i:int = 0;
				if (this.showChars(0, i, item_obj, this.hp, txtHp)) i++;
				if (this.showChars(1, i, item_obj, this.mp, txtMp)) i++;
				if (this.showChars(2, i, item_obj, this.dmg, txtDmg)) i++;
				if (this.showChars(3, i, item_obj, this.f_fiz,txtf_fiz)) i++;
				if (this.showChars(4, i, item_obj, this.f_mag,txtf_mag)) i++;
				if (this.showChars(5, i, item_obj, this.speed, txtSpeed)) i++;
			this.setLevel(i, item_obj);
			this.title.text = Lang.getItemTitle(item_obj.c[103], item_obj.id, item_obj.c[102]);
			if(item_obj.c[103] == 7) {
				this.descr.htmlText = Lang.getTitle(172, item_obj.id);
				this.addChild(this.descr);	
			}
			this.txtGold.text = item_obj.c[101];
			this.txtSilver.text = item_obj.c[100];
			this.addEventListener(MouseEvent.ROLL_OVER, this.onOver);
			this.addEventListener(MouseEvent.ROLL_OUT, this.onOut)
		}
		
		private function setLevel(i:int, item_obj:Object):void {
			var lvl:int = (item_obj.c[108] == null)? 1:int(item_obj.c[108]);
			Functions.compareAndSet(this.txtLevel.txt1, item_obj.c[108]);
			if (UserStaticData.hero.units[WinCastle.currSlotClick].lvl < lvl) {
				this.txtLevel.txt1.textColor = this.txtLevel.title.textColor =  0xF40000;
			} else {
				this.txtLevel.txt1.textColor = this.txtLevel.title.textColor = 0xFFFFFF;
			}
		}
		
		private function onOut(e:MouseEvent):void 
		{
			this.btn.gotoAndStop(1);
		}
		
		private function onOver(e:MouseEvent):void 
		{
			this.btn.gotoAndStop(2);
		}
		
		private function showChars(char:int, i:int, obj:Object, mc:MovieClip, info:McInfoInfos):Boolean {
			if (obj.c[char] != null) {
				mc.visible = true;
				mc.y = 5 + i * 16;
				info.txt1.text = " +" + obj.c[char];
			} else {
				mc.visible = false;
			}
			return mc.visible;
		}
		
		public function frees():void {
			this.free = true;
			this.parent.removeChild(this);
			while (this.item_image.numChildren > 0) {
				this.item_image.removeChildAt(0);
			}
			if(this.descr.parent) {
				this.descr.parent.removeChild(this.descr);
			}
		}
	}
}