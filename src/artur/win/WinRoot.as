package artur.win 
{
	import artur.App;
	import artur.display.BaseButton;
	import artur.display.battle.eff.EffManajer;
	import artur.display.MyBitMap;
	import artur.PrepareGr;
	import artur.units.U_Warwar;
	import artur.units.UnitCache;
	import Chat.ChatBasic;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.DRMMetadataEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import report.Report;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	
	public class WinRoot 
	{
		public var bin:Boolean;
		public var bg:Bitmap ;
		private var btns:Array = [];
		private var mcText:mcTextRootWin = new mcTextRootWin();
		
		public function WinRoot() 
		{
			bg = new MyBitMap(App.prepare.cach[0]);
			bg.x = -33; bg.y = -33;
			var indxBtn:Array = [btn_Bank, btn_Top, btn_Castle, btn_Arena, btn_Shop, btn_Mision];
			var xps:Array       = [127.8 , 562.35, 312.5, 153.9 , 520, 351];
			var yps:Array       = [86.7   , 66.5   , 92.7  , 263.3, 233.2, 0.65];
			var names:Array = ['bank','top','castle','arena','shop','map'];
			for (var i:int = 0; i < indxBtn.length; i++) 
			{
				var btn:MovieClip= new indxBtn[i]();
				btn.x = xps[i] ; btn.y = yps[i];
				btn.name = names[i];
				btns.push(btn);
				btn.mouseChildren = false;
				btn.tabChildren = false;
				btn.tabEnabled = false;
				btn.gotoAndStop(1);
				btn.buttonMode = true;
				btn.addEventListener(MouseEvent.CLICK, clickOnBtn);
				btn.addEventListener(MouseEvent.MOUSE_OVER, onOverBtn);
				btn.addEventListener(MouseEvent.MOUSE_OUT, onOutBtn);
				btn.addEventListener(MouseEvent.MOUSE_DOWN, onDownBtn);
				btn.addEventListener(MouseEvent.MOUSE_UP, onUpBtn);11111
			}
			
		}
		
		private function onUpBtn(e:MouseEvent):void 
		{
			MovieClip(e.target).gotoAndStop(2);
		}
		
		private function onDownBtn(e:MouseEvent):void 
		{
			MovieClip(e.target).gotoAndStop(3);
		}
		
		private function onOutBtn(e:MouseEvent):void 
		{
			MovieClip(e.target).gotoAndStop(1);
		}
		
		private function onOverBtn(e:MouseEvent):void 
		{
			MovieClip(e.target).gotoAndStop(2);
		}
		
		private function clickOnBtn(e:MouseEvent):void 
		{
			App.sound.playSound('click2', App.sound.onVoice, 1);
			switch(e.currentTarget.name)
			{
				case 'map':
					App.winManajer.swapWin(2);
					break;
				case 'castle':
					App.winManajer.swapWin(1);
					break;
				case 'arena':
					App.lock.init("Ожидание боя");
					this.goBattle();
					break;
			}
		}
		
		private function goBattle():void 
		{
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, this.onRes);
			data.sendData(COMMANDS.FIND_BATTLE, "", true);
		}
		
		private function onRes(e:DataExchangeEvent):void 
		{
			DataExchange(e.target).removeEventListener(e.type, onRes);
			App.lock.init(e.result);
		}
		public function init():void
		{
			mcText.txtAtack.text = String(UserStaticData.hero.skills.attack);
			mcText.txtDeff.text =   String(UserStaticData.hero.skills.defence);
		    mcText.txtMana.text = String (UserStaticData.hero.skills.energy);
		    mcText.txtAvatarLevel.text = String(UserStaticData.hero.level);
			mcText.txtGold.text = String(UserStaticData.hero.gold);
			mcText.txtSilver.text = String(UserStaticData.hero.silver);
			updateBar();
			App.spr.addChild(bg);
			App.spr.addChild(mcText);
			for (var i:int = 0; i < btns.length; i++) 
			{
				App.spr.addChild(btns[i]);
			}
		}
		private function updateBar():void
		{
			var hero:Object = UserStaticData.hero;
			var maxEn:int = hero.skills.vitality;
			var currEn:int = hero.cur_vitality;
			var maxExp:int = UserStaticData.levels[hero.level]; // <--
			var currExp:int = hero.exp;//UserStaticData.hero.exp;
			mcText.txtExp.text = String(currExp + '/' + maxExp);
			mcText.txtVit.text = String(currEn + '/' + maxEn);
			mcText.expBar.gotoAndStop(int(currExp /maxExp* 100) + 1);
			mcText.vitBar.gotoAndStop(int(maxEn / currEn * 100) + 1);
		}
		public function update():void
		{
			//bg.rotation += 0.1;
		}
		public function frees():void
		{
			
		}
		
	}

}