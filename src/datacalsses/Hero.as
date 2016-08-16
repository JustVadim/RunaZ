package datacalsses 
{
	import artur.App;
	import report.Report;
	public class Hero 
	{
		public var silver:int=0;//silver
		public var gold:int=0;//gold
		public var cur_vitality:int=0;//energy
		public var skills:HeroSkills = new HeroSkills();//skills
		public var units:Object = new Object();// units
		public var level:int = 1;
		public var exp:int = 1;
		public var demo:int = 0;
		public var chest:Object = new Object();//chest
		public var miss:Object = new Object();
		public var bat:Number
		public var mbat:Object;
		public var fs:int;
		public var st:Object
		public var sz:Object;
		public var t:Object;
		public var sett:Object;
		public var rat:int;
		public var nle:int;
		public var ach:Object;
		public var sg:Object;
		public var vip:Object;
		
		public function setHero(obj:Object):void {
			this.silver = obj.s;
			this.gold = obj.g;
			this.cur_vitality = obj.cv;
			this.skills.attack = obj.sk.a;
			this.skills.defence = obj.sk.d;
			this.skills.energy = obj.sk.en;
			this.skills.vitality = obj.sk.v;
			this.units = obj.u;
			this.chest = obj.ch
			this.bat = obj.bat;
			this.rat = obj.rat;
			this.nle = obj.nle;
			this.level = obj.lvl;
			this.exp = obj.exp;
			this.miss = obj.miss;
			this.fs = obj.fs;
			this.st = obj.st;
			this.sz = obj.sz;
			this.demo = obj.demo;
			this.t = obj.t;
			this.sett = obj.fbs;
			this.ach = obj.ach;
			this.vip = obj.vip;
		}
		
		public function addAndCheckExp(exp_:int):void {
			this.exp += exp_;
			if(this.exp >= this.nle) {
				this.exp = 0;
				this.level++;
				this.fs++;
				this.nle = UserStaticData.levels[this.level];
				Main.THIS.chat.addFortunaBtn();
					//App.dialogManager.checkPerson();
				App.dialogManager.show_new_person_level = true;
				if(this.level == 3 || this.level == 5 || this.level == 7) {
					App.dialogManager.show_arena_one = true;
					App.dialogManager.show_arena_two = false;
				}
			}
		}
		
		public function checkLevelUp():Boolean {
			for(var key:Object in this.units) {
				if (this.units[key].fs > 0) {
					return true;
				}
			}
			return false;
		}
		
		public function addAndCheckUnitExp(exp:int, ul:Object):void {
			for (var key:Object in ul) {	
				Report.addMassage("Unit alive: " + ul[key] + "exp: " + exp);
				var unit:Object = this.units[ul[key]];
				unit.exp += exp;
				if (unit.exp >= unit.nle) {
					unit.lvl++;
					unit.fs += 2;
					unit.exp = 0;
					unit.nle = UserStaticData.levels[unit.lvl];
					App.dialogManager.checkUnits();
				}
			}
		}
		
		public function setAchievm(temp_obj:Object):void {
			for(var key:Object in temp_obj) {
				this.ach[key].q = temp_obj[key];
			}
		}
		
		public static function isMiss(id:Number):Boolean {
			if(id>-1 && id<20000) {
				return true;
			}
			return false;
		}
		
		public static function isCave(id:Number):Boolean {
			if(id>=20000 && id< 40000) {
				return true;
			}
			return false;
		}
	}
}