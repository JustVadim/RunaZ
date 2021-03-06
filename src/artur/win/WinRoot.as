package artur.win 
{
	import Chat.UserInListDialog;
	import _SN_vk.events.CustomEvent;
	import artur.App;
	import artur.RasterClip;
	import artur.display.BaseButton;
	import artur.display.battle.eff.EffManajer;
	import artur.display.SprUserNewLevel;
	import artur.display.WinRootMcText;
	import artur.PrepareGr;
	import artur.units.U_Warwar;
	import artur.units.UnitCache;
	import Chat.ChatBasic;
	import datacalsses.Hero;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getQualifiedClassName;
	import report.Report;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Server.Lang;
	import Utils.Functions;
	
	public class WinRoot 
	{
		public var bin:Boolean;
		public var bg:Bitmap ;
		private var btns:Array = [];
		private var mcText:WinRootMcText = new WinRootMcText();
		public static var lvlUp:SprUserNewLevel = new SprUserNewLevel();
		private var indxBtn:Array = [btn_Bank, btn_Top, btn_Castle, btn_Arena, btn_Shop, btn_Mision, btnCave];
		
		public function WinRoot() {
			this.bg = RasterClip.getBitmap(new bg1Root());
			this.bg.x = bg.y = -33;
			var xps:Array = [176.05 ,607.65 , 395.1, 206.2 , 578.35, 394.5, 300.7];
			var yps:Array = [214.75  , 218  , 291.25 , 367, 367.35, 89.15, 126.1];
			var names:Array = ['bank','top','castle','arena','shop','map', 'cave'];
			for (var i:int = 0; i < indxBtn.length; i++) {
				var btn:MovieClip = new indxBtn[i]();
				Functions.SetPriteAtributs(btn, true, false, xps[i], yps[i]);
				btn.name = names[i];
				btns.push(btn);
				btn.gotoAndStop(1);
				btn.buttonMode = true;
				btn.addEventListener(MouseEvent.CLICK, clickOnBtn);
				btn.addEventListener(MouseEvent.ROLL_OVER, onOverBtn);
				btn.addEventListener(MouseEvent.ROLL_OUT, onOutBtn);
				btn.addEventListener(MouseEvent.MOUSE_DOWN, onDownBtn);
				btn.addEventListener(MouseEvent.MOUSE_UP, onUpBtn);
			}
		}
		
		private function onUpBtn(e:MouseEvent):void {
			MovieClip(e.target).gotoAndStop(2);
		}
		
		private function onDownBtn(e:MouseEvent):void {
			MovieClip(e.target).gotoAndStop(3);
		}
		
		private function onOutBtn(e:MouseEvent):void {
			MovieClip(e.target).gotoAndStop(1);
			App.info.frees();
		}
		
		private function onOverBtn(e:MouseEvent):void {
			MovieClip(e.target).gotoAndStop(2);
			var t:String;
			for (var i:int = 0; i < indxBtn.length; i++) {
				if (e.currentTarget is indxBtn[i]) {
					if(i==6) {
						t = Lang.getTitle(3, i+1);
					} else {
						t = Lang.getTitle(3, i);
					}
					break;
				}
			}
			App.info.init( e.currentTarget.x, e.currentTarget.y, { txtInfo_w:100, txtInfo_h:37, txtInfo_t:t, type:0 } );
		}
		
		private function clickOnBtn(e:MouseEvent):void {
			App.sound.playSound('click2', App.sound.onVoice, 1);
			switch(e.currentTarget.name){
			case 'map':
				App.winManajer.swapWin(2);
				break;
			case 'castle':
				App.winManajer.swapWin(1);
				break;
			case 'arena':
				App.winManajer.swapWin(5);
				break;
			case 'bank':
				App.winBank.init();
				break;
			case 'shop':
				App.winManajer.swapWin(4);
				break;
			case 'top':
				App.sprTop.init();
				break;
			case 'cave':
				App.winManajer.swapWin(7);
				break;
			}
			
		}
		
		private function goBattle():void {
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, this.onRes);
			data.sendData(COMMANDS.FIND_BATTLE, "", true);
		}
		
		private function onRes(e:DataExchangeEvent):void {
			DataExchange(e.target).removeEventListener(e.type, onRes);
			App.lock.init(e.result);
		}
		public function init():void {
			App.swapMuz('MenuSong');
			App.spr.addChild(bg);
			App.spr.addChild(mcText);
			App.topMenu.init(true, true);
			
			for (var i:int = 0; i < btns.length; i++) {
				App.spr.addChild(btns[i]);
			}
			this.updateBar();
			if(UserStaticData.hero.demo == 0 || UserStaticData.hero.demo == 1) {
				App.tutor.init(1);
			}
			//App.vipDialog.init();
		}
		
		public function updateBar():void {
			var hero:Hero = UserStaticData.hero;
			var maxVit:int = hero.skills.vitality*10;
			var currEn:int = hero.cur_vitality;
			var currExp:int = hero.exp;
			this.mcText.txtAtack.text = String(hero.skills.attack);
			this.mcText.txtEnergy.text = String(hero.skills.vitality);
			this.mcText.txtDeff.text =   String(hero.skills.defence);
		    this.mcText.txtMana.text = String (hero.skills.energy);
			App.topMenu.updateAva();
			if (hero.fs > 0) {
				WinRoot.lvlUp.init("Доступно: " + hero.fs) ;
			} else {
				WinRoot.lvlUp.frees();
			}
		}
		
		public function update():void {
			
		}
		
		public function frees():void {
			
		}
		
	}

}