package artur.display {
	import artur.App;
	import flash.events.MouseEvent;
	
	public class SprUserNewLevel extends mcLvlUp {
		private var btns:Array = [];
		public function SprUserNewLevel() {
			var yp:Array = [130.3, 154, 177.6, 201.4];
			for (var i:int = 0; i < 4; i++) {
				var btn:BaseButton = new BaseButton(34);
				btn.x = 87;
				btn.y = yp[i];
				this.addChild(btn);
				btn.name = String(i);
				btn.addEventListener(MouseEvent.CLICK, onBtn);
			}
		}
		
		private function onBtn(e:MouseEvent):void {
			var str:String = e.currentTarget.name;
			switch(str) {
			case '0':
				
				break;
			case '1':
				
				break;
			case '2':
				
				break;
			case '3':
				
				break;
			}
		}
		
		public function init(text:String):void {
			this.txt.text = text;
			App.spr.addChild(this);
		}
	}
}