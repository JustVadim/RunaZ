package artur.win {
	import artur.App;
	import artur.display.BaseButton;
	import artur.display.Chest;
	import artur.display.HeroInventar;
	import artur.display.ItemCall;
	import artur.display.MyBitMap;
	import artur.display.ShopInventar;
	import artur.display.Slot;
	import artur.display.Swaper;
	import artur.display.UnitBlank;
	import artur.display.WinSellExtend;
	import artur.McTextCastleWinExtend;
	import artur.units.UnitCache;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class WinCastle {
		private var bg:MyBitMap;
		private var spr_units:Sprite = new Sprite();
		public var bin:Boolean = false;
		public var slots:Array = [];
		public var swappers:Array = [];
		public var mcCurr:mcCurrSlot = new mcCurrSlot();
		
		
		public static var txtCastle:McTextCastleWinExtend = new McTextCastleWinExtend();
		public static var inventar:HeroInventar
		public static var shopInventar:ShopInventar
		public static var chest:Chest = new Chest();
		public static var mcSell:WinSellExtend = new WinSellExtend();
		public static var currSlotClick:String;
		public static var inst:WinCastle;
		
		public function WinCastle() {
			WinCastle.inst = this;
			WinCastle.mcSell.gotoAndStop(1); 
			WinCastle.mcSell.name = 'sell';
			WinCastle.mcSell.mouseChildren = false;
			WinCastle.inventar = new HeroInventar();
			WinCastle.shopInventar = new ShopInventar();
			WinCastle.txtCastle.scroll.source = this.spr_units;
			this.mcCurr.x = -7;
			this.bg = new MyBitMap(App.prepare.cach[7]);
			for (var i:int = 0; i < 4; i++) {
				this.slots.push(new Slot(i));
				this.swappers.push(new Swaper(i));
			}
			for (var key:Object in UserStaticData.magaz_units) {
				var blank:UnitBlank = new UnitBlank(int(key), Slot.namesUnit[key], UserStaticData.magaz_units[key]);
				blank.y = int(key) * 148;
				blank.init();
				this.spr_units.addChild(blank);
			}
			WinCastle.txtCastle.scroll.update();
		}
		
		private function outSell(e:MouseEvent):void {
			e.currentTarget.gotoAndStop(1);
		}
		
		private function overSell(e:MouseEvent):void {
			e.currentTarget.gotoAndStop(2);
		}
		
		public function init():void {
			App.spr.addChild(bg);
			App.spr.addChild(txtCastle);
			WinCastle.chest.init();
			for (var i:int = 0; i < slots.length; i++) {
				Slot(slots[i]).init();
				Swaper(swappers[i]).init();
				if(UserStaticData.hero.units[i] != null && this.mcCurr.parent == null) {
					this.selectSlot(i);
				}
			}
			if(this.mcCurr.parent == null) {
				this.selectSlot(0);
			}
			App.topMenu.updateGold();
			App.topMenu.init(false, true, false);
			App.topPanel.init(this);
			if(UserStaticData.hero.demo == 0) {
				App.tutor.init(2);
			} else if(UserStaticData.hero.demo == 1) {
				App.tutor.init(4);
			}
			
		}
		
		public function selectSlot(i:int, anim:Boolean = true):void {
			if(UserStaticData.hero.units[i] == null) {
				if(WinCastle.inventar.parent) {
					WinCastle.inventar.frees1();
				}
				WinCastle.txtCastle.scroll.visible = true;
			} else {
				WinCastle.inventar.frees1();
				WinCastle.txtCastle.scroll.visible = false;
				WinCastle.currSlotClick = String(i);
				WinCastle.inventar.init1(UserStaticData.hero.units[i], anim);
			}
			Slot(this.slots[i]).addChildAt(this.mcCurr, 1);
		}
		
		public function updateSlots():void {
			for (var i:int = 0; i < slots.length; i++) {
				Slot(slots[i]).init();
			}
		
		}
		
		public function update():void {
			
		}
		
		public function frees():void {
			for (var i:int = 0; i < slots.length; i++) {
				slots[i].frees();
			}
			WinCastle.inventar.frees1();
			WinCastle.chest.frees();
		}
		
		public static function getCastle():WinCastle {
			return inst;
		}
		
		public static function isMoney(gold:int, silver:int):Boolean {
			if (gold <= UserStaticData.hero.gold || silver <= UserStaticData.hero.silver) {
				return true;
			} else {
				return false;
			}
		}
		
		public static function isGold(gold:int):Boolean {
			return gold <= UserStaticData.hero.gold;
		}
		
		public static function isSilver(gold:int):Boolean {
			return gold <= UserStaticData.hero.silver;
		}
		
		public function updateSwapSlots(sd:Object):void {
			Slot(this.slots[sd.t]).init();
			Slot(this.slots[sd.f]).init();
		}
	}

}