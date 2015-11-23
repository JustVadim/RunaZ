package artur.display.battle.eff {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class BlastEff extends MovieClip {
		
		public var free:Boolean = true;
		public var type:String = 'blast1';
		public function BlastEff() {
			
		}
		
		public function init(parr:Sprite, xp:int=0, yp:int=0,index:int=0):void {
			this.x = xp;
			this.y = yp;
			this.free = false;
			this.addChild(currMovie);
			this.gotoAndPlay(1);
			parr.addChild(this);
		}
		
		public function update():void {
			if (!free) {
				if (this.currentFrame == this.totalFrames) {
				   this.frees();
				}
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