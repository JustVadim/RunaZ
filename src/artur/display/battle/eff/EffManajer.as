package artur.display.battle.eff 
{
	/**
	 * ...
	 * @author art
	 */
	public class EffManajer 
	{
		private static var data:Array = [{type:'base',className:BaseEff}, {type:'text',className:TextEff}];
		public static var pool:Array = [];
		public function EffManajer() 
		{
			
		}
		public function init():void
		{
			
		}
		public function update():void
		{
			for (var i:int = 0; i < pool.length; i++) 
			{
				pool[i].update();
			}
		}
		public function frees():void
		{
			for (var i:int = 0; i < pool.length; i++) 
			{
				pool[i].frees();
			}
		}
		public static function getEff(type:String):Object
		{
			for (var i:int = 0; i < pool.length; i++) 
			{
				if (pool[i].type == type && pool[i].free) 
				{
					return pool[i];
				}
			}
			
			for (var j:int = 0; j < data.length; j++) 
			{
				if (data[j].type == type) 
				{
					var eff:Object = new data[j].className();
					pool.push(eff);
					return eff;
				}
			}
			return null;
		}
		
	}

}