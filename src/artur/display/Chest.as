package artur.display 
{
	import artur.App;
	import artur.win.WinCastle;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import report.Report;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Utils.json.JSON2;
	
	public class Chest extends Sprite
	{
		public var  wd:int = 5;
		public var  hg:int  = 8;
		public var grid:Array = [];
		public var cleared:Boolean = true;
		public var items:Array = [];
		public var upped_item_num:int;
		public var upped_item_id:int;
		public var upped_item_call:ItemCall;
		private var invP:int = -1;
		
		public function Chest() 
		{
			this.name = "chest"
			for (var yp:int = 0; yp < hg; yp++) 
			{
				for (var xp:int = 0; xp < wd; xp++) 
				{
					var pos:int = yp * wd + xp;
					var mc:MovieClip = new mcCall();
					grid[pos] = mc;
					mc.x = xp * mc.width;
					mc.y = yp * mc.width;
					mc.gotoAndStop(1);
					this.addChild(mc);
				}
			}
			this.x = 566; this.y = 73.35;
		}
		
		public function init():void
		{
			for (var obj:Object in UserStaticData.hero.chest)
			{
				if (UserStaticData.hero.chest[obj].id == 0)
				{
					mcCall(grid[obj]).gotoAndStop(1);
					mcCall(grid[obj]).name = "celll" + JSON2.encode( { n:obj, s:String('f') } )
				}
				else if (UserStaticData.hero.chest[obj].id == -1)
				{
					mcCall(grid[obj]).gotoAndStop(3);
					mcCall(grid[obj]).name = "celll" + JSON2.encode( { n:obj, s:String('c') } )
				}
				else
				{
					mcCall(grid[obj]).gotoAndStop(1);
					mcCall(grid[obj]).name = "celll" + JSON2.encode( { n:obj, s:String('c') } )
					if (UserStaticData.hero.chest[obj].id > 0)
					{
						var item_call:ItemCall = ItemCall.getCall();
						item_call.init(UserStaticData.hero.chest[obj].c[102], UserStaticData.hero.chest[obj].c[103], UserStaticData.hero.chest[obj].id);
						item_call.x = mcCall(grid[obj]).x;
						item_call.y = mcCall(grid[obj]).y;
						item_call.buttonMode = true;
						item_call.mouseChildren = false;
						item_call.name = String(obj);
						item_call.addEventListener(MouseEvent.MOUSE_DOWN, this.onItemInChestMouserDown);
						item_call.addEventListener(MouseEvent.MOUSE_OVER, item_call.over);
						item_call.addEventListener(MouseEvent.MOUSE_OUT, item_call.out);
						this.addChild(item_call);
						items.push(item_call);
					}
				}
			}
			App.spr.addChild(this);
		}
		
		private function onItemInChestMouserDown(e:MouseEvent):void 
		{
			Mouse.hide();
			App.spr.addChild(WinCastle.mcSell); WinCastle.mcSell.gotoAndPlay(1);
			
			
			upped_item_call = ItemCall(e.currentTarget);
			upped_item_call.removeEventListener(MouseEvent.MOUSE_OVER, upped_item_call.over);
			upped_item_call.removeEventListener(MouseEvent.MOUSE_OUT, upped_item_call.out);
			App.info.frees();
			this.upped_item_num = int(upped_item_call.name);
			this.upped_item_id = UserStaticData.hero.chest[upped_item_num].id;
			var cell_y:int = upped_item_num / this.wd;
			var cell_x:int = upped_item_num - cell_y * this.wd;
			for (var i:int = 0; i < UserStaticData.hero.chest[upped_item_num].c[105]; i++) 
			{
				for (var j:int = 0; j < UserStaticData.hero.chest[upped_item_num].c[104]; j++)
				{
					var num:int = cell_x + j + ((cell_y + i) * this.wd);
					UserStaticData.hero.chest[num].id = 0;
				}
			}
			upped_item_call.x = Main.THIS.stage.mouseX - upped_item_call.width/2 +8;
			upped_item_call.y = Main.THIS.stage.mouseY - upped_item_call.height/2 +8;
			upped_item_call.startDrag();
			upped_item_call.addEventListener(MouseEvent.MOUSE_UP, this.onUppedItemUp);
			upped_item_call.addEventListener(MouseEvent.MOUSE_MOVE, this.onUppedItemMove);
			Main.THIS.stage.addEventListener(Event.MOUSE_LEAVE, onUppedItemMouseLeave);
			Main.THIS.stage.addChild(upped_item_call);
			this.onUppedItemMove(null);
		}
		
		private function onUppedItemOut(e:MouseEvent):void 
		{
			upped_item_call.stopDrag();
			upped_item_call.removeEventListener(MouseEvent.MOUSE_UP, this.onUppedItemUp);
			upped_item_call.removeEventListener(MouseEvent.MOUSE_MOVE, this.onUppedItemMove);
			Main.THIS.stage.removeEventListener(Event.MOUSE_LEAVE, onUppedItemMouseLeave);
			this.putItemOnOldPlace(upped_item_call);
			this.clearCells();
		}
		
		private function onUppedItemMouseLeave(e:Event):void 
		{
			if (App.spr.contains(WinCastle.mcSell))
			     App.spr.removeChild(WinCastle.mcSell)
			upped_item_call.stopDrag();
			upped_item_call.removeEventListener(MouseEvent.MOUSE_UP, this.onUppedItemUp);
			upped_item_call.removeEventListener(MouseEvent.MOUSE_MOVE, this.onUppedItemMove);
			Main.THIS.stage.removeEventListener(Event.MOUSE_LEAVE, onUppedItemMouseLeave);
			this.putItemOnOldPlace(upped_item_call);
			this.upped_item_call.out();
			this.clearCells();
			this.clearGreenRect();
			WinCastle.inventar.takeAwayGreenYellowRect();
			Mouse.show();
		}
		
		private function onUppedItemMove(e:MouseEvent):void 
		{
			var str:String = "";
			if (e != null)
			{
				e.updateAfterEvent();
				if (e.currentTarget!=null && e.currentTarget.dropTarget != null && e.currentTarget.dropTarget.parent!=null)
				{
					str = (e.currentTarget.dropTarget.parent.name);
				}
			}
			if (str.length >= 5 && str.substr(0, 5) == "celll")
			{
				var obj:Object = JSON2.decode(str.substr(5, str.length - 1));
				clearCells();
				this.selectToPut(obj.n, false, -1);
			}
			else
			{
				if (str == "sellSprite")
				{
					if (WinCastle.mcSell.sellSprite.currentFrame == 1)
						WinCastle.mcSell.sellSprite.gotoAndStop(2);
				}
				else
				{
					if (WinCastle.mcSell.sellSprite.currentFrame == 2)
						WinCastle.mcSell.sellSprite.gotoAndStop(1);
				}
				clearCells();
			}
			
			var item_tt:int = UserStaticData.hero.chest[this.upped_item_num].c[103];
			var unit:Object = UserStaticData.hero.units[WinCastle.currSlotClick];
			if (unit != null)
			{
				if (unit.it[item_tt] == null)
				{
					var mc:MovieClip = null;
					if (str == "yRect" || str == "greenRect")
					{
						if (str == "yRect")
						{
							mc = MovieClip(e.currentTarget.dropTarget.parent.parent);
							if (mc != null)
							{
								mc.yRect.visible = false;
								mc.greenRect.visible = true;
							}
						}
					}
					else
					{
						switch(true)
						{
							case (item_tt < 5):
								mc = MovieClip(WinCastle.inventar.parts[item_tt]);
								break;
							case (item_tt == 5):
								if(UserStaticData.hero.units[WinCastle.currSlotClick].t == UserStaticData.hero.chest[this.upped_item_num].c[102])
									mc = MovieClip(WinCastle.inventar.guns1[WinCastle.inventar.heroType]);
								break;
							case (item_tt == 6):
								if(UserStaticData.hero.units[WinCastle.currSlotClick].t == UserStaticData.hero.chest[this.upped_item_num].c[102])
								mc = MovieClip(WinCastle.inventar.guns2[WinCastle.inventar.heroType]);
								break;
							case (item_tt == 7):
								WinCastle.inventar.lightYellowRectInt();
								break;
						}
						if (mc != null && !mc.yRect.visible)
						{
							mc.yRect.visible = true;
							mc.greenRect.visible = false;
						}
					}	
				}
			}
		}
		
		private function onUppedItemUp(e:MouseEvent):void 
		{
			upped_item_call.stopDrag();
			upped_item_call.out();
			upped_item_call.removeEventListener(MouseEvent.MOUSE_UP, this.onUppedItemUp);
			upped_item_call.removeEventListener(MouseEvent.MOUSE_MOVE, this.onUppedItemMove);
			Main.THIS.stage.removeEventListener(Event.MOUSE_LEAVE, onUppedItemMouseLeave);
			Main.THIS.stage.removeChild(upped_item_call);
			Mouse.show();
			var str:String = "";
			if (e.currentTarget.dropTarget != null && e.currentTarget.dropTarget.parent != null)
				str = (e.currentTarget.dropTarget.parent.name);
			if (str.length >= 5 && str.substr(0, 5) == "celll")
			{
				var obj:Object = JSON2.decode(str.substr(5, str.length - 1));
				if (upped_item_num == obj.n)
				{
					this.putItemOnOldPlace(upped_item_call);
				}
				else
				{
					var cell_y:int = obj.n / this.wd;
					var cell_x:int = obj.n - cell_y * this.wd;
					
					if (this.isFreeCells(cell_x, cell_y, UserStaticData.hero.chest[this.upped_item_num].c[104], UserStaticData.hero.chest[this.upped_item_num].c[105]))
					{
						App.lock.init();
						var data:DataExchange = new DataExchange();
						data.addEventListener(DataExchangeEvent.ON_RESULT, this.onFromChestToChestRes);
						var send_obj:Object = {cn:obj.n,un:this.upped_item_num,it:0};
						data.sendData(COMMANDS.FROM_CHEST_TO_CHEST, JSON2.encode(send_obj), true);
					}
					else
					{
						this.putItemOnOldPlace(upped_item_call);
					}
				}
			}
			else if(str == "greenRect")
			{
				App.lock.init();
				this.invP = WinCastle.inventar.getIsInv(MovieClip(e.currentTarget.dropTarget.parent.parent));
				var data1:DataExchange = new DataExchange();
				data1.addEventListener(DataExchangeEvent.ON_RESULT, this.fromChestToUnitRes);
				var send_obj1:Object = {cn:upped_item_num, un:int(WinCastle.currSlotClick), it:0, invP:this.invP};
				data1.sendData(COMMANDS.FROM_CHEST_TO_UNIT, JSON2.encode(send_obj1), true);
			}
			else if (str == 'sellSprite')
			{
				App.byeWin.init("Я хочу продать", "эту хрень", 0, int(UserStaticData.hero.chest[this.upped_item_num].c[100]/2) ,NaN,2,NaN);
			}
			else
			{
				this.putItemOnOldPlace(upped_item_call);
			}
			this.clearCells();
			this.clearGreenRect();
			WinCastle.inventar.takeAwayGreenYellowRect();
			if (App.spr.contains(WinCastle.mcSell))
			{
				App.spr.removeChild(WinCastle.mcSell)
				WinCastle.mcSell.sellSprite.gotoAndStop(1);
			}
		}
		public function sellItem():void
		{
			App.lock.init();
			var data1:DataExchange = new DataExchange();
			data1.addEventListener(DataExchangeEvent.ON_RESULT, this.chestSell);
			var send_obj1:Object = {cn:upped_item_num};
			data1.sendData(COMMANDS.SELL_ITEM_CHEST, upped_item_num.toString(), true);
		}
		
		private function chestSell(e:DataExchangeEvent):void 
		{
			DataExchange(e.currentTarget).removeEventListener(e.type, fromChestToUnitRes);
			var obj:Object = JSON2.decode(e.result);
			if (!obj.error)
			{
				UserStaticData.hero.silver = obj.s;
				WinCastle.txtCastle.txtSilver.text = String(obj.s);
				var ww:int = UserStaticData.hero.chest[upped_item_num].c[104];
				var hh:int = UserStaticData.hero.chest[upped_item_num].c[105];
				var cell_y:int = upped_item_num / this.wd;
				var cell_x:int = upped_item_num - cell_y * this.wd;
				for (var i:int = 0; i < hh; i++) 
				{
					for (var j:int = 0; j < ww; j++)
					{
						var num:int = cell_x + j + ((cell_y + i) * this.wd);
						UserStaticData.hero.chest[num].id = 0;
					}
				}
				delete(UserStaticData.hero.chest[upped_item_num]);
				UserStaticData.hero.chest[upped_item_num] = { id:0 };
				WinCastle.chest.frees();
				WinCastle.chest.init();
				App.lock.frees();
				App.sound.playSound('gold', App.sound.onVoice, 1);
			}
			else
			{
				App.lock.init('Error: '+obj.error)
				this.putItemOnOldPlace(upped_item_call);
			}
		}
		
		private function fromChestToUnitRes(e:DataExchangeEvent):void 
		{
			DataExchange(e.currentTarget).removeEventListener(e.type, fromChestToUnitRes);
			var obj:Object = JSON2.decode(e.result);
			if (!obj.error)
			{
				App.sound.playSound(ItemCall.sounds[UserStaticData.hero.chest[this.upped_item_num].c[103]][this.upped_item_id-1],App.sound.onVoice,1 );
				var item:Object = UserStaticData.hero.chest[upped_item_num];
				item.id = upped_item_id;
				UserStaticData.hero.chest[upped_item_num] = { id:0 };
				var unit:Object = UserStaticData.hero.units[WinCastle.currSlotClick];
				if (this.invP == -1)
				{
					unit.it[item.c[103]] = item;
					WinCastle.getCastle().slots[int(WinCastle.currSlotClick)].unit.itemUpdate(  Slot.getUnitItemsArray(unit));
					WinCastle.inventar.init1(unit, false);
				}
				else
				{	
					unit.inv[this.invP] = item;
					WinCastle.inventar.updateInv(0, unit);
					WinCastle.inventar.updateInv(1, unit);
					WinCastle.inventar.updateInv(2, unit);
					WinCastle.inventar.updateInv(3, unit);
				}
				this.frees();
				this.init();
				App.lock.frees();
			}
			else
			{
				App.lock.init('Error: '+obj.error)
				this.putItemOnOldPlace(upped_item_call);
			}
		}
		
		private function clearGreenRect():void 
		{
			var item_t:int = UserStaticData.hero.chest[this.upped_item_num].c[103];
			if (UserStaticData.hero.units[WinCastle.currSlotClick] != null && UserStaticData.hero.units[WinCastle.currSlotClick].it[item_t] == null)
			{
				if (item_t < 5)
				{
					MovieClip(WinCastle.inventar.parts[item_t]).greenRect.visible = false;
					MovieClip(WinCastle.inventar.parts[item_t]).yRect.visible = false;
				}
				else
				{
					switch(item_t)
					{
						case 5:	
							MovieClip(WinCastle.inventar.guns1[WinCastle.inventar.heroType]).greenRect.visible = false;
							MovieClip(WinCastle.inventar.guns1[WinCastle.inventar.heroType]).yRect.visible = false;
							break;
						case 6:
							MovieClip(WinCastle.inventar.guns2[WinCastle.inventar.heroType]).greenRect.visible = false;
							MovieClip(WinCastle.inventar.guns2[WinCastle.inventar.heroType]).yRect.visible = false;
							break;
					}
				}
			}
		}
		
		private function onFromChestToChestRes(e:DataExchangeEvent):void 	
		{
			DataExchange(e.currentTarget).removeEventListener(e.type, onFromChestToChestRes);
			var obj:Object = JSON2.decode(e.result);
			if (!obj.error)
			{
				App.sound.playSound(ItemCall.sounds[UserStaticData.hero.chest[this.upped_item_num].c[103]][this.upped_item_id-1],App.sound.onVoice,1 );
				UserStaticData.hero.chest = obj.res;
				delete(obj.ch);
				WinCastle.chest.frees();
				WinCastle.chest.init();
				App.lock.frees();
				if (UserStaticData.hero.units[int(WinCastle.currSlotClick)] != null)
				{
					WinCastle.getCastle().slots[int(WinCastle.currSlotClick)].unit.itemUpdate(  Slot.getUnitItemsArray(UserStaticData.hero.units[WinCastle.currSlotClick]));
				}
			}
			else
			{
				App.lock.init('Error: ' + obj.error);
				this.putItemOnOldPlace(ItemCall(this.grid[this.upped_item_num]));
			}
		}
		
		public function putItemOnOldPlace(ic:ItemCall):void
		{
			App.sound.playSound(ItemCall.sounds[UserStaticData.hero.chest[this.upped_item_num].c[103]][this.upped_item_id-1],App.sound.onVoice,1 );
			var cell_y:int = upped_item_num / this.wd;
			var cell_x:int = upped_item_num - cell_y * this.wd;
			for (var i:int = 0; i < UserStaticData.hero.chest[upped_item_num].c[105]; i++) 
			{
				for (var j:int = 0; j < UserStaticData.hero.chest[upped_item_num].c[104]; j++)
				{
					var num:int = cell_x + j + ((cell_y + i) * this.wd);
					UserStaticData.hero.chest[num].id = -2;
				}
			}
			UserStaticData.hero.chest[upped_item_num].id = this.upped_item_id;
			ic.addEventListener(MouseEvent.MOUSE_OVER, ic.over);
			ic.addEventListener(MouseEvent.MOUSE_OUT, ic.out);
			this.addChild(ic);
			ic.x = grid[upped_item_num].x;
			ic.y = grid[upped_item_num].y;
			
		}
		
		public function frees():void
		{
			for (var i:Object in items) 
			{
				ItemCall(items[i]).removeEventListener(MouseEvent.MOUSE_DOWN, this.onItemInChestMouserDown);
				ItemCall(items[i]).removeEventListener(MouseEvent.MOUSE_OVER, items[i].over);
				ItemCall(items[i]).removeEventListener(MouseEvent.MOUSE_OUT, items[i].out);
				ItemCall(items[i]).removeEventListener(MouseEvent.MOUSE_OUT, items[i].out);
				ItemCall(items[i]).frees();
				delete(items[i]);
			}
		}
		
		public function clearCells():void
		{
			if(!cleared)
			{
				for (var i:int = 0; i < grid.length; i++) 
				{
					if (UserStaticData.hero.chest[i].id >= 0 || UserStaticData.hero.chest[i].id == -2)
					{
						if (mcCall(grid[i]).currentFrame != 1)
						{
							mcCall(grid[i]).gotoAndStop(1);
						}
					}
				}
				cleared = true;
			}
		}
		
		public function selectToPut(indexTopCall:int, is_hero:Boolean, invPlace:int):void
		{
			var cell_id:int = UserStaticData.hero.chest[indexTopCall].id;
			if ( cell_id == 0)
			{
				var cell_y:int = indexTopCall / this.wd;
				var cell_x:int = indexTopCall - cell_y * this.wd;
				var item:Object;
				if (is_hero) 
				{
					if(invPlace == -1)
						item = UserStaticData.hero.units[WinCastle.currSlotClick].it[WinCastle.inventar.itemType];
					else
						item = UserStaticData.hero.units[WinCastle.currSlotClick].inv[invPlace];
				}
				else {item = UserStaticData.hero.chest[this.upped_item_num];}
				if (this.isFreeCells(cell_x, cell_y, item.c[104], item.c[105]))
				{
					mcCall(grid[indexTopCall]).gotoAndStop(2);
					for (var i:int = 0; i < item.c[105]; i++) 
					{
						for (var j:int = 0; j < item.c[104]; j++)
						{
							var num:int = cell_x + j + ((cell_y + i) * this.wd);
							mcCall(grid[num]).gotoAndStop(2);
						}
					}
				}
				else {mcCall(grid[indexTopCall]).gotoAndStop(3);}
			}
			this.cleared = false;
		}
		
		public function isFreeCells(xx:int, yy:int, ww:int, hh:int):Boolean 
		{
			if ((xx + ww <= this.wd) && (yy + hh) <= this.hg)
			{
				for (var i:int = 0; i < hh; i++) 
				{
					for (var j:int = 0; j < ww; j++)
					{
						var num:int = xx + j + ((yy + i) * this.wd);
						if (UserStaticData.hero.chest[num].id != 0)
							return false;
					}
				}
				return true;
			}
			else {return false;}
		}
		
	}
}