package rabbit.managers.events 
{
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Thomas John (thomas.john@open-design.be) www.open-design.be
	 */
	public class QuickEvents 
	{
		
		public function QuickEvents() 
		{
			
		}
		
		public static function addMouseClickEvent(eventDispatcher:EventDispatcher, eventListener:Function, eventGroups:Object):void
		{
			var eManager:EventsManager = EventsManager.getInstance();
			eManager.add(eventDispatcher, MouseEvent.CLICK, eventListener, eventGroups);
		}
		
		public static function addMouseOverEvent(eventDispatcher:EventDispatcher, eventListener:Function, eventGroups:Object):void
		{
			var eManager:EventsManager = EventsManager.getInstance();
			eManager.add(eventDispatcher, MouseEvent.MOUSE_OVER, eventListener, eventGroups);
		}
		
		public static function addMouseOutEvent(eventDispatcher:EventDispatcher, eventListener:Function, eventGroups:Object):void
		{
			var eManager:EventsManager = EventsManager.getInstance();
			eManager.add(eventDispatcher, MouseEvent.MOUSE_OUT, eventListener, eventGroups);
		}
		
		public static function addRollOverEvent(eventDispatcher:EventDispatcher, eventListener:Function, eventGroups:Object):void
		{
			var eManager:EventsManager = EventsManager.getInstance();
			eManager.add(eventDispatcher, MouseEvent.ROLL_OVER, eventListener, eventGroups);
		}
		
		public static function addRollOutEvent(eventDispatcher:EventDispatcher, eventListener:Function, eventGroups:Object):void
		{
			var eManager:EventsManager = EventsManager.getInstance();
			eManager.add(eventDispatcher, MouseEvent.ROLL_OUT, eventListener, eventGroups);
		}
		
		public static function addMouseDown(eventDispatcher:EventDispatcher, eventListener:Function, eventGroups:Object):void
		{
			var eManager:EventsManager = EventsManager.getInstance();
			eManager.add(eventDispatcher, MouseEvent.MOUSE_DOWN, eventListener, eventGroups);
		}
		
		public static function addMouseUp(eventDispatcher:EventDispatcher, eventListener:Function, eventGroups:Object):void
		{
			var eManager:EventsManager = EventsManager.getInstance();
			eManager.add(eventDispatcher, MouseEvent.MOUSE_UP, eventListener, eventGroups);
		}
	}
	
}