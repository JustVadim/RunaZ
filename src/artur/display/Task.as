package artur.display {
	import artur.App;
	import Utils.Functions;
	public class Task extends mcGvest {
		private var close:BaseButton = new BaseButton(33);
		private var take:BaseButton = new BaseButton(33);
		public function Task() {
			Functions.SetPriteAtributs(this, false, true);
			this.close.x = 403;
			this.close.y = 374;
		}
		
		public function init(isChat:Boolean = false):void {
			App.spr.addChild(this);
			if (UserStaticData.hero.t.tn != 0) {
				if(!isChat) {
					if(UserStaticData.hero.t.tp == 0) {
						//play new task sound
					} else {
						//play done task sound
					}
				} else {
					if(UserStaticData.hero.t.tp == UserStaticData.hero.t.pa) {
						//play done task sound
					}
				}
				if(UserStaticData.hero.t.tp != UserStaticData.hero.t.pa) {
					this.addChild(this.close);
				} else {
					//add take gold btn
				}
			} else {
				this.frees();
			}
		}
		
		public function frees():void {
			if(this.parent) {
				this.parent.removeChild(this);
			}
		}
		
	}

}