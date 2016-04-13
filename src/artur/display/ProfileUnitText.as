package artur.display 
{
	import artur.units.U_Paladin;
	import artur.units.U_Warwar;
	import Utils.Functions;
	import _SN_vk.api.DataProvider;
	import artur.units.UnitCache;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class ProfileUnitText extends Sprite
	{
		private var txtLife:McInfoInfos = new McInfoInfos();
		private var txtMana:McInfoInfos = new McInfoInfos();
		private var txtDmg:McInfoInfos = new McInfoInfos();
		private var txtFizDeff:McInfoInfos = new McInfoInfos();
		private var txtMagDeff:McInfoInfos = new McInfoInfos();
		private var txtInic:McInfoInfos = new McInfoInfos();
		private var txtSpeed:McInfoInfos = new McInfoInfos();
		private var bg:bgBlankUnitProfile = new bgBlankUnitProfile();
		private var unit:Object;
		public var lvl_star:LvlStar = new LvlStar();
		
		public function ProfileUnitText(xx:Number, yy:Number) {
			this.x = xx;
			this.y = yy;
			this.bg.y = -3;
			this.bg.x = -7;
			this.addChild(this.bg);
			this.txtLife.y = -2;
			this.txtMana.y = 15;
			this.txtDmg.y = 32;
			this.txtFizDeff.y = 49;
			this.txtMagDeff.y = 66;
			this.txtInic.y = 83;
			this.txtSpeed.y = 100;
			this.lvl_star.x = 8;
			this.lvl_star.y = 12;
			this.lvl_star.star.gotoAndStop(2);
			
			
			this.txtLife.txt1.text = "10";
			this.txtLife.txt2.text = "29";
			this.addChild(this.txtLife);
			this.addChild(this.txtMana);
			this.addChild(this.txtDmg);
			this.addChild(this.txtFizDeff);
			this.addChild(this.txtMagDeff);
			this.addChild(this.txtInic);
			this.addChild(this.txtSpeed);
			this.addChild(this.lvl_star);
		}
		
		public function init(hero:Object, num:int):void {
			if(hero.u[num] == null) {
				this.visible = false;
			} else {
				this.visible = true;
				var unit:Object = hero.u[num];
				var chars:Object = Functions.GetOtherHeroChars(hero);
				for (var key:Object in unit.it) {
					for (var key2:Object in unit.it[key].c ) {
						chars[int(key2)] += unit.it[key].c[key2];
					}
				}
				Functions.compareAndSet(this.txtLife.txt1, unit.hp);
				Functions.compareAndSet(this.txtLife.txt2, chars[0]);
				Functions.compareAndSet(this.txtMana.txt1, unit.mp);
				Functions.compareAndSet(this.txtMana.txt2, chars[1]);
				Functions.compareAndSet(this.txtDmg.txt1, String(unit.min_d + " - " + unit.max_d));
				Functions.compareAndSet(this.txtDmg.txt2, chars[2]);
				Functions.compareAndSet(this.txtFizDeff.txt1, unit.f_d);
				Functions.compareAndSet(this.txtFizDeff.txt2, chars[3]);
				Functions.compareAndSet(this.txtMagDeff.txt1, unit.m_d);
				Functions.compareAndSet(this.txtMagDeff.txt2, chars[4]);
				Functions.compareAndSet(this.txtInic.txt1, unit["in"]);
				Functions.compareAndSet(this.txtInic.txt2, "0");
				Functions.compareAndSet(this.txtSpeed.txt1, unit.sp);
				Functions.compareAndSet(this.txtSpeed.txt2, "0");
				Functions.compareAndSet(this.lvl_star.txt, unit.lvl);
				this.unit = UnitCache.getUnit(Slot.namesUnit[unit.t]);
				this.unit.itemUpdate(Slot.getUnitItemsArray(unit));
				this.unit.init(this);
				this.unit.y = 105;
				this.unit.x = 45;
				this.unit.scaleX = this.unit.scaleY = 1.2;
				U_Warwar.onSound = false;
			    U_Paladin.onSound = false;
			}
		}
		
		public function frees():void {
			if(this.visible && this.unit != null) {
				this.unit.frees();
				this.unit = null;
			}
		}
		
	}

}