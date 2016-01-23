package artur.display {
	import artur.App;
	public class Tutor extends mcTutorial {
		public function Tutor() {
			this.gotoAndStop(1);
		}
		
		public function init(frame:int):void {
			App.spr.addChild(this);
			this.gotoAndStop(frame);
		}
		
		public function frees():void {
			if(this.parent) {
				this.parent.removeChild(this);
			}
		}
	}

}