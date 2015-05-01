package rabbit.display 
{
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author Thomas John (@) thomas.john@open-design.be
	 * @copyright Copyright Thomas John, all rights reserved 2009.
	 */
	public class OriginalProperties 
	{
		public static var aProperties:Array = ["x", "y", "z", "width", "height", "scaleX", "scaleY", "scaleZ", "alpha", "visible"];
		
		public var x:Number;
		public var y:Number;
		public var z:Number;
		public var width:Number;
		public var height:Number;
		public var scaleX:Number;
		public var scaleY:Number;
		public var scaleZ:Number;
		public var alpha:Number;
		public var visible:Boolean;
		
		public function OriginalProperties(object:DisplayObject) 
		{
			setOriginalProperties(this, object);
		}
		
		public static function setOriginalProperties(op:OriginalProperties, object:DisplayObject):void
		{
			op.x = object.x;
			op.y = object.y;
			if( object["z"] ) op.z = object.z;
			op.width = object.width;
			op.height = object.height;
			op.scaleX = object.scaleX;
			op.scaleY = object.scaleY;
			if( object["scaleZ"] ) op.scaleZ = object.scaleZ;
			op.alpha = object.alpha;
			op.visible = object.visible;
		}
		
		public static function setToOriginalProperties(op:OriginalProperties, object:DisplayObject, propertiesToAvoid:Array = null):void
		{
			if ( !propertiesToAvoid ) propertiesToAvoid = [];
			
			var i:int = 0;
			var n:int = aProperties.length;
			var prop:String;
			
			for (i = 0; i < n; i++) 
			{
				prop = aProperties[i];
				
				if ( aProperties.indexOf(prop) < 0 )
				{
					if ( object[prop] ) object[prop] = op[prop];
				}
			}
			
			//object.x = op.x;
			//object.y = op.y;
			//if( object["z"] ) object.z = op.z;
			//object.width = op.width;
			//object.height = op.height;
			//object.scaleX = op.scaleX;
			//object.scaleY = op.scaleY;
			//if( object["scaleZ"] ) object.scaleZ = op.scaleZ;
			//object.alpha = op.alpha;
			//object.visible = op.visible;
		}
	}
	
}