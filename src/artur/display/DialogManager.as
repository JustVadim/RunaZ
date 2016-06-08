package artur.display 
{
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.Lang;
	import artur.App;
	import artur.win.WinFortuna;
	import artur.win.WinKyz;
	import flash.display.Sprite;
	import report.Report;
	public class DialogManager extends Sprite {
		
		private var show_person_lvl_up:Boolean = false;
		private var show_unit_lvl_up:Boolean = false;
		private var show_task:Boolean = false;
		
		private var show_show_achieve:Boolean = false;
		private var showKyzZakaz:Boolean = false;
		private var showKyzGift:Boolean = false;
		public var show_bonus:Boolean = false;
		
		public function DialogManager() {
			
		}
		
		public function init():void {
			this.checkPerson();
			this.checkTask();
			this.checkUnits();
			this.checkBonus();
			this.checkAchievement();
		}
		
		
		public function canShow():void {
			if (!App.winManajer.swapMode) {
				if (show_bonus) {
					App.bomusDialog.init(0);
					this.show_bonus = false;
					return;
				}
				
				if(show_task) {
					App.task.init();
					this.show_task = false;
					return;
				}
				
				if (this.show_person_lvl_up ) {
					this.show_person_lvl_up = false;
					if(App.winManajer.currWin != 0) {
						App.closedDialog.init1(Lang.getTitle(2), false, false, false, false, true, false, false, false, true);
					} else {
						
					}
					return;
				}
				
				if(show_unit_lvl_up) {
					App.closedDialog.init1(Lang.getTitle(2), true);
					this.show_unit_lvl_up = false;
					return;
				}
				
				if (show_show_achieve) {
					this.showAchieveLvlUp();
					this.show_show_achieve = false;
					return;
				}
				
				if (UserStaticData.hero.level > 1 && WinFortuna.dt == 0 && WinFortuna.dialogChecked) {
					App.closedDialog.init1(Lang.getTitle(24), false, false, false, false, true, true);
					WinFortuna.dialogChecked = false;
					return;
				}
				
				if (UserStaticData.hero.demo > 4) {
					if(this.showKyzZakaz) {
						App.closedDialog.init1(Lang.getTitle(206), false, false, false, false, true, false, false, true);
						this.showKyzZakaz = false;
						return;
					}
					
					if (this.showKyzGift) {
						this.showKyzGift = false;
						if (App.winManajer.currWin != 4) {
							App.closedDialog.init1(Lang.getTitle(206), false, false, false, false, true, false, false, true);
						} else {
							
						}
						return;
					}
				}
				
			}
			
		}
		
		private function showAchieveLvlUp():void {
			var achNum:int;
			var achLvl:int;
			for (var i:int = 0; i < HeroAchievments.ACHIEVMENTS_QTY; i++) {
				var ach:Object = UserStaticData.hero.ach[i];
				if (ach.q >= UserStaticData.achievments_table[i][ach.s]) {
					App.achivDialog.init(i, ach.s + 1);
					break;
				}
			}
			
			
			
			
			
		}
		
		public function checkAchievement():void {
			for (var i:int = 0; i < HeroAchievments.ACHIEVMENTS_QTY; i++) {
				var ach:Object = UserStaticData.hero.ach[i];
				if(ach.s != 3) {
					if (ach.q >= UserStaticData.achievments_table[i][ach.s]) {
						show_show_achieve = true;
						break;
					}
				}
			}
		}
		
		private function checkBonus():void {
			if(UserStaticData.hero.sett.app_i == 1 && UserStaticData.hero.sett.app_m == 1 && UserStaticData.hero.sett.app_g && UserStaticData.hero.sett.app_fq > 9) {
				new DataExchange().sendData(COMMANDS.CHECK_FRIENDS_BONUS, "", false);
			}
		}
		
		
		public function checkTask():void {
			if(UserStaticData.hero.t.tn == 0){
				return;
			}
			if(UserStaticData.hero.t.tp == 0 || UserStaticData.hero.t.tp==UserStaticData.hero.t.pa) {
				show_task = true;
			}
			if (UserStaticData.hero.t.tp > UserStaticData.hero.t.pa) {
				Main.THIS.chat.removeBtn();
			} else {
				Main.THIS.chat.addBtn();
			}
		}
		
		public function checkUnits():void {
			show_unit_lvl_up = UserStaticData.hero.checkLevelUp();
		}
		
		public function checkPerson():void {
			this.show_person_lvl_up = UserStaticData.hero.fs > 0;
		}
		
		public function checkKyzZakaz():void {
			this.showKyzZakaz = WinKyz.dt == 0 && UserStaticData.hero.gold >= 3;
		}
		
		public function checkKyzGift():void {
			this.showKyzGift = WinKyz.dt_gift == 0;
		}
	}

}