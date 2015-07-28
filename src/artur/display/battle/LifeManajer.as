package artur.display.battle 
{
	import artur.App;
	import artur.win.WinBattle;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class LifeManajer 
	{
		public static var bin:Boolean = false
		private static var pool:Array = [];
		private var percent:int;
		public static var un_Data:Array = [[], []];
		
		public function LifeManajer() 
		{
			
		}
		
		public function init():void
		{
			this.showLB(true);
		}
		
		private function onKeyUp(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.CONTROL && bin)
			{
				this.hideLb();
			}
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.CONTROL && !bin )
			{
				this.showLB(false);
			}
		}
		
		public function showLB(is_bar:Boolean):void
		{
			if (!bin)
			{
				LifeManajer.bin = true;
				this.redraw();
				if (is_bar)
				{
					Main.THIS.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				}
				else
				{
					Main.THIS.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
					Main.THIS.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				}
			}
		}
		
		public function hideLb():void
		{
			bin = false;
			for (var i:int = 0; i < 2; i++) 
			{
				for (var j:Object in un_Data[i]) 
				{
					if (un_Data[i][j] != null)
					{
						var bar:mcBar = un_Data[i][j].bar;
						delete(un_Data[i][j].bar);
						bar.alpha = 0;
						App.spr.removeChild(bar);
					}
				}
			}
			Main.THIS.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			Main.THIS.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		public static function unpateCurrMove(t:int, p:int):void
		{
			var unit:MovieClip = un_Data[t][p].unit;
			var bar:mcBar = un_Data[t][p].bar;
			bar.x = unit.x;
			bar.y = unit.y + unit._head.y - unit._head.height/3;
		}
		
		public static function updateCurrLife(t:int, p:int):void
		{
			var unit:Object = LifeManajer.un_Data[t][p];
			if (unit.currLife != 0)
			{
				LifeManajer.goToBar(LifeManajer.un_Data[t][p]);
			}
			else
			{
				LifeManajer.un_Data[t][p] = null;
				var bar:mcBar = unit.bar;
				delete(unit.bar);
				bar.parent.removeChild(bar);
				bar.alpha = 0;
			}
			
		}
		
		public static function updateCurrMannaPoing():void
		{
			
		}
		
		public function redraw():void
		{
			for (var i:int = 0; i < 2; i++) 
			{
				for (var j:Object in un_Data[i]) 
				{
					if (un_Data[i][j] != null)
					{
						var obj:Object = un_Data[i][j];
						if (obj.currLife > 0 )
						{
							var bar:mcBar = getBar();
							bar.x = obj.unit.x;
							bar.y = obj.unit.y + obj.unit._head.y - obj.unit._head.height/3; 
							obj.bar = bar;
							goToBar(obj);
							App.spr.addChild(bar);
						}
						else
						{
							un_Data[i][j] = null;
						}
					}
				}
			}
		}
		public function update():void
		{
			
		}
		
		public function frees():void
		{
			if (LifeManajer.bin)
			{
				this.freeUnData(LifeManajer.un_Data[0]);
				this.freeUnData(LifeManajer.un_Data[1]);
				LifeManajer.un_Data = [[], []];
			}
		}
		
		private function freeUnData(un:Object):void 
		{
			LifeManajer.bin = false;
			for (var key:Object in un)
			{
				if (un[key] != null)
				{
					var bar:mcBar = un[key].bar;
					delete(un[key].bar);
					bar.alpha = 0;
				}
				delete(un[key]);
			}
		}
		
		public function getBar():mcBar
		{
			for (var i:int = 0; i < pool.length; i++) 
			{
				if (pool[i].alpha == 0) 
				{
					pool[i].alpha = 0.8;
					return pool[i]; 
				}
			}
			
			var mc:mcBar = new mcBar();
			pool.push(mc);
			mc.alpha = 0.8;
			return mc;
		}
		
		public static function goToBar(unit:Object):void
		{
			var bar:mcBar = unit.bar;
			if (unit.currLife != 0)
			{
				var percent:int = 1 + unit.currLife / unit.maxLife * 100;
				bar.life.gotoAndStop(percent);
				percent = 1 + unit.currMana / unit.maxMana * 100;
				bar.mana.gotoAndStop(percent);
			}
		}
		
	}

}