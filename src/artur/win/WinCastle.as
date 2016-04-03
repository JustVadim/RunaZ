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
		public var bin:Boolean = false;
		private var bg:MyBitMap;
		public var slots:Array = [];
		public static var txtCastle:McTextCastleWinExtend = new McTextCastleWinExtend();
		private var spr_units:Sprite = new Sprite();
		public static var currSlotClick:String;
		private static var inst:WinCastle;
		public var mcCurr:mcCurrSlot = new mcCurrSlot();
		public static var inventar:HeroInventar
		public static var shopInventar:ShopInventar
		public static var chest:Chest = new Chest();
		public static var mcSell:WinSellExtend = new WinSellExtend();
		public var swaper:Swaper 
		
		public function WinCastle() {
			mcSell.gotoAndStop(1); 
			mcSell.name = 'sell';
			mcSell.mouseChildren = false;
			inst = this;
			bg = new MyBitMap(App.prepare.cach[7]);
			inventar = new HeroInventar();
			shopInventar = new ShopInventar();
			for (var i:int = 0; i < 4; i++) {
				var slot:Slot = new Slot();
				slot.x = 73.1;
				slot.y = 68.25 + i * 95;
				slot.name = String(i);
				slots.push(slot);
			}
			
			for (var key:Object in UserStaticData.magaz_units) {
				var blank:UnitBlank = new UnitBlank(int(key), Slot.namesUnit[key], UserStaticData.magaz_units[key]);
				blank.y = int(key) * 148;
				blank.init();
				spr_units.addChild(blank);
			}
			txtCastle.scroll.source = spr_units;
			txtCastle.scroll.update();
			swaper = new Swaper();
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
				App.spr.addChildAt(slots[i], 0);
				slots[i].init();
			}
			WinCastle.txtCastle.scroll.visible = false;
			WinCastle.txtCastle.txtGold.text = String(UserStaticData.hero.gold);
			WinCastle.txtCastle.txtSilver.text = String(UserStaticData.hero.silver);
			App.topPanel.init(this);
			if(UserStaticData.hero.demo == 0) {
				App.tutor.init(2);
			} else if(UserStaticData.hero.demo == 1) {
				App.tutor.init(4);
			}
			swaper.init();
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
			WinCastle.inventar.frees();
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
	}

}