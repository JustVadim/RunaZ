package  
{
	import datacalsses.Hero;
	import flash.net.SharedObject;
	
	public class UserStaticData {
		public static const server_ip:String = "192.168.1.198";
		//public static const server_ip:String = "151.80.10.33";
		public static const server_port:int = 3002;
		public static var from:String = "c";
		public static var id:String = "22";
		public static var sig:String = "11111";
		public static var fname:String = "Laukhin";
		public static var sname:String = "Vadim";
		public static var plink:String = "http://orig04.deviantart.net/92ae/f/2009/230/4/1/spongebob_9_150x150_png_by_somemilk.png";
		public static var friend_invited:String = "1";
		public static var hero:Hero = new Hero();
		static public var users_info:Object = new Object();
		static public var my_info:Object;
		static public var levels:Object = [0,100];
		static public var magaz_units:Object = new Object();
		static public var magazin_items:Object = new Object();
		static public var buffs_chances:Array = new Array();
		static public var flash_vars:Object;
		static public var lang:int = 0;
		static public var allId:String;
		static public var achievments_table:Object;
		static public var fd:Object;
		static public var data:SharedObject = SharedObject.getLocal("DarkLands");
		static public var top:Object;
		static public var vkAcievs:Array =	[
												[
													"photo-118450370_412855525",
													"photo-118450370_412855543",
													"photo-118450370_412855560"
												],
												[
													"photo-118450370_412855578",
													"photo-118450370_412855591",
													"photo-118450370_412855614"
												],
												[
													"photo-118450370_412855634",
													"photo-118450370_412855650",
													"photo-118450370_412855656"
												],
												[
													"photo-118450370_412855669",
													"photo-118450370_412855684",
													"photo-118450370_412855698"
												],
												[
													"photo-118450370_412855705",
													"photo-118450370_412855714",
													"photo-118450370_412855722"
												],
												[
													"photo-118450370_412855747",
													"photo-118450370_412855761",
													"photo-118450370_412855776"
												],
												[
													"photo-118450370_412855787",
													"photo-118450370_412855803",
													"photo-118450370_412855824"
												],
												[
													"photo-118450370_413051516",
													"photo-118450370_413051519",
													"photo-118450370_413051521"
												],
												[
													"photo-118450370_412855889",
													"photo-118450370_412855900",
													"photo-118450370_412855910"
												],
												[
													"photo-118450370_412855927",
													"photo-118450370_412855940",
													"photo-118450370_412855953"
												],
												[
													"photo-118450370_412855969",
													"photo-118450370_412855987",
													"photo-118450370_412856002"
												],
												[
													"photo-118450370_412856067",
													"photo-118450370_412856085",
													"photo-118450370_412856099"
												],
												[
													"",
													"",
													""
												],
												[
													"",
													"",
													""
												],
												[
													"",
													"",
													""
												],[
													"",
													"",
													""
												]
											];
		public static var vkCastlesPhoto:Array = 	[
														"photo-118450370_413054752",
														"photo-118450370_413054755",
														"photo-118450370_413054757",
														"photo-118450370_413054763",
														"photo-118450370_413054769",
														"photo-118450370_413054773",
														"photo-118450370_413054776",
														"photo-118450370_413054779",
														"photo-118450370_413054787",
														"photo-118450370_413054792",
														"photo-118450370_413054797",
														"photo-118450370_413054800",
														"photo-118450370_413054816",
														"photo-118450370_413054826",
														"photo-118450370_413054842",
														"photo-118450370_413054855",
														"photo-118450370_413054882",
														"photo-118450370_413054919",
														"photo-118450370_413054939",
														"photo-118450370_413054980",
														"photo-118450370_413055014",
														"photo-118450370_413055054",
														"photo-118450370_413055102",
														"photo-118450370_413055115",
														"photo-118450370_413055123",
														"photo-118450370_413055130",
														"photo-118450370_413055142",
														"photo-118450370_413055147",
														"photo-118450370_413055155",
														"photo-118450370_413055163",
														"photo-118450370_413055168",
														"photo-118450370_413055174",
														"photo-118450370_413055178",
														"photo-118450370_413055185",
														"photo-118450370_413055191",
														"photo-118450370_413055196",
														"photo-118450370_413055218",
														"photo-118450370_413055220",
														"photo-118450370_413055224",
														"photo-118450370_413055231",
														"photo-118450370_413055232",
														"photo-118450370_413055236",
														"photo-118450370_413055249",
														"photo-118450370_413055259",
														"photo-118450370_413055263",
														"photo-118450370_413055271",
														"photo-118450370_413055273",
														"photo-118450370_413055275",
														"photo-118450370_413055276",
														"photo-118450370_413055282",
														"photo-118450370_413055288",
														"photo-118450370_413055290",
														"photo-118450370_413055294",
														"photo-118450370_413055297",
														"photo-118450370_413055300", 
			
													];
		public static var ASK_FRIENDS:Array = null;
		static public var st:int;
	}
}