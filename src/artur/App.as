package artur 
{
	import artur.display.BaseButton;
	import artur.display.ByeWin;
	import artur.display.CloseDialog;
	import artur.display.InfoWin;
	import artur.display.LockSpr;
	import artur.units.U_Warwar;
	import artur.units.UnitCache;
	import artur.util.RemindCursors;
	import artur.util.SoundManager;
	import artur.win.WinManajer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import report.Report;
	

	
	
	public class App extends Sprite
	{
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
		
		public static var sound:SoundManager = SoundManager.getInstance();
		public static var winManajer:WinManajer;
		public static var spr:Sprite;
		public static var prepare:PrepareGr = new PrepareGr();
		public static var btnOverFilter:GlowFilter = new GlowFilter(0xFFFFFF, 1, 4, 4, 5);
		public static var byeWin:ByeWin 
		public static var closedDialog:CloseDialog
	    static public var btns:Array = [];
		public static var btnRoot:BaseButton ;
		public static var info:InfoWin = new InfoWin();
		public static var lock:LockSpr = new LockSpr();
		public static var cursor:RemindCursors = new RemindCursors();
		public function App(stg:Stage) 
		{
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
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			byeWin = new ByeWin();
			closedDialog = new CloseDialog();
			btnRoot = new BaseButton(14); btnRoot.x = 400; btnRoot.y = 10;
			btnRoot.addEventListener(MouseEvent.CLICK, onRoot);
			cursor.addCursor(mcCursorArrow, 'arr');
			cursor.addCursor(mcCursorHand, 'hand');		
			cursor.changeCursor('arr');
			cursor.setButtonCursor('arr', 'hand', stg);	
			this.tabEnabled = false;
			this.tabChildren = false;
			//App.spr.alpha = 0.5;
		}
		
		private function onRoot(e:MouseEvent):void 
		{
			App.winManajer.swapWin(0);
		}
		
		private function mouseUp(e:MouseEvent):void 
		{
			for (var i:int = 0; i < btns.length; i++) 
			{
				btns[i].scaleX = 1;
				btns[i].scaleY = 1;
			}
		}
		
		private function update(e:Event):void 
		{
			info.update();
			winManajer.update();
			UnitCache.update();
			spr.addChild(cursor);
		}
		public static function clear():void
		{
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