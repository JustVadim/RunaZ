package Utils {
	import flash.display.MovieClip;
	
	public class Functions {
		
		public static function SetPriteAtributs(mc:Object, mouseUnabled:Boolean, mouseChildren:Boolean, xx:Number = 0, yy:Number = 0):void {
			mc.tabEnabled = false;
			mc.tabChildren = false;
			mc.mouseEnabled = mouseUnabled;
			mc.mouseChildren = mouseChildren;
			if (xx != 0) {
				mc.x = xx;
			}
			if (yy != 0)
			{
				mc.y = yy;
			}
		}
		
		public static function GetHeroChars():Array {
			var chars:Array = [0, UserStaticData.hero.skills.energy * 10 , UserStaticData.hero.skills.attack, UserStaticData.hero.skills.defence, UserStaticData.hero.skills.defence];
			return chars;
		}
	
		
		
	}
}