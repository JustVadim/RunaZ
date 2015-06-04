package artur.display 
{
	import artur.App;
	import artur.util.Maker;
	import artur.win.WinCastle;
	import flash.events.MouseEvent;
	import report.Report;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Utils.json.JSON2;
	/**
	 * ...
	 * @author art
	 */
	public class ByeWin extends dialogBye
	{
		private var btnGold:BaseButton;
		private var btnSilver:BaseButton;
		private var btnEx:BaseButton;
		private var btnAddMoney:BaseButton;
		private var index:int = NaN;
		private var byeType:int = 0;
		private var itemType:int;
		private var invPlace:int = -1;
		public function ByeWin() 
		{
			
			btnEx = new BaseButton(11); btnEx.x = 507.9; btnEx.y = 258.75-100;
			btnGold = new BaseButton(12); btnGold.x = 364.9; btnGold.y = 352.55-100;
			btnSilver = new BaseButton(12); btnSilver.x = 458.9; btnSilver.y = 352.55 - 100;
			btnGold.name = 'gold'; btnSilver.name = 'silver'; btnEx.name = 'exit'
			btnGold.addEventListener(MouseEvent.CLICK, onBtn);
			btnSilver.addEventListener(MouseEvent.CLICK, onBtn);
			btnEx.addEventListener(MouseEvent.CLICK, onBtn);
		}
		public function init(text1:String = "", text2:String = "", priceGold:int = 0, priceSilver:int = 0, index:int = NaN, byeType:int = 0, itemType:int = NaN, invPlace:int = NaN):void
		{
			 
			if (text1 == "") 
			{
				txt.text = "У вас не достаточно ресурсов";
			}
			else
			{
				txt.text = String(text1 + '\n' + text2 + '\n за');
				this.index = index;
				this.byeType = byeType;
				this.itemType = itemType;
				this.invPlace = invPlace;
				this.addChild(btnEx);
				this.addChild(btnSilver);
				if (priceGold)
				{
				     this.addChild(btnGold);
				     this.addChild(iconGold); iconGold.mouseEnabled = false; iconGold.mouseChildren = false;
				     this.addChild(txtGold);  txtGold.mouseEnabled = false; txtGold.mouseChildren = false;
				   	 txtGold.text = String(priceGold);
				}
				else
				{
					if (this.contains(btnGold)) this.removeChild(btnGold);
					if (this.contains(iconGold)) this.removeChild(iconGold);
					if (this.contains(txtGold)) this.removeChild(txtGold);
				}
				this.addChild(iconSilver); iconSilver.mouseEnabled = false; iconSilver.mouseChildren = false;
				this.addChild(txtSilver); txtSilver.mouseEnabled = false;  txtSilver.mouseChildren = false;
				txtSilver.text = String(priceSilver);
				if (byeType < 2)
				{
				     btnGold.setActive(WinCastle.isGold(priceGold));
				     btnSilver.setActive(WinCastle.isSilver(priceSilver));
				}
			}
			App.spr.addChild(this);
		}
		
		private function onBtn(e:MouseEvent):void 
		{
			switch (byeType)
			{
				case 0:
					switch(e.currentTarget.name)
				    {
					case 'gold':
						bye(1);
						break;
					case 'silver':
						bye(0);
						break;
					case 'exit':
						frees();
						break;
				    }
				 break;
			 case 1:
				switch (e.currentTarget.name)
				{
					case 'gold':
						byeItem(1);
						break;
					case 'silver':
						byeItem(0);
						break;
					case 'exit':
						frees();
						break;
				}
				break;
			case 2:
				switch (e.currentTarget.name)
				{
					case 'silver':
						frees();
						WinCastle.chest.sellItem();
						break;
					case 'exit':
						WinCastle.chest.putItemOnOldPlace(WinCastle.chest.upped_item_call);
						frees();
						break;
				}
				break; 
			case 3:
				switch (e.currentTarget.name)
				{
					case 'silver':
						frees();
						WinCastle.inventar.sellItem();
						break;
					case 'exit':
						WinCastle.inventar.putOnOldPlace()
						frees();
						break;
				}
				break;
			}
			
		}
		public function bye(indexPrice:int):void
		{
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
		private function getRess(e:DataExchangeEvent):void
		{
	        DataExchange(e.target).removeEventListener(e.type, getRess);
			App.sound.playSound('gold', App.sound.onVoice, 1);
			var obj:Object = JSON2.decode(e.result);
			if (obj.error == null)
			{
				if (obj.s != null)
				{
					UserStaticData.hero.silver = int(obj.s);
					WinCastle.txtCastle.txtSilver.text = String(obj.s);
				}
				else
				{

					UserStaticData.hero.gold = int(obj.g);
					WinCastle.txtCastle.txtGold.text = String(obj.g);
				}
				 UserStaticData.hero.units[int(WinCastle.currSlotClick)] = Maker.clone(UserStaticData.magaz_units[index]);
				 WinCastle.getCastle().updateSlots();
				 WinCastle.txtCastle.scroll.visible = false;
				 App.lock.frees();
			}
			else
			{
				App.lock.init('Error: '+obj.error)
				Report.addMassage('bye unit error: error num ' + obj.error);
			}
			//unlock crab
		}
		private function getRess2(e:DataExchangeEvent):void
		{
			DataExchange(e.target).removeEventListener(e.type, getRess);
			Report.addMassage(e.result);
			var obj:Object = JSON2.decode(e.result);
			if (obj.error == null)
			{
				if (obj.s != null)
				{
					UserStaticData.hero.silver = int(obj.s);
					WinCastle.txtCastle.txtSilver.text = String(obj.s);
				}
				else
				{
					UserStaticData.hero.gold = int(obj.g);
					WinCastle.txtCastle.txtGold.text = String(obj.g);
				}
				var unit:Object = UserStaticData.hero.units[int(WinCastle.currSlotClick)];
				if(this.invPlace == -1)
				{
					unit.it[itemType] = Maker.clone(UserStaticData.magazin_items[UserStaticData.hero.units[int(WinCastle.currSlotClick)].t ][itemType][index] ) ;
					WinCastle.getCastle().slots[int(WinCastle.currSlotClick)].unit.itemUpdate( Slot.getUnitItemsArray(UserStaticData.hero.units[WinCastle.currSlotClick]) )//WinCastle.getCastle().slots[int(WinCastle.currSlotClick)].getUnitItemsArray() );
					WinCastle.getCastle().updateSlots();
					WinCastle.txtCastle.scroll.visible = false;
				}
				else
				{
					unit.inv[invPlace] = Maker.clone(UserStaticData.magazin_items[UserStaticData.hero.units[int(WinCastle.currSlotClick)].t ][itemType][index]);
					WinCastle.inventar.updateInv(this.invPlace, UserStaticData.hero.units[WinCastle.currSlotClick]);
				}
				 
				 
				 App.lock.frees();
				 App.sound.playSound('gold', App.sound.onVoice, 1);
			}
			else
			{
				App.lock.init('Error: '+obj.error)
				Report.addMassage('bye unit error: error num ' + obj.error);
			}
			// unlock crab
		}
		public function frees():void
		{
			App.spr.removeChild(this);
		}
		
	}

}