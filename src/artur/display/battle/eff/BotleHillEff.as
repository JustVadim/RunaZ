package artur.display.battle.eff {
	import artur.App;
	import artur.PrepareGr;
	import artur.RasterClip;
	import artur.win.WinBattle;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class BotleHillEff extends Sprite {
		
		private var frm:Array = [];
		private var currFrame:int;
		private var maxFrame:int;
		private var currImg:Bitmap;
		public var free:Boolean = true;
		//public var type
	
		public function BotleHillEff() {
			var mc:MovieClip = new EffHillBotl();
			this.maxFrame = mc.totalFrames -3;
			this.frm = PrepareGr.creatBms(mc, false);
		}
		
		public function init(xp:int,yp:int):void {
			this.free = false;
			this.x = xp;
			this.y = yp + 20;
			this.currFrame = -1;
			WinBattle.spr.addChild(this);
			WinBattle.sortArr.push(this);
			WinBattle.sortSpr();
			EffManajer.pool.push(this);
			this.currImg = frm[0]
			this.addChild(currImg);
		}
		
		public function update():void {
			if (!free) {
				if (currFrame++ >maxFrame) {
					App.dellFromArr(this, EffManajer.pool);
					App.dellFromArr(this, WinBattle.sortArr);
					this.frees();
					return;
				}
				this.removeChild(this.currImg);
				this.currImg = frm[this.currFrame]
				this.addChild(this.currImg);
			}
		}
		
		public function frees():void {
			this.free = true;
			if (this.parent) {
				this.parent.removeChild(this);
			}
		}
		
	}

}