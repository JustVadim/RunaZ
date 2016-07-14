package artur.display {
	import Utils.Functions;
	import artur.App;
	import artur.units.UnitCache;
	import artur.win.WinCastle;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import report.Report;
	import Server.Lang;
	
	public class Slot extends Sprite {
		public var btnByeUnit:BaseButton;
		public var unit:Object;
		public var bg:slotBg = new slotBg();
		public var lvl_star:LvlStar = new LvlStar();
		public static var namesUnit:Object = new Object();
		namesUnit[0] = 'Barbarian';
		namesUnit[1] = 'Paladin';
		namesUnit[2] = 'Lyk';
		namesUnit[3] = 'Mag'
		
		namesUnit[100] = 'Bot1';1
		namesUnit[101] = 'Bot2';
		namesUnit[102] = 'BotGolem';
		namesUnit[103] = 'LykBot';
		namesUnit[104] = 'BotGhost';
		namesUnit[105] = 'BotGhost2';
		namesUnit[106] = 'BotTroll';
		namesUnit[107] = 'BotMag';
		
		public function Slot(i:int) {
			this.tabEnabled = false;
			this.tabChildren = false;
			Functions.SetPriteAtributs(this, true, false, 73.1, 68.25 + i * 95);
			this.name = String(i);
			btnByeUnit = new BaseButton(8, 0.9, 5, 'click1', 'over1', 0x000000);
			this.addEventListener(MouseEvent.CLICK, onSlotClick);
			this.addEventListener(MouseEvent.ROLL_OVER, over);
			this.addEventListener(MouseEvent.ROLL_OUT, out);
			this.addChild(bg);
			bg.x = -8;
			this.lvl_star.x = -40;
			this.lvl_star.y = -30;
			this.lvl_star.y = -30;
			this.buttonMode = true;
			this.lvl_star.star.stop();
		}
		
		private function onSlotClick(e:MouseEvent):void {
			if (unit == null) {
				this.onBtnAddUnit();
			} else {
				this.clickUnit();
			}
		}
		
		private function out(e:MouseEvent):void {
			App.info.frees();
			if (!UserStaticData.hero.units[int(e.currentTarget.name)]) {
				return;
			}
			unit.out();
		}
		
		private function over(e:MouseEvent):void {
			App.sound.playSound('over1', App.sound.onVoice, 1);
			if (!UserStaticData.hero.units[int(e.currentTarget.name)]) {
				return;
			}
			unit.over();
			var obj:Object = UserStaticData.hero.units[int(e.currentTarget.name)];
			var chars:Object = new Object();
			chars[0] = obj.hp;
			chars[1] = obj.mp;
			chars[2] = obj.min_d;
			chars[3] = obj.f_d;
			chars[4] = obj.m_d;
			chars[5] = obj.sp;
			chars[6] = obj["in"];
			chars[7] = obj.max_d;
			chars[8] = obj.t_d;
			chars[200] = 0;
			chars[201] = UserStaticData.hero.skills.energy;
			chars[202] = UserStaticData.hero.skills.attack;
			chars[203] = UserStaticData.hero.skills.defence;
			chars[204] = UserStaticData.hero.skills.defence;
			chars[205] = 0;
			for (var key:Object in obj.it) {
				for (var key2:Object in obj.it[key].c ) {
					chars[int(key2)+200] += obj.it[key].c[key2];
				}
			}
			if (WinCastle.currSlotClick != this.name) {
				App.info.init(this.x + this.btnByeUnit.width / 2 + 15 , this.y - (115 / 2), { title:Lang.getTitle(38, obj.t), type:1, chars:chars } );
			}
		}
		
		public function init():void {
			this.frees();
			App.spr.addChildAt(this, 0);
			if (UserStaticData.hero.units[int(name)] == null) {
				this.addChild(btnByeUnit);
			} else { 
				this.unit = UnitCache.getUnit(namesUnit[UserStaticData.hero.units[int(this.name)].t]);
				this.unit.itemUpdate(Slot.getUnitItemsArray(UserStaticData.hero.units[this.name]));
				this.unit.init(this);
				this.unit.x = 0; this.unit.y = 0;
				this.unit.y = 39;
				this.addChild(MovieClip(unit));
				this.addChild(this.lvl_star);
				this.higlightLvlStar();
			}
		}
		
		public function higlightLvlStar(unit:Object = null):void {
			if(unit == null) {
				unit = UserStaticData.hero.units[this.name];
			}
			this.lvl_star.txt.text = unit.lvl;
			if (unit.fs > 0) {
				if(this.lvl_star.star.currentFrame != 2) {
					this.lvl_star.star.gotoAndStop(2);
				}
			} else {
				if(this.lvl_star.star.currentFrame != 1) {
					this.lvl_star.star.gotoAndStop(1);
				}
			}
		}
		
		public  static function getUnitItemsArray( un_obj:Object ):Array {
			var arr:Array = new Array();
			for (var i:int = 0; i < 7; i++) {
				if (un_obj.it[i] == null) {
					arr[i] = 0;
				} else {
					arr[i] = un_obj.it[i].id;
				}
			}
			return arr;
		}
		
		public function getItemId(obj:Object):int {
			if (obj == null) {
				return 0;
			} else {
				return int(obj.id);
			}
		}
		
		private function clickUnit():void {
			App.info.frees();
			if (WinCastle.currSlotClick != this.name) {
				App.sound.playSound('inventar', App.sound.onVoice, 1);
				this.addChild(WinCastle.getCastle().mcCurr);
				WinCastle.currSlotClick = this.name;
				this.addChild(MovieClip(unit));
				WinCastle.txtCastle.scroll.visible = false;
				WinCastle.inventar.frees1();
				WinCastle.inventar.init1(UserStaticData.hero.units[this.name])
			}
		}
		
		private function onBtnAddUnit():void {
			App.info.frees();
			if(this.name != WinCastle.currSlotClick) {
				App.sound.playSound('inventar', App.sound.onVoice, 1);
				WinCastle.txtCastle.scroll.visible = true;
				WinCastle.currSlotClick = this.name;
				this.addChild(WinCastle.getCastle().mcCurr);
				this.addChild(btnByeUnit);
				WinCastle.inventar.frees1();
			}
			if(UserStaticData.hero.demo == 0) {
				App.tutor.init(3);
			}
			
		}
		
		public function frees():void {
			if ( this.contains(WinCastle.getCastle().mcCurr) ) {
				this.removeChild(WinCastle.getCastle().mcCurr);
			}
			if (unit != null) {
				this.lvl_star.parent.removeChild(this.lvl_star);
				unit.frees();
				Sprite(unit).removeEventListener(MouseEvent.CLICK, clickUnit);
				unit = null;
			}
			if(this.btnByeUnit.parent != null) {
				this.btnByeUnit.parent.removeChild(this.btnByeUnit);
			}
		}
	}

}