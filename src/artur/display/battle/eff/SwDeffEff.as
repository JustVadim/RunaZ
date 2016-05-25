package artur.display.battle.eff 
{
	import artur.App;
	import artur.PrepareGr;
	import artur.RasterClip;
	import artur.win.WinBattle;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import report.Report;
	
	public class SwDeffEff extends Sprite
	{
		private var frm:Array = [];
		private var currFrame:int;
		private var maxFrame:int;
		private var currImg:Bitmap;
		public var free:Boolean = true;
		public var type:String =  'swDeff'
		public function SwDeffEff() {
			this.frm = RasterClip.getAnimationBitmaps(new mcDeff);//PrepareGr.creatBms(new mcDeff(), false);
			this.maxFrame = frm.length-3;
		}
		
		public function init(xp:int,yp:int):void {
			free = false;
			this.x = xp;
			this.y = yp + 20;
			currFrame = -1;
			WinBattle.spr.addChild(this);
			WinBattle.sortArr.push(this);
			WinBattle.sortSpr();
			EffManajer.pool.push(this);
			currImg = frm[0]
			this.addChild(currImg);
		}
		
		public function update():void {
			if (currFrame++ >=maxFrame) {
				App.dellFromArr(this, EffManajer.pool);
				App.dellFromArr(this, WinBattle.sortArr);
				frees();
				return;
			}
			this.removeChild(this.currImg);
			currImg = frm[currFrame]
			this.addChild(currImg);
		}
		
		public function frees():void {
			free = true;
			if (parent) {
				parent.removeChild(this);
			}
		}
		
		
		
	}

}