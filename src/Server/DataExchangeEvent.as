package Server 
{
	import flash.events.Event;

	public class DataExchangeEvent extends Event
	{
		public static const DATA_RECIEVED:String = "DATA_RECIEVED";
		public static const CONNECTED:String = "CONNECTED";
		public static const DISCONECTED:String = "DISCONECTED";
		public static const ON_RESULT:String = "ON_RESULT";
		public static const CLOSE:String = "CLOSE";
		public static const ON_LOGIN_COMPLETE:String = "ON_LOGIN_COMPLETE";
		public static const ON_BATTLE_UPDATE:String = "ON_BATTLE_UPDATE	";
		public static const BATTLE_MASSAGE:String = "BATTLE_MASSAGE";
		
		public var n:int = 0;
		public var m:String = "";
		public var c:String = "";
		public var sig:String = "";
		public var result:String = "";
		
		public function DataExchangeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false):void
		{
			super(type, bubbles, cancelable);
		}
	}

}