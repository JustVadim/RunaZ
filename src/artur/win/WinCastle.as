package artur.win {
	import artur.App;
	import artur.display.BaseButton;
	import artur.display.Chest;
	import artur.display.HeroInventar;
	import artur.display.ItemCall;
	import artur.display.MyBitMap;
	import artur.display.ShopInventar;
	import artur.display.Slot;
	import artur.display.UnitBlank;
	import artur.units.UnitCache;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class WinCastle {
		private var bg:MyBitMap
		public var bin:Boolean = false;
		public var slots:Array = [];
		public static var txtCastle:mcTextCastleWin = new mcTextCastleWin();
		private var spr_units:Sprite = new Sprite();
		public static var currSlotClick:String;
		private static var inst:WinCastle;
		public var mcCurr:mcCurrSlot = new mcCurrSlot();
		public static var inventar:HeroInventar
		public static var shopInventar:ShopInventar
		public static var chest:Chest = new Chest();
		public static var mcSell:WinSell = new WinSell();
		
		
		public function WinCastle() {
			mcSell.gotoAndStop(1); 
			mcSell.name = 'sell';
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
			chest.init();
			for (var i:int = 0; i < slots.length; i++) {
				App.spr.addChildAt(slots[i], 0);
				slots[i].init();
			}
			txtCastle.scroll.visible = false;
			txtCastle.txtGold.text = String(UserStaticData.hero.gold);
			txtCastle.txtSilver.text = String(UserStaticData.hero.silver);
		}
		
		public function updateSlots():void {
			for (var i:int = 0; i < slots.length; i++) {
				slots[i].init();
			}
		
		}
		
		public function update():void {
			App.spr.addChild(App.btnRoot);
		}
		
		public function frees():void {
			for (var i:int = 0; i < slots.length; i++) {
				slots[i].frees();
			}
			inventar.frees();
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