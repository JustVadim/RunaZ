package artur.display 
{
	import adobe.utils.CustomActions;
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
	import Utils.Functions;
	import Utils.json.JSON2;
	
	public class Chest extends Sprite {
		public const wd:int = 5;
		public const hg:int  = 8;
		private var grid:Array = new Array();
		private var items:Array = new Array();
		public var upped_item_num:int;
		public var upped_item_id:int;
		private var invP:int = -1;
		public var upped_item_call:ItemCall;
		private var uppedItemObj:Object;
		
		public function Chest() {
			this.name = "chest"
			Functions.SetPriteAtributs(this, false, true);
			for (var yp:int = 0; yp < hg; yp++) {
				for (var xp:int = 0; xp < wd; xp++) {
					var pos:int = yp * wd + xp;
					var mc:MovieClip = new mcCall();
					Functions.SetPriteAtributs(mc, true, false, xp * mc.width, yp * mc.width);
					mc.gotoAndStop(1);
					this.grid[pos] = mc;
					this.addChild(mc);
				}
			}
			this.x = 566; this.y = 73.35;
		}
		
		public function init():void {
			var chest:Object = UserStaticData.hero.chest;
			for(var key:Object in chest) {
				switch(int(chest[key].id)) {
					case 0:
						mcCall(grid[key]).gotoAndStop(1);
						mcCall(grid[key]).name = String(key);
						break;
					case -1:
						mcCall(grid[key]).gotoAndStop(3);
						mcCall(grid[key]).name = String(key);
						break;
					default:
						mcCall(grid[key]).gotoAndStop(1);
						mcCall(grid[key]).name = String(key);
						if (chest[key].id > 0) {
							var item_call:ItemCall = ItemCall.getCall();
							item_call.init(chest[key].c[102], chest[key].c[103], chest[key].id);
							item_call.x = mcCall(grid[key]).x;
							item_call.y = mcCall(grid[key]).y;
							item_call.name = String(key);
							item_call.addEventListener(MouseEvent.MOUSE_DOWN, this.onItemInChestMouserDown);
							item_call.addEventListener(MouseEvent.ROLL_OVER, item_call.over);
							item_call.addEventListener(MouseEvent.ROLL_OUT, item_call.out);
							this.addChild(item_call);
							items.push(item_call);
						}
						break;
				}
				
			}
			App.spr.addChild(this);
		}
		
		private function onItemInChestMouserDown(e:MouseEvent):void {
			Mouse.hide();
			App.spr.addChild(WinCastle.mcSell);
			WinCastle.mcSell.gotoAndPlay(1);
			WinCastle.mcSell.addEventListener(MouseEvent.ROLL_OVER, this.onItemSellOver);
			WinCastle.mcSell.addEventListener(MouseEvent.ROLL_OUT, this.onItemSellOut);
			this.upped_item_call = ItemCall(e.currentTarget);
			this.upped_item_num = int(upped_item_call.name);
			this.upped_item_id = UserStaticData.hero.chest[upped_item_num].id;
			this.initPutItemEvents(UserStaticData.hero.chest[upped_item_num]);
			WinCastle.inventar.enabledAllEvents(false);
			WinCastle.inventar.showGreenInv(this.uppedItemObj);
			var cell_y:int = upped_item_num / this.wd;
			var cell_x:int = upped_item_num - cell_y * this.wd;
			for (var i:int = 0; i < UserStaticData.hero.chest[upped_item_num].c[105]; i++) {
				for (var j:int = 0; j < UserStaticData.hero.chest[upped_item_num].c[104]; j++) {
					var num:int = cell_x + j + ((cell_y + i) * this.wd);
					UserStaticData.hero.chest[num].id = 0;
				}
			}
			this.upped_item_call.x = Main.THIS.stage.mouseX - this.upped_item_call.width / 2 + 8;
			this.upped_item_call.y = Main.THIS.stage.mouseY - this.upped_item_call.height / 2 + 8;
			Main.THIS.stage.addChild(this.upped_item_call);
			Main.THIS.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onDragMove);
			Main.THIS.stage.addEventListener(Event.MOUSE_LEAVE, this.onUppedItemMouseLeave);
			Main.THIS.stage.addEventListener(MouseEvent.MOUSE_UP, this.onItemUp);
		}
		
		private function onItemSellOut(e:MouseEvent):void 
		{
			WinCastle.mcSell.sellSprite.gotoAndStop(1);
		}
		
		private function onItemSellOver(e:MouseEvent):void 
		{
			WinCastle.mcSell.sellSprite.gotoAndStop(2);
		}
		
		private function onItemUp(e:MouseEvent):void 
		{
			if (e.target is mcCall) {
				var mcC:mcCall = mcCall(e.target);
				var itemNum:int = int(mcC.name);
				if (this.upped_item_num != itemNum &&  this.isFreeCells(itemNum)) {
					this.afterPut();
					//
					App.lock.init();
					var data:DataExchange = new DataExchange();
					data.addEventListener(DataExchangeEvent.ON_RESULT, this.onFromChestToChestRes);
					var send_obj:Object = {cn:itemNum,un:this.upped_item_num,it:0};
					data.sendData(COMMANDS.FROM_CHEST_TO_CHEST, JSON2.encode(send_obj), true);	
				} else {
					this.onUppedItemMouseLeave(e);
				}
			} else if (e.target.name == "sell") {
				Mouse.show();
					this.afterPut();
					App.byeWin.init("Я хочу продать", "эту хрень", 0, int(this.uppedItemObj.c[100]/2) ,NaN,2,NaN);
			} else if("yRect" in e.target) {
				var mc:MovieClip = MovieClip(e.target);
				if (mc.yRect.visible) {
					this.afterPut();
					App.lock.init();
					this.invP = WinCastle.inventar.getIsInv(mc);
					var data1:DataExchange = new DataExchange();
					data1.addEventListener(DataExchangeEvent.ON_RESULT, this.fromChestToUnitRes);
					var send_obj1:Object = { cn:upped_item_num, un:int(WinCastle.currSlotClick), it:0, invP:this.invP };
					data1.sendData(COMMANDS.FROM_CHEST_TO_UNIT, JSON2.encode(send_obj1), true);
				} else {
					this.onUppedItemMouseLeave(e);
				}
			} else {
				this.onUppedItemMouseLeave(e);
			}
		}
		
		private function onUppedItemMouseLeave(e:Event):void {
			this.afterPut();
			this.putItemOnOldPlace();
		}
		
		private function afterPut():void 
		{
			Mouse.show();
			if(WinCastle.mcSell.stage) {
				App.spr.removeChild(WinCastle.mcSell);
			}
			WinCastle.mcSell.removeEventListener(MouseEvent.ROLL_OVER, this.onItemSellOver);
			WinCastle.mcSell.removeEventListener(MouseEvent.ROLL_OUT, this.onItemSellOut);
			this.upped_item_call.removeEventListener(MouseEvent.MOUSE_DOWN, this.onItemInChestMouserDown);
			this.upped_item_call.removeEventListener(MouseEvent.MOUSE_OVER, this.upped_item_call.over);
			this.upped_item_call.removeEventListener(MouseEvent.MOUSE_OUT, this.upped_item_call.out);
			this.upped_item_call.parent.removeChild(this.upped_item_call);
			this.upped_item_call.frees();
			this.removeFromArray(this.upped_item_call);
			Main.THIS.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onDragMove);
			Main.THIS.stage.removeEventListener(Event.MOUSE_LEAVE, this.onUppedItemMouseLeave);
			Main.THIS.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onItemUp);
			this.removePutEvents();
			WinCastle.inventar.enabledAllEvents(true);
			WinCastle.inventar.hideGreenInv(this.uppedItemObj);
		}
		
		private function removeFromArray(upped_item_call:ItemCall):void {
			for (var i:int = 0; i < items.length; i++) {
				if(this.items[i] == this.upped_item_call) {
					this.items.splice(i, 1);
				}
			}
		}
		
		
		
		public function initPutItemEvents(item:Object):void {
			Report.addMassage(JSON2.encode(item));
			this.uppedItemObj = item;
			for (var i:int = 0; i < items.length; i++) {
				ItemCall(items[i]).mouseEnabled = false;
			}
			for (i = 0; i < this.grid.length; i++ ) {
				var mcC:mcCall = this.grid[i];
				mcC.addEventListener(MouseEvent.ROLL_OVER, this.onPutOver);
				mcC.addEventListener(MouseEvent.ROLL_OUT, this.onPutOut);
			}
		}
		
		private function onPutOut(e:MouseEvent):void 
		{
			for (var i:int = 0; i < this.grid.length; i++ ) {
				var mcC:mcCall = this.grid[i];
				if(mcC.currentFrame!=1) {
					mcC.gotoAndStop(1);
				}
			}
		}
		
		private function onPutOver(e:MouseEvent):void {
			var mcC:mcCall = mcCall(e.currentTarget);
			var cellNum:int = int(mcC.name);
			var cell_y:int = cellNum / this.wd;
			var cell_x:int = cellNum - cell_y * this.wd;
			var i:int;
			var j:int;
			var num:int
			if(this.isFreeCells(-1, cell_x, cell_y)) {
				for (i = 0; i < this.uppedItemObj.c[105]; i++) {
					for (j = 0; j < this.uppedItemObj.c[104]; j++) {
						num = cell_x + j + ((cell_y + i) * this.wd);
						mcCall(grid[num]).gotoAndStop(2);
					}
				}
			} else {
				for (i = 0; i < this.uppedItemObj.c[105]; i++) {
					for (j = 0; j < this.uppedItemObj.c[104]; j++) {
						if((cell_x + j < this.wd) && (cell_y + i < this.hg)) {
							num = cell_x + j + ((cell_y + i) * this.wd);
							mcCall(grid[num]).gotoAndStop(3);
						}
					}
				}
			}
			
		}
		
		
		public function isFreeCells(num:int = -1, xx:int = 0, yy:int = 0):Boolean {
			Report.addMassage(JSON2.encode(this.uppedItemObj));
			if(num != -1) {
				yy = num / this.wd;
				xx = num - yy * this.wd;
			}
			var ww:int = this.uppedItemObj.c[104];
			var hh:int = this.uppedItemObj.c[105];
			if ((xx + ww <= this.wd) && (yy + hh) <= this.hg) {
				for (var i:int = 0; i < hh; i++) {
					for (var j:int = 0; j < ww; j++) {
						var num:int = xx + j + ((yy + i) * this.wd);
						if (UserStaticData.hero.chest[num].id != 0) {
							return false;
						}
					}
				}
				return true;
			}
			else {return false;}
		}
		
		public function removePutEvents():void 
		{
			for (var i:int = 0; i < items.length; i++) {
				ItemCall(items[i]).mouseEnabled = true;
			}
			for (i = 0; i < this.grid.length; i++ ) {
				var mcC:mcCall = this.grid[i];
				mcC.removeEventListener(MouseEvent.ROLL_OVER, this.onPutOver);
				mcC.removeEventListener(MouseEvent.ROLL_OUT, this.onPutOut);
				mcC.gotoAndStop(1);
			}
		}
		
		public function frees():void {
			for (var i:Object in items) {
				ItemCall(items[i]).removeEventListener(MouseEvent.MOUSE_DOWN, this.onItemInChestMouserDown);
				ItemCall(items[i]).removeEventListener(MouseEvent.MOUSE_OVER, items[i].over);
				ItemCall(items[i]).removeEventListener(MouseEvent.MOUSE_OUT, items[i].out);
				ItemCall(items[i]).frees();
				delete(items[i]);
			}
			this.items = new Array();
		}
		
		private function onDragMove(e:MouseEvent):void 
		{
			upped_item_call.x = Main.THIS.stage.mouseX - upped_item_call.width/2 +8;
			upped_item_call.y = Main.THIS.stage.mouseY - upped_item_call.height/2 +8;
		}
		
		public function putItemOnOldPlace():void {
			App.sound.playSound(ItemCall.sounds[UserStaticData.hero.chest[this.upped_item_num].c[103]][this.upped_item_id - 1], App.sound.onVoice, 1 );
			var cell_y:int = upped_item_num / this.wd;
			var cell_x:int = upped_item_num - cell_y * this.wd;
			for (var i:int = 0; i < this.uppedItemObj.c[105]; i++) {
				for (var j:int = 0; j < this.uppedItemObj.c[104]; j++) {
					var num:int = cell_x + j + ((cell_y + i) * this.wd);
					UserStaticData.hero.chest[num].id = -2;
				}
			}
			UserStaticData.hero.chest[upped_item_num].id = this.upped_item_id;
			this.upped_item_call.init( -1, -1, -1);
			this.upped_item_call.free = false;
			this.upped_item_call.x = grid[upped_item_num].x;
			this.upped_item_call.y = grid[upped_item_num].y;
			this.upped_item_call.addEventListener(MouseEvent.MOUSE_DOWN, this.onItemInChestMouserDown);
			this.upped_item_call.addEventListener(MouseEvent.MOUSE_OVER, this.upped_item_call.over);
			this.upped_item_call.addEventListener(MouseEvent.MOUSE_OUT, this.upped_item_call.out);
			this.upped_item_call.mouseEnabled = true;
			this.items.push(this.upped_item_call);
			this.addChild(this.upped_item_call);
		}
		
		private function onFromChestToChestRes(e:DataExchangeEvent):void {
			DataExchange(e.currentTarget).removeEventListener(e.type, onFromChestToChestRes);
			var obj:Object = JSON2.decode(e.result);
			if (!obj.error)
			{
				App.sound.playSound(ItemCall.sounds[UserStaticData.hero.chest[this.upped_item_num].c[103]][this.upped_item_id-1],App.sound.onVoice,1 );
				UserStaticData.hero.chest = obj.res;
				delete(obj.ch);
				this.frees();
				this.init();
				App.lock.frees();
			}
			else
			{
				App.lock.init('Error: ' + obj.error);
				this.putItemOnOldPlace();
			}
		}
		
		public function sellItem():void {
			App.lock.init();
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, this.chestSell);
			var send_obj:Object = {cn:upped_item_num};
			data.sendData(COMMANDS.SELL_ITEM_CHEST, upped_item_num.toString(), true);
		}
		
		private function chestSell(e:DataExchangeEvent):void {
			DataExchange(e.currentTarget).removeEventListener(e.type, chestSell);
			var obj:Object = JSON2.decode(e.result);
			if (!obj.error) {
				UserStaticData.hero.silver = obj.s;
				WinCastle.txtCastle.txtSilver.text = String(obj.s);
				var ww:int = this.uppedItemObj.c[104];
				var hh:int = this.uppedItemObj.c[105];
				var cell_y:int = upped_item_num / this.wd;
				var cell_x:int = upped_item_num - cell_y * this.wd;
				for (var i:int = 0; i < hh; i++) {
					for (var j:int = 0; j < ww; j++) {
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
			} else {
				App.lock.init('Error: '+obj.error)
				this.putItemOnOldPlace();
			}
		}
		
		private function fromChestToUnitRes(e:DataExchangeEvent):void 
		{
			DataExchange(e.currentTarget).removeEventListener(e.type, fromChestToUnitRes);
			var obj:Object = JSON2.decode(e.result);
			if (!obj.error) {
				App.sound.playSound(ItemCall.sounds[UserStaticData.hero.chest[this.upped_item_num].c[103]][this.upped_item_id-1],App.sound.onVoice,1 );
				var item:Object = UserStaticData.hero.chest[upped_item_num];
				item.id = upped_item_id;
				UserStaticData.hero.chest[upped_item_num] = { id:0 };
				var unit:Object = UserStaticData.hero.units[WinCastle.currSlotClick];
				if (this.invP == -1) {
					unit.it[item.c[103]] = item;
					WinCastle.getCastle().slots[int(WinCastle.currSlotClick)].unit.itemUpdate(Slot.getUnitItemsArray(unit));
					WinCastle.inventar.updateItem(item.c[103], item.id);
					WinCastle.inventar.calculateUnitStats(Functions.GetHeroChars(), unit, 1);
				} else {	
					unit.inv[this.invP] = item;
					WinCastle.inventar.updateInv(this.invP, unit);
				}
				this.upped_item_call.frees();
				App.lock.frees();
			}
			else {
				App.lock.init('Error: '+obj.error)
				this.putItemOnOldPlace();
			}
		}
	}
}