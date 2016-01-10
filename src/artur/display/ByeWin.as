package artur.display 
{
	import artur.App;
	import artur.util.Maker;
	import artur.win.WinCastle;
	import artur.win.WinKyz;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import report.Report;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Server.Lang;
	import Utils.Functions;
	import Utils.json.JSON2;
	
	public class ByeWin extends dialogBye {
		
		private var btnGold:BaseButton;
		private var btnSilver:BaseButton;
		private var btnEx:BaseButton;
		private var btnAddMoney:BaseButton;
		private var index:int = NaN;
		private var byeType:int = 0;
		private var itemType:int;
		private var invPlace:int = -1;
		
		private var txt:TextField = Functions.getTitledTextfield(315, 163, 183, 80, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.AUTO, 0, false, 2);
		private var txtGold:TextField = Functions.getTitledTextfield(345, 242, 52, 17, new Art().fontName, 14, 0, TextFormatAlign.LEFT, "", 0.6, Kerning.OFF, -1, false);
		private var txtSilver:TextField = Functions.getTitledTextfield(437, 242, 52, 17, new Art().fontName, 14, 0, TextFormatAlign.LEFT, "", 0.6, Kerning.OFF, -1, false);
		
		public function ByeWin() {
			Functions.SetPriteAtributs(this.iconGold, false, false);
			Functions.SetPriteAtributs(this, true, true);
			Functions.SetPriteAtributs(this.iconGold, false, false);
			this.initBtn(this.btnEx = new BaseButton(11), 507.9, 158.75);
			this.initBtn(this.btnSilver = new BaseButton(12), 458.9, 252.55);
			this.initBtn(this.btnGold = new BaseButton(12), 352.55, 252.55);
			this.addChild(this.btnEx);
			this.addChild(this.txt);
			
		}
		
		
		private function initBtn(mc:BaseButton, xx:Number, yy:Number):void {
			mc.x = xx;
			mc.y = yy;
			mc.addEventListener(MouseEvent.CLICK, this.onBtn);
			Functions.SetPriteAtributs(mc, true, false);
		}
		
		
		public function init(text1:String = "", text2:String = "", priceGold:int = 0, priceSilver:int = 0, index:int = NaN, byeType:int = 0, itemType:int = NaN, invPlace:int = NaN):void {
			if (text1 == "") {
				this.txt.text = Lang.getTitle(4);
				if (this.iconGold.parent) 	this.removeChild(this.iconGold);
				if (this.btnGold.parent) 	this.removeChild(this.btnGold);
				if (this.iconSilver.parent) this.removeChild(this.iconSilver);
				if (this.btnSilver.parent) 	this.removeChild(this.btnSilver);
				if (this.txtGold.parent) 	this.removeChild(this.txtGold);
				if (this.txtSilver.parent) 	this.removeChild(this.txtSilver);
			} else {
				txt.text = String(text1 + "\n" + text2 + "\nза");
				this.index = index;
				this.byeType = byeType;
				this.itemType = itemType;
				this.invPlace = invPlace;
				if (priceGold != 0 && WinCastle.isGold(priceGold)) {
					this.txtGold.text = String(priceGold);
					this.addChild(this.btnGold);
					this.addChild(this.iconGold);
					this.addChild(this.txtGold); 
				} else {
					if (this.btnGold.parent) 	this.removeChild(this.btnGold);
					if (this.iconGold.parent) 	this.removeChild(this.iconGold);
					if (this.txtGold.parent) 	this.removeChild(this.txtGold);
				}
				if (priceSilver != 0 && (WinCastle.isSilver(priceSilver) || this.index == 2 || this.index == 3)) {
					this.txtSilver.text = String(priceSilver);
					this.addChild(this.btnSilver);
					this.addChild(this.txtSilver);
					this.addChild(this.iconSilver);
				} else {
					if (this.btnSilver.parent)		this.removeChild(this.btnSilver);
					if (this.txtSilver.parent) 		this.removeChild(this.txtSilver);
					if (this.iconSilver.parent)		this.removeChild(this.iconSilver);
				}
			}
			App.spr.addChild(this);
		}
		
		private function onBtn(e:MouseEvent):void {
			var mc:BaseButton = BaseButton(e.currentTarget);
			switch (byeType) {
				case 0:
					switch(mc) {
					case this.btnGold:
						bye(1);
						break;
					case this.btnSilver:
						bye(0);
						break;
					case this.btnEx:
						frees();
						break;
				    }
				 break;
			 case 1:
				switch (mc) {
					case this.btnGold:
						byeItem(1);
						break;
					case this.btnSilver:
						byeItem(0);
						break;
					case this.btnEx:
						frees();
						break;
				}
				break;
			case 2:
				switch (mc) {
					case this.btnSilver:
						WinCastle.chest.sellItem();
						this.frees();
						break;
					case this.btnEx:
						WinCastle.chest.putItemOnOldPlace();
						this.frees();
						break;
				}
				break; 
			case 3:
				switch (mc) {
					case this.btnSilver:
						WinCastle.inventar.sellItem();
						this.frees();
						break;
					case this.btnEx:
						WinCastle.inventar.putOnOldPlace()
						this.frees();
						break;
				}
				break;
			case 4:
				switch(mc) {
					case this.btnEx:
						this.frees();
						break;
					case this.btnGold:
						WinKyz.inst.zakazKamnja(this.itemType);
						this.frees();
						break;
				}
				break;
			case 5:
				switch(mc) {
					case this.btnEx:
						this.frees();
						break;
					case this.btnGold:
						WinKyz.inst.craftItem();
						this.frees();
						break;
				}
				break;
			}
			
		}
		
		public function bye(indexPrice:int):void {
			frees();
			App.lock.init();
			var obj:Object = { ns:WinCastle.currSlotClick, hn:index, p:indexPrice };
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, getRess);
			data.sendData(COMMANDS.BYE_UNIT, JSON2.encode(obj),true);
		}
		
		public function byeItem(indexPrice:int):void
		{
			 frees();
			 App.lock.init();
			 WinCastle.shopInventar.frees();
			 var obj:Object = { ns:WinCastle.currSlotClick, hn:index, p:indexPrice, it:itemType, inp:invPlace};
			 var data:DataExchange = new DataExchange();
			 data.addEventListener(DataExchangeEvent.ON_RESULT, getRess2);
			 data.sendData(COMMANDS.BYE_ITEM, JSON2.encode(obj),true);
		}
		
		private function getRess(e:DataExchangeEvent):void {
	        DataExchange(e.target).removeEventListener(e.type, getRess);
			App.sound.playSound('gold', App.sound.onVoice, 1);
			var obj:Object = JSON2.decode(e.result);
			if (obj.error == null) {
				if (obj.s != null) {
					UserStaticData.hero.silver = int(obj.s);
					WinCastle.txtCastle.txtSilver.text = String(obj.s);
				} else {
					UserStaticData.hero.gold = int(obj.g);
					WinCastle.txtCastle.txtGold.text = String(obj.g);
				}
				UserStaticData.hero.units[int(WinCastle.currSlotClick)] = Maker.clone(UserStaticData.magaz_units[index]);
				WinCastle.getCastle().updateSlots();
				WinCastle.txtCastle.scroll.visible = false;
			 App.lock.frees();
			} else {
				App.lock.init('Error: '+obj.error)
			}
			//unlock crab
		}
		
		private function getRess2(e:DataExchangeEvent):void {
			DataExchange(e.target).removeEventListener(e.type, getRess);
			var obj:Object = JSON2.decode(e.result);
			if (obj.error == null) {
				if (obj.s != null) {
					UserStaticData.hero.silver = int(obj.s);
					WinCastle.txtCastle.txtSilver.text = String(obj.s);
				} else {
					UserStaticData.hero.gold = int(obj.g);
					WinCastle.txtCastle.txtGold.text = String(obj.g);
				}
				var unit:Object = UserStaticData.hero.units[int(WinCastle.currSlotClick)];
				if(this.invPlace == -1) {
					unit.it[this.itemType] = Maker.clone(UserStaticData.magazin_items[unit.t][this.itemType][this.index] ) ;
					WinCastle.getCastle().slots[int(WinCastle.currSlotClick)].unit.itemUpdate(Slot.getUnitItemsArray(unit));
					WinCastle.inventar.updateItem(this.itemType, this.index);
					WinCastle.inventar.calculateUnitStats(Functions.GetHeroChars(), unit, 1);
				} else {
					unit.inv[invPlace] = Maker.clone(UserStaticData.magazin_items[UserStaticData.hero.units[int(WinCastle.currSlotClick)].t ][itemType][index]);
					WinCastle.inventar.updateInv(this.invPlace, unit);
				}
				App.lock.frees();
				App.sound.playSound('gold', App.sound.onVoice, 1);
			}
			else {
				App.lock.init('Error: '+obj.error)
			}
		}
		
		public function frees():void {
			App.spr.removeChild(this);
		}
		
	}

}