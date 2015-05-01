package rabbit.utils 
{
	import flash.display.Stage;
	import flash.events.Event;
	import rabbit.events.StageEvent;
	import rabbit.managers.events.EventsManager;
	
	/**
	 * ...
	 * @author Thomas John (thomas.john@open-design.be) www.open-design.be
	 */
	public class StageUtils 
	{
		static private var _stage:Stage = null;
		
		public function StageUtils() 
		{
			
		}
		
		static public function get stage():Stage { return _stage; }
		
		static public function set stage(value:Stage):void 
		{
			if ( _stage != null ) return;
			_stage = value;
			EventsManager.getInstance().dispatchEvent( new Event(StageEvent.EVENT_STAGE_INIT) );
		}
	}
	
}