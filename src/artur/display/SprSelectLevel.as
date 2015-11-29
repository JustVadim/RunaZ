package artur.display {
	
	import adobe.utils.CustomActions;
	import artur.App;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import report.Report;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Server.Lang;
	import Utils.Functions;
	import Utils.json.JSON2;
	
	public class SprSelectLevel extends mcSelect {
		private var btn:BaseButton = new BaseButton(15); // close win
		private var b1:BaseButton = new BaseButton(35); // btn noob
		private var b2:BaseButton = new BaseButton(36); // btn voin
		private var b3:BaseButton = new BaseButton(37); // btn strateg
		private var b4:BaseButton = new BaseButton(38); // btn king
		private var missNum:int;
		//  зелени галочкы s0 s1 s2 s3
		public function SprSelectLevel() {
			Functions.SetPriteAtributs(this, true, true);
			Functions.SetPriteAtributs(this.btn, true, false, 405, 302);
			for (var i:int = 1; i < 5; i++) {
				Functions.SetPriteAtributs(this["b" + i], true, false, 361.95, 128.75 + 30.5 * i);
				Functions.SetPriteAtributs(this["s" + int(i - 1).toString()], false, false);
				this["s" + int(i - 1).toString()].visible = false;
			}
		}
		
		private function onBtn(e:MouseEvent):void {
			var mc:BaseButton = BaseButton(e.target);
			switch(mc) {
				case this.btn:
					break;
				case this.b1:
					this.setBattle(0);
					break;
				case this.b2:
					this.setBattle(1);
					break;
				case this.b3:
					this.setBattle(2);
					break;
				case this.b4:
					this.setBattle(3);
					break;
			}
			this.frees();
		}
		
		private function setBattle(d:int):void {
			App.lock.init();	
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, getRessBattle);
			var obj:Object = new Object();
			obj.mn = this.missNum;
			obj.d = d;
			data.sendData(COMMANDS.CREAT_BATTLE, JSON2.encode(obj), true);
		}
		
		private function getRessBattle(e:DataExchangeEvent):void {
			var obj:Object = JSON2.decode(e.result);
			if (obj.error==null) {
				UserStaticData.hero.mbat = obj.res;
				UserStaticData.hero.bat = obj.res.id;
				App.lock.frees();
				App.winManajer.swapWin(3);
			} else {
				if (obj.error == 1) {
					App.lock.frees();
					App.closedDialog.init(Lang.getTitle(37), false);
				} else {
					App.lock.init('Error: ' + obj.error)
				}
			}
		}
		
		public function init(missNum:int, misObj:Object):void {
			this.missNum = missNum;
			App.spr.addChild(this);
			this.addChild(this.btn);
			this.btn.addEventListener(MouseEvent.CLICK, onBtn);
			for (var i:int = 0; i < 4; i++) {
				if(misObj.st[i]==1) {
					this["s" + i].visible = true;
					this.addChild(this["b" + String(i + 1)]);
					this["b" + String(i + 1)].addEventListener(MouseEvent.CLICK, onBtn);
				} else {
					if(i == 0) {
						this.addChild(this["b" + String(i + 1)]);
						this["b" + String(i + 1)].addEventListener(MouseEvent.CLICK, onBtn);
					} else if (misObj.st[i - 1] == 1) {	
						this.addChild(this["b" + String(i + 1)]);
						this["b" + String(i + 1)].addEventListener(MouseEvent.CLICK, onBtn);
					}
					
				}
			}
		}
		
		public function frees():void {
			App.spr.removeChild(this);
			for (var i:int = 0; i < 4; i++) {
				if(this["b" + String(i + 1)].parent) {
					this.removeChild(this["b" + String(i + 1)]);
					this["b" + String(i + 1)].removeEventListener(MouseEvent.CLICK, onBtn);
				}
				this["s" + String(i)].visible = false;
			}
			this.removeChild(this.btn);
		}
		
	}

}