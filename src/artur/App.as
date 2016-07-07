package artur 
{
	import artur.display.AchivDialog;
	import artur.display.BaseButton;
	import artur.display.BonusDialog;
	import artur.display.DialogManager;
	import artur.display.HeroAchievments;
	import artur.display.LevelUpDialog;
	import artur.display.Profile;
	import artur.display.battle.TopPanel;
	import artur.display.ByeWin;
	import artur.display.CloseDialog;
	import artur.display.InfoWin;
	import artur.display.LockSpr;
	import artur.display.PropExtended;
	import artur.display.SprTop;
	import artur.display.SprVip;
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
		[Embed(source = "../../bin/sounds/levelUp.mp3")]    private var s_levelUp:Class;
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
		[Embed(source = "../../bin/sounds/FortunaWin.mp3")] private var s_fortuna_win:Class;
		[Embed(source = "../../bin/sounds/FortunaLose.mp3")] private var s_fortuna_lose:Class;
		
		
		public static var currMuzPlay:String = 'BatleSong';
		public static var prepare:PrepareGr;
		public static var sound:SoundManager;
		public static var winManajer:WinManajer;
		public static var spr:Sprite;
		public static var btnOverFilter:GlowFilter;
		public static var byeWin:ByeWin 
		public static var closedDialog:CloseDialog
		public static var achivDialog:AchivDialog
		public static var info:InfoWin;
		public static var lock:LockSpr;
		public static var cursor:RemindCursors;
		public static var topPanel:TopPanel
		public static var winBank:WinBank;
		public static var tutor:Tutor;
		public static var topMenu:TopMenu;
		public static var task:Task;
		public static var prop:PropExtended;
		public static var upPanel:UpPanel;
		public static var bomusDialog:BonusDialog;
		public static var profile:Profile;
		public static var achievm:HeroAchievments;
		public static var dialogManager:DialogManager;
		public static var sprTop:SprTop
		public static var levelUpDialog:LevelUpDialog;
		public static var vipDialog:SprVip 
		
		public function App(stg:Stage) 
		{
			this.tabEnabled = false;
			this.tabChildren = false;
			App.sound 		= SoundManager.getInstance();
			this.prepareSound();
			App.prepare = new PrepareGr();
			App.btnOverFilter = new GlowFilter(0xFFFFFF, 1, 4, 4, 5);
			App.info = new InfoWin();
			App.lock = new LockSpr();
			App.cursor = new RemindCursors();
			App.topPanel = new TopPanel();
			App.winBank = new WinBank();
			App.tutor = new Tutor();
			App.topMenu = new TopMenu();
			App.prop = new PropExtended();
			App.byeWin = new ByeWin();
			App.achivDialog = new AchivDialog();
			App.task = new Task();
			App.sprTop = new SprTop();
			App.bomusDialog = new BonusDialog();
			App.profile = new Profile();
			App.achievm = new HeroAchievments();
			App.dialogManager = new DialogManager();
			App.spr = Sprite(this);
			App.closedDialog = new CloseDialog();
			App.winManajer = new WinManajer();
			vipDialog = new SprVip();
			Main.THIS.stage.addChild(App.upPanel = new UpPanel());
			cursor.addCursor(mcCursorArrow, 'arr');
			cursor.addCursor(mcCursorHand, 'hand');		
			cursor.changeCursor('arr');
			cursor.setButtonCursor('arr', 'hand', stg);
			this.addEventListener(Event.ENTER_FRAME, update);
			App.levelUpDialog = new LevelUpDialog();
			Main.THIS.addChild(App.upPanel = new UpPanel());
			App.dialogManager = new DialogManager();
			if(UserStaticData.from == "v") {
				Main.VK.addEventListener('onOrderSuccess', Main.onVkPayment);
				Main.VK.addEventListener('onSettingsChanged', App.upPanel.onVKSettingsChange);
			}
		}
		
		private function prepareSound():void {
			App.sound.addSound('EffMaxDamage', new EffMaxSound());
			App.sound.addSound('MaxSpeed', new EffSpeedSound());
			App.sound.addSound('achiv', new s_achiv());
			App.sound.addSound('onLose', new s_onLose());
			App.sound.addSound('BatleSong', new s_BatleSong());
			App.sound.addSound('MenuSong', new s_menuSong());
			App.sound.addSound('MapSong', new s_mapSong());
			App.sound.addSound('stone', new s_stone());
			App.sound.addSound('craft', new s_craft());
			App.sound.addSound('gDie', new s_g_die());
			App.sound.addSound('gAtack', new s_g_atack());
			App.sound.addSound('gHurt', new s_g_hurt());
			App.sound.addSound('magHurt', new s_mag_hurt());
			App.sound.addSound('magDie', new s_mag_die());
			App.sound.addSound('sw', new s_Switok());
			App.sound.addSound('botl', new s_useBotl());
			App.sound.addSound('cnock', new s_Cnock());
			App.sound.addSound('move', new s_Move());
			App.sound.addSound('over1', new Over());
			App.sound.addSound('click1', new Click());
			App.sound.addSound('over3', new Over3());
			App.sound.addSound('click3', new Click3());
			App.sound.addSound('overItem', new over_item());
			App.sound.addSound('gold', new S_Gold());
			App.sound.addSound('gloves1', new S_Gloves1());
			App.sound.playSound('gloves1', App.sound.onVoice, 1);
			App.sound.addSound('inventar', new s_inventar());
			App.sound.addSound('bot1_attack', new bot1_attack());
			App.sound.addSound('bot1_hurt', new bot1_hurt());
			App.sound.addSound('bot1_init', new bot1_Init());
			App.sound.addSound('bot1_fs1', new bot1_fs1);
			App.sound.addSound('bot1_fs2', new bot1_fs2);
			App.sound.addSound('bot1_die', new s_bot1_die());
			App.sound.addSound('bow1', new Bow1());
			App.sound.addSound('pall_hurt', new s_pall_hurt());
			App.sound.addSound('pall_death', new s_pall_death());
			App.sound.addSound('fow1', new Fow1());
			App.sound.addSound('fow2', new Fow2());
			App.sound.addSound('blade1', new Blade1());
			App.sound.addSound('blade2', new Blade2());
			App.sound.addSound('war_hurt', new s_war_hurt());
			App.sound.addSound('win', new s_win());
			App.sound.addSound('shok', new s_shok());
			App.sound.addSound('battle_cry', new BattleCry());
			App.sound.addSound('eff_heal', new s_effHill());
			App.sound.addSound('eff_arrow', new SoundEffArrow());
			App.sound.addSound('skillUp', new upSkill());
			App.sound.addSound('over2', new Over2);
			App.sound.addSound('click2', new CLick2);
			App.sound.addSound('golemAtack', new GolemAtack);
			App.sound.addSound('golemHurt', new GolemHurt );
			App.sound.addSound('fortuna_win', new s_fortuna_win );
			App.sound.addSound('fortuna_lose', new s_fortuna_lose );
			App.sound.addSound('levelUp', new s_levelUp);
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