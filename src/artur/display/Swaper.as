package artur.display {
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Server.Lang;
	import Utils.Functions;
	import Utils.json.JSON2;
	import artur.App;
	import artur.win.WinCastle;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import report.Report;
	
	public class Swaper extends Sprite {
		private var btn1:BaseButton;
		private var btn2:BaseButton;
		private var num:int;
		private var sd:Object = new Object();
		
		public function Swaper(i:int) {
			this.num = i;
			Functions.SetPriteAtributs(this, false, true, 25 + 17 * (i % 2), 17.6 + i * 95);
			this.addChild(this.btn1 = new BaseButton(56));
			this.addChild(this.btn2 = new BaseButton(56));
			this.btn2.scaleY = -1;
			this.btn2.y = 97.4;
		}
		
		public function init( indexSlot:int = 0):void {
			App.spr.addChild(this);
			this.addBtnsEvents(this.btn1);
			this.addBtnsEvents(this.btn2);
		}
		
		private function addBtnsEvents(btn:BaseButton):void {
			btn.addEventListener(MouseEvent.CLICK, this.onClick);
			btn.addEventListener(MouseEvent.ROLL_OVER, this.onOver);
			btn.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
		}
		
		private function onOut(e:MouseEvent):void {
			App.info.frees();
		}
		
		private function onOver(e:MouseEvent):void {
			var btn:BaseButton = BaseButton(e.target);
			App.info.init(btn.x + 60, btn.y + 10 + this.y, { type:0, txtInfo_w:250, txtInfo_h:48, txtInfo_t:Lang.getTitle(166)} );
		}
		
		private function onClick(e:MouseEvent):void {
			var btn:BaseButton = BaseButton(e.target);
			var swapTo:int = (btn.scaleY == 1) ? this.num - 1:this.num + 1;
			if(swapTo == -1) {
				swapTo = 3;
			} else if(swapTo == 4) {
				swapTo = 0;
			}
			if (UserStaticData.hero.units[this.num] != null || UserStaticData.hero.units[swapTo] != null) {
				App.lock.init();
				this.sd.f = this.num;
				this.sd.t = swapTo;
				var data:DataExchange = new DataExchange();
				data.addEventListener(DataExchangeEvent.ON_RESULT, this.onSwap);
				data.sendData(COMMANDS.SWAP_UNITS, JSON2.encode(sd), true);
			} 
		}
		
		private function onSwap(e:DataExchangeEvent):void {
			DataExchange(e.target).removeEventListener(e.type, this.onSwap);
			var res:Object = JSON2.decode(e.result);
			if (res.res != null) {
				res = UserStaticData.hero.units[this.sd.f];
				UserStaticData.hero.units[this.sd.f] = UserStaticData.hero.units[sd.t];
				UserStaticData.hero.units[this.sd.t] = res;
				if(this.sd.t in UserStaticData.hero.units && UserStaticData.hero.units[this.sd.t] == null) {
					delete(UserStaticData.hero.units[this.sd.t])
				}
				if(this.sd.f in UserStaticData.hero.units && UserStaticData.hero.units[this.sd.f] == null) {
					delete(UserStaticData.hero.units[this.sd.f])
				}
				WinCastle.inst.updateSwapSlots(this.sd);
				if(UserStaticData.hero.units[this.sd.t] != null) {
					WinCastle.inst.selectSlot(int(this.sd.t), false);
				} else {
					WinCastle.inst.selectSlot(int(this.sd.f), false);
				}
				App.lock.frees();
			} else {
				App.lock.init(res.error);
			}
			
		}
	}

}