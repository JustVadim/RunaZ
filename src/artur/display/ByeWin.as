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
		
		private var g:int;
		private var s:int;
		
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
			mc.addEventListener(MouseEvent.ROLL_OVER, this.onOver);
			mc.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
			Functions.SetPriteAtributs(mc, true, false);
		}
		
		private function onOut(e:MouseEvent):void 
		{
			App.info.frees();
		}
		
		private function onOver(e:MouseEvent):void {
			var mc:BaseButton = BaseButton(e.currentTarget);
			switch(mc) {
				case this.btnEx:
					App.info.init(mc.x + mc.width, mc.y + mc.height, { txtInfo_w:100, txtInfo_h:37, txtInfo_t:Lang.getTitle(47), type:0 });
					break;
				case this.btnGold:
					App.info.init(mc.x + mc.width, mc.y + mc.height, { txtInfo_w:100, txtInfo_h:37, txtInfo_t:Lang.getTitle(48), type:0 });
					break;
				case this.btnSilver:
					if(byeType != 2 || byeType != 3) {
						App.info.init(mc.x + mc.width, mc.y + mc.height, { txtInfo_w:100, txtInfo_h:37, txtInfo_t:Lang.getTitle(49), type:0 } );
					} else {
						App.info.init(mc.x + mc.width, mc.y + mc.height, { txtInfo_w:100, txtInfo_h:37, txtInfo_t:Lang.getTitle(50), type:0 } );
					}
					break;
			}
		}
		
		
		public function init(text1:String = "", text2:String = "", priceGold:int = 0, priceSilver:int = 0, index:int = NaN, byeType:int = 0, itemType:int = NaN, invPlace:int = NaN):void {
			App.sound.playSound('inventar', App.sound.onVoice, 1);
			this.g = priceGold;
			this.s = priceSilver;
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
				if (priceGold != 0) {
					this.txtGold.text = String(priceGold);
					this.addChild(this.btnGold);
					this.addChild(this.iconGold);
					this.addChild(this.txtGold); 
				} else {
					if (this.btnGold.parent) 	this.removeChild(this.btnGold);
					if (this.iconGold.parent) 	this.removeChild(this.iconGold);
					if (this.txtGold.parent) 	this.removeChild(this.txtGold);
				}
				if (priceSilver != 0) {
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
			if(UserStaticData.hero.demo == 0) {
				App.tutor.init(6);
			}
		}
		
		private function onBtn(e:MouseEvent):void {
			var mc:BaseButton = BaseButton(e.currentTarget);
			switch (byeType) {
				case 0:
					switch(mc) {
					case this.btnGold:
						if(UserStaticData.hero.gold >= this.g) {
							this.bye(1);
						} else {
							App.closedDialog.init1(Lang.getTitle(45), false, true, true);
						}
						break;
					case this.btnSilver:
						if(UserStaticData.hero.silver >= this.s) {
							this.bye(0);
						} else {
							App.closedDialog.init1(Lang.getTitle(46), false, true, true);
						}
						break;
					case this.btnEx:
						this.frees();
						break;
				    }
				 break;
			 case 1:
				switch (mc) {
					case this.btnGold:
						if(UserStaticData.hero.gold >= this.g) {
							this.byeItem(1);
						} else {
							App.closedDialog.init1(Lang.getTitle(45), false, true, true);
						}
						break;
					case this.btnSilver:
						if(UserStaticData.hero.silver >= this.s) {
							this.byeItem(0);
						} else {
							App.closedDialog.init1(Lang.getTitle(46), false, true, true);
						}
						break;
					case this.btnEx:
						this.frees();
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
						if(UserStaticData.hero.gold >= this.g) {
							WinKyz.inst.zakazKamnja(this.itemType);
							this.frees();
							if(UserStaticData.hero.demo == 6) {
								UserStaticData.hero.demo++;
								App.tutor.init(19);
							} else if (UserStaticData.hero.level<3 && UserStaticData.hero.demo> 6 || UserStaticData.hero.level< 5) {
								App.tutor.frees();
							}
							
						} else {
							App.closedDialog.init1(Lang.getTitle(45), false, true, true);
						}
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
			case 6:
				switch(mc) {
					case this.btnEx:
						this.frees();
						break;
					case this.btnGold:
						if (UserStaticData.hero.gold < GameVars.ENERGY_PRICE) {
							App.closedDialog.init1(Lang.getTitle(45), false, true, true);
						} else {
							App.topMenu.buyEnergy();
						}
						this.frees();
						break;
				}
				break;
			case 7:
				switch(mc) {
					case this.btnEx:
						this.frees();
						break;
					case this.btnSilver:
						this.frees();
						this.soldHero();
						break;
				}
				break;
			}
			
		}
		
		private function soldHero():void {
			App.lock.init();
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, this.onSoldHero);
			data.sendData(COMMANDS.SOLD_HERO, WinCastle.currSlotClick, true);
		}
		
		private function onSoldHero(e:DataExchangeEvent):void {
			var res:Object = JSON2.decode(e.result);
			if (res.res != null) {
				delete(UserStaticData.hero.units[WinCastle.currSlotClick]);
				UserStaticData.hero.silver += 800;
				App.sound.playSound('gold', App.sound.onVoice, 1);
				App.topMenu.updateGold();
				Slot(WinCastle.getCastle().slots[WinCastle.currSlotClick]).init();
				WinCastle.getCastle().selectSlot(int(WinCastle.currSlotClick));
				App.lock.frees();
			} else {
				App.lock.init(res.error);
			}
		}
		
		public function bye(indexPrice:int):void {
			this.frees();
			App.lock.init();
			var obj:Object = { ns:WinCastle.currSlotClick, hn:index, p:indexPrice };
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, getRess);
			data.sendData(COMMANDS.BYE_UNIT, JSON2.encode(obj), true);
		}
		
		public function byeItem(indexPrice:int):void {
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
					App.topMenu.updateGold();
				} else {
					UserStaticData.hero.gold = int(obj.g);
					App.topMenu.updateGold();
				}
				UserStaticData.hero.units[int(WinCastle.currSlotClick)] = Maker.clone(UserStaticData.magaz_units[index]);
				Slot(WinCastle.getCastle().slots[WinCastle.currSlotClick]).init();
				WinCastle.getCastle().selectSlot(int(WinCastle.currSlotClick));
				
				WinCastle.txtCastle.scroll.visible = false;
				if(UserStaticData.hero.demo == 0) {
					UserStaticData.hero.demo++;
					App.tutor.init(4);
				}
				App.lock.frees();
			} else {
				App.lock.init('Error: '+obj.error)
			}
		}
		
		private function getRess2(e:DataExchangeEvent):void {
			DataExchange(e.target).removeEventListener(e.type, getRess);
			var obj:Object = JSON2.decode(e.result);
			if (obj.error == null) {
				if (obj.s != null) {
					UserStaticData.hero.silver = int(obj.s);
					App.topMenu.updateGold();
				} else {
					UserStaticData.hero.gold = int(obj.g);
					App.topMenu.updateGold();
				}
				var unit:Object = UserStaticData.hero.units[int(WinCastle.currSlotClick)];
				if(this.invPlace == -1) {
					unit.it[this.itemType] = Maker.clone(UserStaticData.magazin_items[unit.t][this.itemType][this.index] ) ;
					WinCastle.getCastle().slots[int(WinCastle.currSlotClick)].unit.itemUpdate(Slot.getUnitItemsArray(unit));
					WinCastle.inventar.updateItem(this.itemType, this.index);
					WinCastle.inventar.calculateUnitStats(Functions.GetHeroChars(), unit);
				} else {
					unit.inv[invPlace] = Maker.clone(UserStaticData.magazin_items[UserStaticData.hero.units[int(WinCastle.currSlotClick)].t ][itemType][index]);
					WinCastle.inventar.updateInv(this.invPlace, unit);
				}
				App.lock.frees();
				App.sound.playSound('gold', App.sound.onVoice, 1);
				if(UserStaticData.hero.demo == 1) {
					UserStaticData.hero.demo++;
					App.tutor.init(7);
				}
			}
			else {
				App.lock.init('Error: '+obj.error)
			}
		}
		
		public function frees():void {
			App.info.frees();
			App.spr.removeChild(this);
		}
		
	}

}