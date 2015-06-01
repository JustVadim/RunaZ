package  
{
	import datacalsses.Hero;
	
	public class UserStaticData 
	{
		public static const server_ip:String = "192.168.0.198";
		public static const server_port:int = 3002;
		public static var from:String = "c";
		public static var id:String = "22";
		public static var sig:String = "11111";
		public static var fname:String = "Вадим";
		public static var sname:String = "Лаухин";
		public static var plink:String = "http://" + server_ip +"/graph/ava.gif";
		public static var friend_invited:String = "1";
		public static var hero:Hero = new Hero();
		static public var users_info:Object = new Object();
		static public var my_info:Object;
		static public var levels:Object = [0,100];
		static public var magaz_units:Object = new Object();
		static public var magazin_items:Object = new Object();//
		static public var buffs_chances:Array = new Array();
		static public var flash_vars:Object;
	}
}