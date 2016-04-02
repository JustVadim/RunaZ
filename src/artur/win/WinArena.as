package artur.win {
	import artur.App;
	import artur.display.BaseButton;
	import artur.display.MyBitMap;
	import artur.units.U_Lyk;
	import artur.units.U_Mag;
	import artur.units.U_Paladin;
	import artur.units.U_Warwar;
	import artur.units.UnitCache;
	import artur.util.GetServerData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Server.Lang;

	
	
	import Utils.Functions;
	import Utils.json.JSON2;
	import flash.text.TextField;
	
	public class WinArena {
		public var bin:Boolean = false;
		private var bg:MyBitMap;
		private var btn1:BaseButton;
		private var btnClose:BaseButton 
		private var mcFound:mcFounMovie = new mcFounMovie();
		public static const NEEDED_LVL:int = 2;
		private var btn1Title:TextField;
		private var dell1:int
		private var dell2:int
		private var char1:Object;
		private var char2:Object;
		private var types:Array = [U_Lyk,U_Mag,U_Paladin,U_Warwar,U_Lyk,U_Mag,U_Paladin,U_Warwar];
		public function WinArena() {
			bg = new MyBitMap(App.prepare.cach[39]);
			btn1 = new BaseButton(40);
			btn1.x = 400;
			btn1.y = 100;
			btnClose = new BaseButton(31);
			mcFound.x = 400;
			mcFound.y = 250;
			mcFound.gotoAndStop(1);
		}
		
		private function onBtnClose(e:MouseEvent):void {
			App.info.frees();
			App.lock.init();
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, this.onRes1);
			data.sendData(COMMANDS.FIND_BATTLE, "", true);
		}
		
		private function onRes1(e:DataExchangeEvent):void {
			App.spr.removeChild(mcFound);
			mcFound.gotoAndStop(1);
			App.spr.removeChild(btnClose);
			App.lock.frees();
		}
		
		private function onBtn(e:MouseEvent):void {
			App.info.frees();
			if(UserStaticData.hero.level >= WinArena.NEEDED_LVL && GetServerData.getUserIsReadyToBattle()) {
				mcFound.rotation = 0;
				mcFound.rot.visible = false;
				mcFound.gotoAndPlay(1);
				App.spr.addChild(mcFound);
				App.spr.addChild(btnClose);
				btnClose.x = e.currentTarget.x;
				btnClose.y = e.currentTarget.y + 50;
				var data:DataExchange = new DataExchange();
				data.addEventListener(DataExchangeEvent.ON_RESULT, this.onRes);
				data.sendData(COMMANDS.FIND_BATTLE, "", true);
				App.lock.init();
				
			} else {
				if(UserStaticData.hero.level < WinArena.NEEDED_LVL) {
					App.closedDialog.init1(Lang.getTitle(44), false, true);
				} else if(!GetServerData.getUserIsReadyToBattle()) {
					App.closedDialog.init1(Lang.getTitle(36), true);
				}
			}
		}
		
		private function onRes(e:DataExchangeEvent):void {
			var obj:Object = JSON2.decode(e.result);
			if (obj.res == null) {
				App.spr.removeChild(this.mcFound);
				App.spr.removeChild(this.btnClose);
				App.lock.init("ERRRORRRR!!!!!!");
			} else {
				App.lock.frees();
			}
		}
		
		public function init():void {
			dell1 =40;
			dell2 = 60;
			
			App.swapMuz('MenuSong');
			App.spr.addChild(bg);
		    App.spr.addChild(btn1);
			mcFound.gotoAndStop(1);
			mcFound.rotation = 0;
			mcFound.rot.visible = false;
			App.topPanel.init(this);
			App.topMenu.init(true, true);
			char1 = UnitCache.getUnit('Barbarian');
			char1.x = 290;
			char1.y = 380;
			char2 = UnitCache.getUnit('Paladin');
			char2.x = 800 - 290;
			char2.y = 380;
			char2.itemUpdate([RandomInt(0,5), RandomInt(0,5), RandomInt(0,5), RandomInt(0,5), RandomInt(0,5), RandomInt(0,5), RandomInt(0,5), RandomInt(0,5), RandomInt(0,5), RandomInt(0,5), RandomInt(0,5), RandomInt(0,5), RandomInt(0,5), RandomInt(0,5)]);
			char1.itemUpdate([RandomInt(0,5), RandomInt(0,5), RandomInt(0,5), RandomInt(0,5), RandomInt(0,5), RandomInt(0,5), RandomInt(0,5), RandomInt(0,5), RandomInt(0,5), RandomInt(0,5), RandomInt(0,5), RandomInt(0,5), RandomInt(0,5), RandomInt(0,5)]);
			char2.scaleX = -1;
			App.spr.addChild(Sprite(char2));
			App.spr.addChild(Sprite(char1));
			btn1.addEventListener(MouseEvent.CLICK, onBtn);
			btnClose.addEventListener(MouseEvent.CLICK, onBtnClose);
			btn1.addEventListener(MouseEvent.ROLL_OVER, this.onBattleOver);
			btn1.addEventListener(MouseEvent.ROLL_OUT, this.onBattleBtnOut);
		}
		
		private function onBattleBtnOut(e:MouseEvent):void {
			App.info.frees();
		}
		
		private function onBattleOver(e:MouseEvent):void {
			var mc:BaseButton = BaseButton(e.target);
			App.info.init(mc.x + mc.width - 130, mc.y + mc.height - 25, { txtInfo_w:110, txtInfo_h:37, txtInfo_t:Lang.getTitle(51), type:0 });
		}
		
		public function update():void {
			if (mcFound.currentFrame == mcFound.totalFrames) {
				mcFound.rotation += 2;
				mcFound.rot.visible = true;
				mcFound.rot.rotation = -mcFound.rotation; 
			}
			char1.update();
			char2.update();
			if (dell1-- < 0)
			{
				dell1 = 80;
			     char1.gotoAndPlay('atack1' )
			}
			if (dell2-- <0)
			{
				dell2 =  60;
				char2.gotoAndPlay('atack1' );
			}
		}
		
		public function frees():void {
			char1.frees();
			char2.frees();
			App.info.frees();
			btn1.removeEventListener(MouseEvent.CLICK, onBtn);
			btnClose.removeEventListener(MouseEvent.CLICK, onBtnClose);
			btn1.removeEventListener(MouseEvent.ROLL_OVER, this.onBattleOver);
			btn1.removeEventListener(MouseEvent.ROLL_OUT, this.onBattleBtnOut);
		}
		
		static public function Random(clow:Number, chigh:Number):Number
	    {
	       return Math.round(Math.random() * (chigh - clow)) + clow;
	    }
 
	    //Получить целое случайное число из диапазона clow..chigh
	     static public function RandomInt(clow:int, chigh:int):int
	    {
	       return Math.round(Random(clow,chigh));
	    }
	}
	  

}