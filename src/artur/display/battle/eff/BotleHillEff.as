package artur.display.battle.eff 
{
	import artur.App;
	import artur.PrepareGr;
	import artur.RasterClip;
	import artur.win.WinBattle;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author art
	 */
	public class BotleHillEff extends Sprite
	{
		private var frm:Array = [];
		private var currFrame:int;
		private var maxFrame:int;
		private var currImg:Bitmap
		public function BotleHillEff() 
		{
			frm = PrepareGr.creatBms(new AnimBlud3(), false);
			maxFrame = frm.length-2;
		}
		public function init(xp:int,yp:int):void
		{
			this.x = xp;
			this.y = yp;
			currFrame = -1;
			WinBattle.spr.addChild(this);
			WinBattle.sortSpr();
			EffManajer.pool.push(this);
			currImg = frm[0]
			this.addChild(currImg);
		}
		public function update():void
		{
			if (currFrame++ >maxFrame) 
			{
				App.dellFromArr(this, EffManajer.pool);
				frees();
				return;
			}
			 removeChild(currImg);
			 currImg = frm[currFrame]
			 this.addChild(currImg);
		}
		public function frees():void
		{
			
			if (parent) parent.removeChild(this);
		}
		
		
		
	}

}