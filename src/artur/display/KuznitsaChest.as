package artur.display {
	import adobe.utils.CustomActions;
	import artur.App;
	import artur.win.WinKyz;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.PerspectiveProjection;
	import report.Report;
	import Utils.Functions;
	public class KuznitsaChest extends Sprite {
		
		private const wd:int = 5;
		private const hg:int  = 8;
		private var grid:Array = new Array();
		private var items:Array = new Array();
		
		private const crafterWD:int = 5;
		private const crafterHG:int = 3;
		private var craftGrid:Array = new Array();
		private var selectedItem:ItemCall;
		private var stonesArray:Array = new Array();
		private var stonesObj:Object = new Object();
		
		
		
		
		
		public function KuznitsaChest() {
			this.name = "KuzChest"
			Functions.SetPriteAtributs(this, false, true);
			var yp:int;
			var xp:int;
			var pos:int;
			var mc:MovieClip;
			for (yp = 0; yp < this.hg; yp++) {
				for (xp = 0; xp < this.wd; xp++) {
					pos = yp * this.wd + xp;
					mc = new mcCall();
					Functions.SetPriteAtributs(mc, false, true, xp * mc.width, yp * mc.width);
					mc.gotoAndStop(1);
					this.grid[pos] = mc;
					this.addChild(mc);
				}
			}
			
			for (xp = 0; xp < this.crafterWD; xp++ ){
				for (yp = 0; yp < this.crafterHG; yp++ ) {
					pos = xp * this.crafterHG + yp;
					mc = new mcCall();
					Functions.SetPriteAtributs(mc, false, true, -260 + xp * mc.width, yp * mc.width);
					mc.gotoAndStop(1);
					this.craftGrid[pos] = mc;
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
							item_call.addEventListener(MouseEvent.ROLL_OVER, item_call.over);
							item_call.addEventListener(MouseEvent.ROLL_OUT, item_call.out);
							item_call.addEventListener(MouseEvent.MOUSE_DOWN, this.onItemInChestMouserDown);
							this.addChild(item_call);
							items.push(item_call);
						}
						break;
				}
				
			}
			App.spr.addChild(this);
		}
		
		private function onItemInChestMouserDown(e:MouseEvent):void {
			/*var chest:Object = UserStaticData.hero.chest;
			var key:String = ItemCall(e.target).name;
			if (chest[key].c[103] != 7) {
				this.removeSelectedItem(); 
				ItemCall(e.target).alpha = 0.6;
				this.selectedItem = ItemCall.getCall();
				this.selectedItem.init(chest[key].c[102], chest[key].c[103], chest[key].id);
				this.selectedItem.x = mcCall(craftGrid[0]).x;
				this.selectedItem.y = mcCall(craftGrid[0]).y;
				this.selectedItem.name = key;
				
				//show info, and frees info
				//this.selectedItem.addEventListener(MouseEvent.ROLL_OVER, selectedItem.over);
				//this.selectedItem.addEventListener(MouseEvent.ROLL_OUT, selectedItem.out);
				this.selectedItem.addEventListener(MouseEvent.MOUSE_DOWN, this.onCraftClick);
				App.info.frees();
				this.addChild(selectedItem);
			} else {
				//dialog
			}*/
		}
		
		private function onCraftClick(e:MouseEvent):void {
			App.info.frees();
			this.removeSelectedItem();
		}
		
		private function removeSelectedItem():void {
			if (this.selectedItem != null) {
				this.selectedItem.removeEventListener(MouseEvent.ROLL_OVER, selectedItem.over);
				this.selectedItem.removeEventListener(MouseEvent.ROLL_OUT, selectedItem.out);
				this.selectedItem.removeEventListener(MouseEvent.MOUSE_DOWN, this.onCraftClick);
				for (var key:Object in items) {
					if(ItemCall(items[key]).name == this.selectedItem.name) {
						ItemCall(items[key]).alpha = 1;
					}
				}
				this.selectedItem.frees();
				this.selectedItem = null;
			}
		}
		
		private function addSelectedItem():void {
			
		}
		
		public function frees():void {
			/*this.removeSelectedItem();
			for (var i:Object in items) {
				ItemCall(items[i]).removeEventListener(MouseEvent.MOUSE_OVER, items[i].over);
				ItemCall(items[i]).removeEventListener(MouseEvent.MOUSE_OUT, items[i].out);
				ItemCall(items[i]).removeEventListener(MouseEvent.MOUSE_DOWN, this.onItemInChestMouserDown);
				ItemCall(items[i]).frees();
				delete(items[i]);
			}
			//this.items = new Array();
			this.cleareStones();*/
			
		}
		
		public function removeCraft():void {
			/*this.removeSelectedItem();
			this.cleareStones();*/
		}
		
		private function cleareStones():void
		{
			for (var key:Object in this.stonesArray) {
				/*KyzStone(this.stonesArray[key]).removeEventListener(MouseEvent.CLICK, this.onStoneClick);
				KyzStone(this.stonesArray[key]).frees();
				KyzStone(this.stonesArray[key]).buttonMode = false;
				delete(this.stonesArray[key]);
				delete(this.stonesObj[key]);*/
			}
		}
		
		public function addSoneToCraft(stoneNum:int):Boolean {
			/*var pos:int = -1;
			for (var i:int = 0; i < 9; i++) {
				if(stonesArray[i]==null) {
					pos = i;
					break;
				}
			}
			if(pos != -1) {
				var stone:KyzStone = KyzStone.getStone(stoneNum + 1);
				stone.addEventListener(MouseEvent.CLICK, this.onStoneClick);
				stone.buttonMode = true;
				stonesArray[pos] = stone;
				mcCall(this.craftGrid[6 + pos]).addChild(stone);
				this.stonesObj[pos] = stoneNum;
				return true;
			} else {
				return false;
			}*/
			return false;
		}
		
		private function onStoneClick(e:MouseEvent):void {
			/*var stone:KyzStone = KyzStone(e.target);
			this.removeStoneFromCraft(stone.getId());*/
		}
		
		public function removeStoneFromCraft(stoneNum:int):void {
			/*var key:Object;
			for(key in stonesObj) {
				if(this.stonesObj[key] == stoneNum) {
					break;
				}
			}
			if (key != null) {
				var stone:KyzStone = KyzStone(stonesArray[key]);
				stone.removeEventListener(MouseEvent.CLICK, this.onStoneClick);
				stone.buttonMode = false;
				KyzStone(stonesArray[key]).frees();
				delete(stonesArray[key]);
				delete(stonesObj[key]);
				WinKyz.inst.turnStoneBtn(stoneNum);
				App.sound.playSound("stone", App.sound.onVoice, 1);
			} else {
				App.lock.init("Error!!!!");
			}*/
		}
		
		public function canCraft():Boolean {
			/*if(this.selectedItem !=null) {
				for(var key:Object in this.stonesObj){
					return true;
				}
			} 
			return false;*/
			return false;
		}
		
		public function getCraftObj():Object 
		{
			//return { "in":int(this.selectedItem.name), "gems":this.stonesObj };
			return null;
		}
	}
}