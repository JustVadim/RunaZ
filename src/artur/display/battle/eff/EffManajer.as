package artur.display.battle.eff
{
	import artur.App;
	import flash.display.Sprite;
	import rabbit.effects.lightning.Lightning;
	
	public class EffManajer
	{
		private static var data:Array = [{type: 'base', className: BaseEff}, {type: 'text', className: TextEff},{type: 'manaHill', className:BotleManaEff},{type: 'swDeff', className:SwDeffEff},{type: 'swAtack', className:SwAtackEff}];
		public static var pool:Array = [];
		public static var lgs:Lightning = new Lightning();
		private static var lgsDell:int = 0;
        public static var effBotleHill:BotleHillEff = new BotleHillEff();		
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
		
		public static function showLgs(dell:int, parr:Sprite, color:uint, stX:Number, stY:Number, endX:Number, endY:Number):void
		{
			lgs.init();
			parr.addChild(lgs);
			lgs._startX = stX;
			lgs._startY = stY;
			lgs._endX = endX;
			lgs._endY = endY;
			lgs.bin = true;
			lgs._color = color;
			App.btnOverFilter.color = 0xFFFFFF;
			lgsDell = dell;
			App.btnOverFilter.alpha = 0.4; 
			lgs.filters = [App.btnOverFilter];
			lgs.update();
		}
	}

}