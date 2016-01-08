package datacalsses 
{
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
		public var chest:Object = new Object();//chest
		public var miss:Object = new Object();
		public var bat:Number
		public var mbat:Object;
		public var fs:int;
		public var st:Object
		
		public function setHero(obj:Object):void
		{
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
			//// - crab;
			this.level = obj.lvl;
			this.exp = obj.exp;
			this.miss = obj.miss;
			this.fs = obj.fs;
			this.st = obj.st;
			/// - crab;
		}
	}
}