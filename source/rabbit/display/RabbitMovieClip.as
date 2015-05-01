package rabbit.display 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	import rabbit.events.RabbitEvent;
	import rabbit.managers.events.EventsManager;
	import rabbit.utils.StageUtils;
	import rabbit.utils.UniqueIdUtil;
	
	/**
	 * ...
	 * @author Thomas John (thomas.john@open-design.be) www.open-design.be
	 */
	public class RabbitMovieClip extends MovieClip
	{
		protected var eManager:EventsManager = EventsManager.getInstance();
		protected var eventGroup:String = "RabbitMovieClip";
		
		protected static var bIsInitialized:Boolean = false;
		
		public function RabbitMovieClip():void 
		{
			// set default event group name (class name)
			eventGroup = getQualifiedClassName(this) + "_" + UniqueIdUtil.getUniqueId(8);
			
			preInit();
			
			if (stage) addedToStageHandler();
			else addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		/**
		 * Function called before checking if class is already added to displaylist
		 */
		protected function preInit():void
		{
			
		}
		
		private function addedToStageHandler(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			// keep stage instance as static reference
			if( !StageUtils.stage ) StageUtils.stage = stage;
			
			onStageSet();
			
			if ( bIsInitialized )
			{
				init();
			}
			else
			{
				eManager.add(eManager, RabbitEvent.RABBIT_MOVIECLIP_INIT, RabbitMovieClip_initHandler, [eventGroup + ".RabbitMovieClipInit"]);
			}
		}
		
		/**
		 * Function called after preInit and when stage property has been set and is available
		 */
		protected function onStageSet():void
		{
			
		}
		
		private function RabbitMovieClip_initHandler(e:RabbitEvent):void
		{
			eManager.removeAllFromGroup(eventGroup + ".RabbitMovieClipInit");
			init();
		}
		
		/**
		 * Function called on initialazing every RabbitMovieClip object (startInit()) and is allowed to be initialized
		 */
		protected function init():void
		{
			
		}
		
		public static function startInit():void
		{
			if ( bIsInitialized ) return;
			bIsInitialized = true;
			
			EventsManager.getInstance().dispatchEvent( new RabbitEvent(RabbitEvent.RABBIT_MOVIECLIP_INIT) );
		}
	}
	
}