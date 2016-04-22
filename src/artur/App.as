package artur 
{
	import artur.display.AchivDialog;
	import artur.display.BaseButton;
	import artur.display.BonusDialog;
	import artur.display.DialogManager;
	import artur.display.HeroAchievments;
	import artur.display.Profile;
	import artur.display.battle.TopPanel;
	import artur.display.ByeWin;
	import artur.display.CloseDialog;
	import artur.display.InfoWin;
	import artur.display.LockSpr;
	import artur.display.PropExtended;
	import artur.display.Task;
	import artur.display.TopMenu;
	import artur.display.Tutor;
	import artur.display.UpPanel;
	import artur.units.U_Warwar;
	import artur.units.UnitCache;
	import artur.util.RemindCursors;
	import artur.util.SoundManager;
	import artur.win.WinBank;
	import artur.win.WinManajer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import report.Report;
	
	public class App extends Sprite
	{
		[Embed(source = "../../bin/sounds/useBotle.mp3")]    private var s_useBotl:Class;
		[Embed(source = "../../bin/sounds/Switok.mp3")]    private var s_Switok:Class;
		[Embed(source = "../../bin/sounds/BramaCnock.mp3")]    private var s_Cnock:Class;
		[Embed(source = "../../bin/sounds/BramaMove.mp3")]      private var s_Move:Class;
		[Embed(source = "../../bin/sounds/overItem.mp3")]          private var over_item:Class;
		[Embed(source = "../../bin/sounds/inventar.mp3")]              private var s_inventar:Class;
		
		[Embed(source = "../../bin/sounds/Pall_Death.mp3")] private var s_pall_death:Class;
		[Embed(source = "../../bin/sounds/Pall_Hurt.mp3")] private var s_pall_hurt:Class;
		[Embed(source = "../../bin/sounds/War_hurt.mp3")] private var s_war_hurt:Class;
		[Embed(source = "../../bin/sounds/Win.mp3")] private var s_win:Class;
		[Embed(source = "../../bin/sounds/shock.mp3")] private var s_shok:Class;
		[Embed(source="../../bin/sounds/bot1_die.mp3")] private var s_bot1_die:Class;
		[Embed(source = "../../bin/sounds/MagHurt.mp3")] private var s_mag_hurt:Class;
		[Embed(source = "../../bin/sounds/magDie.mp3")] private var s_mag_die:Class;
		[Embed(source = "../../bin/sounds/GhostHurt.mp3")] private var s_g_hurt:Class;
		[Embed(source = "../../bin/sounds/GhostDie.mp3")] private var s_g_die:Class;
		[Embed(source = "../../bin/sounds/GhostAtack.mp3")] private var s_g_atack:Class;
		[Embed(source = "../../bin/sounds/stone.mp3")] private var s_stone:Class;
		[Embed(source = "../../bin/sounds/rare.mp3")] private var s_craft:Class;
		[Embed(source = "../../bin/sounds/BatleSong.mp3")] private var s_BatleSong:Class;
		[Embed(source = "../../bin/sounds/menuSong.mp3")] private var s_menuSong:Class;
		[Embed(source = "../../bin/sounds/mapSong.mp3")] private var s_mapSong:Class;
		[Embed(source = "../../bin/sounds/onLose.mp3")] private var s_onLose:Class;
		[Embed(source = "../../bin/sounds/achiv.mp3")] private var s_achiv:Class;
		public static var sound:SoundManager = SoundManager.getInstance();
		public static var winManajer:WinManajer;
		public static var spr:Sprite;
		public static var prepare:PrepareGr = new PrepareGr();
		public static var btnOverFilter:GlowFilter = new GlowFilter(0xFFFFFF, 1, 4, 4, 5);
		public static var byeWin:ByeWin 
		public static var closedDialog:CloseDialog
		public static var achivDialog:AchivDialog
	   // static public var btns:Array = [];
		public static var info:InfoWin = new InfoWin();
		public static var lock:LockSpr = new LockSpr();
		public static var cursor:RemindCursors = new RemindCursors();
		public static var topPanel:TopPanel = new TopPanel();
		public static var winBank:WinBank = new WinBank();
		public static var tutor:Tutor = new Tutor();
		public static var topMenu:TopMenu = new TopMenu();
		public static var task:Task;
		//public static var topMenu:
		public static var currMuzPlay:String = 'BatleSong';
		public static var prop:PropExtended = new PropExtended();
		public static var upPanel:UpPanel;
		public static var bomusDialog:BonusDialog;
		public static var profile:Profile;
		public static var achievm:HeroAchievments;
		public static var dialogManager:DialogManager;
		
		
		public function App(stg:Stage) 
		{
			sound.addSound('achiv', new s_achiv());
			sound.addSound('onLose', new s_onLose());
			sound.addSound('BatleSong', new s_BatleSong());
			sound.addSound('MenuSong', new s_menuSong());
			sound.addSound('MapSong', new s_mapSong());
			
			sound.addSound('stone', new s_stone());
			sound.addSound('craft', new s_craft());
			sound.addSound('gDie', new s_g_die());
			sound.addSound('gAtack', new s_g_atack());
			sound.addSound('gHurt', new s_g_hurt());
			sound.addSound('magHurt', new s_mag_hurt());
			sound.addSound('magDie', new s_mag_die());
			sound.addSound('sw', new s_Switok());
			sound.addSound('botl', new s_useBotl());
			sound.addSound('cnock', new s_Cnock());
			sound.addSound('move', new s_Move());
			sound.addSound('over1', new Over());
			sound.addSound('click1', new Click());
			sound.addSound('over3', new Over3());
			sound.addSound('click3', new Click3());
			sound.addSound('overItem', new over_item());
			sound.addSound('gold', new S_Gold());
			sound.addSound('gloves1', new S_Gloves1());
			sound.addSound('inventar', new s_inventar());
			sound.addSound('bot1_attack', new bot1_attack());
			sound.addSound('bot1_hurt', new bot1_hurt());
			sound.addSound('bot1_init', new bot1_Init());
			sound.addSound('bot1_fs1', new bot1_fs1);
			sound.addSound('bot1_fs2', new bot1_fs2);
			sound.addSound('bot1_die', new s_bot1_die());
			sound.addSound('bow1', new Bow1());
			sound.addSound('pall_hurt', new s_pall_hurt());
			sound.addSound('pall_death', new s_pall_death());
			sound.addSound('fow1', new Fow1());
			sound.addSound('fow2', new Fow2());
			sound.addSound('blade1', new Blade1());
			sound.addSound('blade2', new Blade2());
			sound.addSound('war_hurt', new s_war_hurt());
			sound.addSound('win', new s_win());
			sound.addSound('shok', new s_shok());
			sound.addSound('battle_cry', new BattleCry());
			sound.addSound('eff_heal', new s_effHill());
			sound.addSound('eff_arrow', new SoundEffArrow());
			sound.addSound('skillUp', new upSkill());
			sound.addSound('over2', new Over2);
			sound.addSound('click2', new CLick2);
			sound.addSound('golemAtack', new GolemAtack);
			sound.addSound('golemHurt', new GolemHurt );
			spr = Sprite(this);
			winManajer = new WinManajer();
			this.addEventListener(Event.ENTER_FRAME, update);
			byeWin = new ByeWin();
			closedDialog = new CloseDialog();
			achivDialog = new AchivDialog();
			cursor.addCursor(mcCursorArrow, 'arr');
			cursor.addCursor(mcCursorHand, 'hand');		
			cursor.changeCursor('arr');
			cursor.setButtonCursor('arr', 'hand', stg);	
			this.tabEnabled = false;
			this.tabChildren = false;
			App.task = new Task();
			App.bomusDialog = new BonusDialog();
			App.profile = new Profile();
			App.achievm = new HeroAchievments();
			Main.THIS.addChild(App.upPanel = new UpPanel());
			App.dialogManager = new DialogManager();
			if(UserStaticData.from == "v") {
				Main.VK.addEventListener('onOrderSuccess', Main.onVkPayment);
				Main.VK.addEventListener('onSettingsChanged', App.upPanel.onVKSettingsChange);
			}

		}
		
		public static function swapMuz(str:String):void {
			if (str == currMuzPlay)
				return;
			sound.stopSound(currMuzPlay);
			sound.playSound(str, sound.onSound);
			currMuzPlay = str;
		}
		
		private function update(e:Event):void {
			info.update();
			winManajer.update();
			UnitCache.update();
		}
		public static function clear():void {
			while (spr.numChildren > 0)
			 spr.removeChildAt(0);
		}
		public static function dellFromArr(obj:Object,arr:Array):void
		{
			for (var i:int = 0; i < arr.length; i++) 
			{
				if (arr[i] == obj)
				 {
					 arr.splice(i, 1);
				 }
			}
		}
		
	}

}