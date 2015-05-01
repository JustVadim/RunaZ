package rabbit.managers.events 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	//import rabbit.utils.AssociationUtils;
	//import rabbit.utils.FrameUtils;
	
	/**
	 * Singleton class
	 * @author Thomas John (thomas.john@open-design.be)
	 */
	public class EventsManager extends EventDispatcher
	{
		private static const FRAME_LISTENER_ASSOCIATIONS_STRING:String = "EventsManager_FRAME_LISTENER_ASSOCIATIONS_STRING"
		
		// our unique instance of this class
		private static var instance:EventsManager = new EventsManager();
		
		// all of our disptachers
		private var dispatchers:Dictionary = new Dictionary(true);
		
		// groups of event dispatchers
		private var groups:Object =  { };
		
		/**
		 * Constructor : check if an instance already exists and if it does throw an error
		 */
		public function EventsManager() 
		{
			if ( instance ) throw new Error( "EventsManager can only be accessed through EventsManager.getInstance()" );
			// init
			
		}
		
		/**
		 * Get unique instance of this singleton class
		 * @return					<EventsManager> Instance of this class
		 */
		public static function getInstance():EventsManager{
			return instance;
		}
		
		/**
		 * Register event for global dispatching (Event centralization)
		 * @param	eventDispatcher
		 * @param	eventType
		 * @param	eventUseCapture
		 */
		public function registerEvent(eventDispatcher:EventDispatcher, eventType:String, eventGroups:Array, eventUseCapture:Boolean = false):void
		{
			add(eventDispatcher, eventType, registeredEventsHandler, eventGroups, true, eventUseCapture);
			//eventDispatcher.addEventListener(eventType, registeredEventsHandler, eventUseCapture);
		}
		
		/**
		 * Unregister event for global dispatching.
		 * @param	eventDispatcher
		 * @param	eventType
		 * @param	eventUseCapture
		 */
		public function unregisterEvent(eventDispatcher:EventDispatcher, eventType:String, eventUseCapture:Boolean = false):void
		{
			remove(eventDispatcher, eventType, registeredEventsHandler, true, eventUseCapture);
			//eventDispatcher.removeEventListener(eventType, registeredEventsHandler, eventUseCapture);
		}
		
		/**
		 * Redispatch all events registered to this class
		 * @param	e
		 */
		private function registeredEventsHandler(e:*):void 
		{
			dispatchEvent(e);
		}
		
		/**
		 * Add an event listener to the list
		 * @param	eventDispatcher
		 * @param	eventType
		 * @param	eventListener
		 * @param	eventGroup
		 * @param	autoAdd
		 * @param	eventUseCapture
		 */
		public function add(eventDispatcher:EventDispatcher, eventType:String, eventListener:Function, eventGroups:Object, autoStart:Boolean = true, autoAdd:Boolean = true, eventUseCapture:Boolean = false):void
		{
			var o:Object = dispatchers[eventDispatcher];
			
			// data for this dispatcher in our dictionary ?
			if ( o == null )
			{
				// no create an object to store it
				o = dispatchers[eventDispatcher] =  { };
			}
			
			// get array of nodes for specified type
			var a:Array = o[eventType] as Array;
			
			// array ?
			if ( a == null )
			{
				// no create it
				a = o[eventType] = [];
			}
			
			var aEventGroups:Array;
			
			// is group array or string ?
			if ( eventGroups is String )
			{
				aEventGroups = new Array();
				aEventGroups.push(eventGroups);
			}
			else
			{
				aEventGroups = eventGroups as Array;
			}
			
			// check for duplicates
			var i:int = 0;
			var n:int = a.length;
			var node:DispatcherNode;
			
			for (i = 0; i < n; i++) 
			{
				node = a[i] as DispatcherNode;
				
				if ( node.listener == eventListener && node.useCapture == eventUseCapture)
				{
					// duplicate
					if ( autoAdd )
					{
						// and add it to new groups
						node.addToGroups(aEventGroups);
					}
					
					if ( autoStart )
					{
						// restart event if needed
						node.startEvent();
					}
					
					return;
				}
			}
			
			// create node
			node = new DispatcherNode(eventDispatcher, eventType, eventListener, aEventGroups, autoStart, autoAdd, eventUseCapture);
			a.push(node);
		}
		
		/**
		 * Remove an event listener from the list
		 * @param	eventDispatcher
		 * @param	eventType
		 * @param	eventListener
		 * @param	autoRemove Auto remove listener.
		 * @param	eventUseCapture
		 * @param	autoRemoveFromAllGroup Auto remove node from all groups it was associated to.
		 * @param	groupsToRemoveFrom Remove node only from groups in this array.
		 */
		public function remove(eventDispatcher:EventDispatcher, eventType:String, eventListener:Function, autoRemove:Boolean = true, eventUseCapture:Boolean = false, autoRemoveFromAllGroup:Boolean = true, groupsToRemoveFrom:Array = null):void
		{
			// something ?
			if (dispatchers[eventDispatcher] == null || dispatchers[eventDispatcher][eventType] == null) 
			{
				// no, quit function here
				return;
			}
			
			// get node
			var node:DispatcherNode = getNode(eventDispatcher, eventType, eventListener, eventUseCapture);
			
			removeNode(node, autoRemove, autoRemoveFromAllGroup, groupsToRemoveFrom);
		}
		
		
		/**
		 * Listen for a frame
		 * @param	mc
		 * @param	frame Label or frame number
		 * @param	eventGroups
		 * @param	autoAdd
		 * @param	eventUseCapture
		 */
		/*
		public function addFrameListener(movieClip:MovieClip, frame:Object,  eventListener:Function, eventGroups:Object, autoAdd:Boolean = true, eventUseCapture:Boolean = false):Boolean
		{
			var iFrame:int = 0;
			
			if ( frame is String )
			{
				iFrame = FrameUtils.getFrameLabelNumber(movieClip, String(frame));
			}
			else
			{
				iFrame = int(frame);
			}
			
			if ( iFrame < 1 ) return false;
			
			// store our movie clip associated to the frame number
			AssociationUtils.setObjectForAssociation([FRAME_LISTENER_ASSOCIATIONS_STRING, movieClip, iFrame], eventListener);
			
			add(movieClip, Event.ENTER_FRAME, frameListener_enterFrameHandler, eventGroups, autoAdd, eventUseCapture);
			
			return true;
		}
		
		private function frameListener_enterFrameHandler(e:Event):void
		{
			var movieClip:MovieClip = e.currentTarget as MovieClip;
			var iFrame:int = movieClip.currentFrame;
			var eventListener:Function = AssociationUtils.getObjectForAssociation([FRAME_LISTENER_ASSOCIATIONS_STRING, movieClip, iFrame]) as Function;
			
			trace(movieClip, iFrame, eventListener);
			
			if ( eventListener != null ) eventListener.call();
		}
		*/
		/**
		 * Remove a node listener and remove this node from associated groups.
		 * @param	node
		 * @param	autoRemove
		 * @param	autoRemoveFromAllGroup
		 * @param	groupsToRemoveFrom
		 */
		public function removeNode(node:DispatcherNode, autoRemove:Boolean = true, autoRemoveFromAllGroup:Boolean = true, groupsToRemoveFrom:Array = null):void
		{
			if ( node != null )
			{
				if ( autoRemove )
				{
					node.stopEvent();
				}
				
				node.removeFromGroups(autoRemoveFromAllGroup, groupsToRemoveFrom);
			}
		}
		
		/**
		 * Remove all listeners from specified group.
		 * @param	group Group Name.
		 * @param	autoRemove Remove listener automatically.
		 */
		public function removeAllFromGroup(group:String, autoRemove:Boolean = true):void
		{
			if ( group == "" ) return;
			
			var a:Array = groups[group];
			
			// something ?
			if ( a == null) return;
			
			// go through all nodes in this array
			var node:DispatcherNode;
			
			while ( a.length > 0 )
			{
				node = a.pop() as DispatcherNode;
				removeNode(node, autoRemove);
			}
		}
		
		/**
		 * Remove all events associated to an event dispatcher
		 * @param	eventDispatcher
		 */
		public function removeAllFromDispatcher(eventDispatcher:EventDispatcher, autoRemove:Boolean = true):void
		{
			var o:Object = dispatchers[eventDispatcher];
			
			// data for this dispatcher in our dictionary ?
			if ( o == null ) return;
			
			// get array of nodes for specified type
			var a:Array;
			var i:int = 0;
			var n:int = 0;
			var node:DispatcherNode;
			
			for (var key:String in o) 
			{
				a = o[key] as Array;
				
				if ( a == null ) continue;
				
				n = a.length;
				for (i = 0; i < n; i++) 
				{
					node = a[i] as DispatcherNode;
					removeNode(node, autoRemove, autoRemove);
				}
			}
		}
		
		/**
		 * Remove all listeners and remove them from their associated groups.
		 * @param	autoRemove
		 */
		public function removeAll(autoRemove:Boolean = true):void
		{
			for each (var o:Object in dispatchers)
			{
				for each (var a:Array in o)
				{
					while ( a.length > 0 )
					{
						var node:DispatcherNode = a.pop() as DispatcherNode;
						
						if ( node != null )
						{
							if ( autoRemove )
							{
								node.stopEvent();
							}
							
							node.removeFromGroups(true);
						}
					}
				}
				//delete dispatchers[o];
			}
		}
		
		/**
		 * Suspend a listener. Can be resumed after.
		 * @param	eventDispatcher
		 * @param	eventType
		 * @param	eventListener
		 * @param	eventUseCapture
		 */
		public function suspend(eventDispatcher:EventDispatcher, eventType:String, eventListener:Function, eventUseCapture:Boolean = false):void
		{
			// something ?
			if (dispatchers[eventDispatcher] == null || dispatchers[eventDispatcher][eventType] == null) 
			{
				// no, quit function here
				return;
			}
			
			// get node
			var node:DispatcherNode = getNode(eventDispatcher, eventType, eventListener, eventUseCapture);
			
			if ( node != null )
			{
				node.stopEvent();
			}
		}
		
		/**
		 * Suspend all listeners from a group.
		 * @param	group
		 */
		public function suspendAllFromGroup(group:String):void
		{
			if ( group == "" ) return;
			
			var a:Array = groups[group];
			
			// something ?
			if ( a == null) return;
			
			// go through all the nodes
			var i:int = 0;
			var n:int = a.length;
			var node:DispatcherNode;
			
			for (i = 0; i < n; i++) 
			{
				node = a[i] as DispatcherNode;
				//trace("suspending", node.type, node.dispatcher, node.listener, node.groups);
				node.stopEvent();
			}
		}
		
		/**
		 * Resume a listener.
		 * @param	eventDispatcher
		 * @param	eventType
		 * @param	eventListener
		 * @param	eventUseCapture
		 */
		public function resume(eventDispatcher:EventDispatcher, eventType:String, eventListener:Function, eventUseCapture:Boolean = false):void
		{
			// something ?
			if (dispatchers[eventDispatcher] == null || dispatchers[eventDispatcher][eventType] == null) 
			{
				// no, quit function here
				return;
			}
			
			// get node
			var node:DispatcherNode = getNode(eventDispatcher, eventType, eventListener, eventUseCapture);
			
			if ( node != null )
			{
				node.startEvent();
			}
		}
		
		/**
		 * Resume all listener from a group.
		 * @param	group
		 */
		public function resumeAllFromGroup(group:String):void
		{
			if ( group == "" ) return;
			
			var a:Array = groups[group];
			
			// something ?
			if ( a == null) return;
			
			// go through all the nodes
			var i:int = 0;
			var n:int = a.length;
			var node:DispatcherNode;
			
			for (i = 0; i < n; i++) 
			{
				node = a[i] as DispatcherNode;
				//trace("resuming", node.type, node.dispatcher, node.listener, node.groups);
				node.startEvent();
			}
		}
		
		/**
		 * Add a node to a group.
		 * @param	node
		 * @param	group
		 */
		public function addNodeToGroup(node:DispatcherNode, group:String):void
		{
			// something ?
			if ( node == null || group == "" ) return;
			
			var pos:int = getNodePositionInGroup(node, group);
			
			if ( pos > -1 )
			{
				return;
			}
			
			// get group array
			var aGroup:Array = groups[group];
			
			if ( aGroup == null )
			{
				// no array, create it
				aGroup = groups[group] = [];
			}
			
			// add node to array
			aGroup.push(node);
		}
		
		/**
		 * Remove a node from a group.
		 * @param	node
		 * @param	group
		 */
		public function removeNodeFromGroup(node:DispatcherNode, group:String):void
		{
			// something ?
			if ( node == null || group == "" ) return;
			
			var pos:int = getNodePositionInGroup(node, group);
			
			if ( pos < 0 )
			{
				return;
			}
			
			// get group array
			var aGroup:Array = groups[group];
			
			if ( aGroup == null )
			{
				// group doesn't exist
				return;
			}
			
			// remove node from group
			aGroup.splice(pos, 1);
		}
		
		/**
		 * Get the node index in the specified group array.
		 * @param	node
		 * @param	group Group name (String).
		 * @return
		 */
		public function getNodePositionInGroup(node:DispatcherNode, group:String):int
		{
			// something ?
			if ( node == null || group == "" ) return -1;
			
			var a:Array = groups[group];
			
			// something ?
			if ( a == null) return -1;
			
			// look for it in the group array
			var i:int = 0;
			var n:int = a.length;
			var nodeInGroupList:DispatcherNode;
			
			for (i = 0; i < n; i++)
			{
				nodeInGroupList = a[i];
				
				if ( nodeInGroupList == node )
				{
					return i;
				}
			}
			
			return -1;
		}
		
		/**
		 * Get node.
		 * @param	eventDispatcher
		 * @param	eventType
		 * @param	eventListener
		 * @param	eventUseCapture
		 * @return
		 */
		public function getNode(eventDispatcher:EventDispatcher, eventType:String, eventListener:Function, eventUseCapture:Boolean = false):DispatcherNode
		{
			// something ?
			if (dispatchers[eventDispatcher] == null || dispatchers[eventDispatcher][eventType] == null) 
			{
				// no, quit function here
				return null;
			}
			
			// get node
			// get node
			var a:Array = dispatchers[eventDispatcher][eventType] as Array;
			var i:int = 0;
			var n:int = a.length;
			var node:DispatcherNode;
			
			for (i = 0; i < n; i++) 
			{
				node = a[i] as DispatcherNode;
				
				if ( node.listener == eventListener && node.useCapture == eventUseCapture )
				{
					return node;
				}
			}
			
			return null;
		}
	}
	
}