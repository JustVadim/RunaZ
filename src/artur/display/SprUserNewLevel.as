package artur.display {
	import artur.App;
	import artur.win.WinRoot;
	import datacalsses.Hero;
	import flash.events.MouseEvent;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Utils.json.JSON2;
	
	public class SprUserNewLevel extends mcLvlUp {
		private var btns:Array = [];
		private var pushedBtn:String;
		
		public function SprUserNewLevel() {
			var yp:Array = [130.3, 154, 177.6, 201.4];
			for (var i:int = 0; i < 4; i++) {
				var btn:BaseButton = new BaseButton(34);
				btn.x = 88;
				btn.y = yp[i];
				this.addChild(btn);
				btn.name = String(i);
				btn.addEventListener(MouseEvent.CLICK, onBtn);
			}
		}
		
		private function onBtn(e:MouseEvent):void {
			var str:String = e.currentTarget.name;
			App.lock.init();
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, this.onRes);
			data.sendData(COMMANDS.PERSON_UPDATE, str, true);
			this.pushedBtn = str;
		}
		
		private function onRes(e:DataExchangeEvent):void 
		{
			var res:Object = JSON2.decode(e.result);
			if (res.error == null) {
				var hero:Hero = UserStaticData.hero;
				hero.cur_vitality = res.res;
				hero.fs -= 1;
				switch(pushedBtn) {
					case "0":
						hero.skills.attack++;
						break;
					case "1":
						hero.skills.defence++;
						break;
					case "2":
						hero.skills.energy++;
						break;
					case "3":
						hero.skills.vitality++;
						break;
				}
				WinRoot(App.winManajer.windows[0]).updateBar();
				App.lock.frees();
			}
			else {
				App.lock.init(res.error);
			}
		}
		
		public function init(text:String):void {
			if(!this.parent) {
				App.spr.addChild(this);
			}
		}
		
		public function frees():void {
			if(this.parent) {
				this.parent.removeChild(this);
			}
		}
	}
}