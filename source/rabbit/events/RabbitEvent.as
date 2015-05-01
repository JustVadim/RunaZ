package rabbit.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Thomas John (c) thomas.john@open-design.be
	 */
	public class RabbitEvent extends Event 
	{
		public static const RABBIT_MOVIECLIP_INIT:String = "rabbit.event.RabbitEvent.rabbitMovieClipInit";
		
		public function RabbitEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new RabbitEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("RabbitEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}