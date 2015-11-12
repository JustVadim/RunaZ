package artur.win 
{
	import artur.App;
	import artur.display.battle.AttackNode;
	import artur.display.battle.BattleChat;
	import artur.display.battle.BattleGrid;
	import artur.display.battle.eff.BaseEff;
	import artur.display.battle.eff.BotleManaEff;
	import artur.display.battle.eff.EffManajer;
	import artur.display.battle.eff.SwAtackEff;
	import artur.display.battle.eff.SwDeffEff;
	import artur.display.battle.LifeManajer;
	import artur.display.battle.MoveUnit;
	import artur.display.battle.Node;
	import artur.display.battle.TopPanelBattle;
	import artur.display.GiftDialog;
	import artur.display.HeroInventar;
	import artur.display.Slot;
	import artur.PrepareGr;
	import artur.RasterClip;
	import artur.units.U_Warwar;
	import artur.units.UnitCache;
	import artur.util.Maker;
	import artur.util.RemindCursors;
	import Chat.ChatBasic;
	import com.greensock.events.LoaderEvent;
	import datacalsses.Hero;
	import Enums.Items;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import report.Report;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Utils.json.JSON2;
	import artur.util.Maker;

	public class WinBattle 
	{
		private var bgs:Array = [RasterClip.raster(new Bg_Battle_1(),820,600)];
		public var grid:BattleGrid = new BattleGrid();
		public static var units:Array;
		public static var myTeam:int;
		public static var arrow:mcArrow = new mcArrow();
		public static var spr:Sprite = new Sprite();
		public static var bat:Object;
		public static var inst:WinBattle;
		public var mover:MoveUnit = new MoveUnit();
		public static var currUnit:Object; 
		public static var anim:Array = new Array();
		static public var sortArr:Array = new Array();
		public static var atackNode:AttackNode;
		public static var effManajer:EffManajer = new EffManajer();
		public var lifeManajer:LifeManajer  = new LifeManajer();
		public  var chekLifeBar:CheckLife = new CheckLife();
		public var bin:Boolean = false;
		private var unitsInWin:Array = [];
		public static var winAfterBattle:mcAfterBattle = new mcAfterBattle();
		public static var looseAfterBattle:mcAfterBattleLose = new mcAfterBattleLose();
		public static var inv_bg:mcBgBatleInventar = new mcBgBatleInventar();
		public static var hero_inv:HeroInventar;
		private static var ult_btn:UltSkillPanel = new UltSkillPanel();
		private static var inv_btns:Array = [new Panel_Inv, new Panel_Inv, new Panel_Inv, new Panel_Inv];
		private var ult_clicked:Boolean = false;
		public static var battleChat:BattleChat = new BattleChat();
		public static var sprGift:GiftDialog;
		private var gift_id:int = 0;
		public var topPanel:TopPanelBattle;
		public var bigLifeBar:mcBigLifeBar = new mcBigLifeBar();
		public function WinBattle() 
		{
			WinBattle.winAfterBattle.btn.addEventListener(MouseEvent.CLICK, this.onCloseWin);
			WinBattle.sprGift = new GiftDialog(this.onCloseWin);
			WinBattle.looseAfterBattle.btn.addEventListener(MouseEvent.CLICK, this.onCloseWin);
			WinBattle.winAfterBattle.tabChildren = WinBattle.winAfterBattle.tabEnabled = WinBattle.looseAfterBattle.tabChildren = WinBattle.looseAfterBattle.tabEnabled = false;
			WinBattle.hero_inv = new HeroInventar(true);
			inst = this;
			bigLifeBar.y = 528.2;
			bigLifeBar.x = -443.9;
			arrow.gotoAndStop(1);
			atackNode = new AttackNode();
			this.chekLifeBar.buttonMode = true;
			WinBattle.battleChat.addChild(ult_btn);
			WinBattle.ult_btn.x = 719.8; WinBattle.ult_btn.y = 514.2;
			WinBattle.ult_btn.stop();
			WinBattle.ult_btn.buttonMode = WinBattle.ult_btn.mouseChildren = WinBattle.ult_btn.tabEnabled = WinBattle.ult_btn.tabChildren = this.chekLifeBar.tabEnabled = this.chekLifeBar.tabChildren = false;
			for (var i:int = 0; i < WinBattle.inv_btns.length; i++) 
			{
				var mc:Panel_Inv = WinBattle.inv_btns[i];
				mc.x = 456.3 + 66.3*i;
				mc.y = 546.2;
				mc.gotoAndStop(1);
				mc.name = i.toString();
				mc.mouseChildren = mc.tabEnabled = mc.tabChildren = false;
				WinBattle.battleChat.addChild(mc);
			}
			this.topPanel = new TopPanelBattle(this);
			
		}
		
		private function onCloseWin(e:MouseEvent):void 
		{
			if (this.gift_id == 0) {
				App.winManajer.swapWin(2);
			} else {
				WinBattle.sprGift.init(this.gift_id);
				this.gift_id = 0;
				App.spr.removeChild(e.currentTarget.parent);
			}
		}
		
		private function checkCLick(e:MouseEvent):void 
		{
			if (MovieClip(e.currentTarget).currentFrame == 1)
			{
				e.currentTarget.gotoAndStop(2);
				if (e.currentTarget is CheckLife) {this.lifeManajer.showLB(true);}
				else if(bat['set'][bat.cus].t == myTeam) {Node(this.grid.nodes[0][0]).sendStep();}
				
			}
			else
			{
				e.currentTarget.gotoAndStop(1);
				if (e.currentTarget is CheckLife) {this.lifeManajer.hideLb();}
			}
		}
		
		private function outCheck(e:MouseEvent):void 
		{
			e.currentTarget.bg.alpha = 0.0;
		}
		
		private function overCheck(e:MouseEvent):void 
		{
			e.currentTarget.bg.alpha = 0.5;
		}
		
		public function init():void
		{
			this.gift_id = 0;
			this.unitsInWin = [];
			this.bin = true;
			WinBattle.units = [[], []];
			this.getMyTeam();
			App.spr.addChild(bgs[0]);
			App.spr.addChild(spr);
			this.addListenersToChekboks(this.chekLifeBar, 2);
			this.grid.init();
			this.lifeManajer.init();
			topPanel.init();
			this.setCurrStep();
			Main.THIS.chat.visible = false;
			Main.THIS.stage.addChild(WinBattle.battleChat);
			DataExchange.socket.addEventListener(DataExchangeEvent.BATTLE_MASSAGE, this.onBattleMassage);
			App.spr.addChild(bigLifeBar);
		}
		 
		 private function addListenersToChekboks(mc:MovieClip, frame:int, is_add:Boolean = true):void 
		 {
			if (is_add)
			{
				mc.gotoAndStop(frame);
				mc.addEventListener(MouseEvent.MOUSE_OVER, overCheck);
				mc.addEventListener(MouseEvent.MOUSE_OUT, outCheck);
				mc.addEventListener(MouseEvent.CLICK, checkCLick);
				App.spr.addChild(mc);
			}
			else
			{
				mc.removeEventListener(MouseEvent.MOUSE_OVER, overCheck);
				mc.removeEventListener(MouseEvent.MOUSE_OUT, outCheck);
				mc.removeEventListener(MouseEvent.CLICK, checkCLick);	
			}
		 }
		 
		 public function onBattleMassage(e:DataExchangeEvent):void 
		 {
			var obj:Object = JSON2.decode(e.result);
			WinBattle.anim.push(obj);
		 }
		 
		public function makeStep():void
		{
			var obj:Object = anim.shift();
			if (obj.m != null)
			{
				var is_r:Boolean;
				var type:int;
				var loc:Object = WinBattle.bat.locs[obj.m.u.t][obj.m.u.p];
				var unit:Object = WinBattle.bat.u[obj.m.u.t][obj.m.u.p];
				is_r = (unit.t_d == 1);
				type = unit.t;
				if (unit.b[5] != null)
				{
					delete(unit.b[5]);
					WinBattle.currUnit.hideBuff();
				}
				var path:Array = WinBattle.inst.grid.findPath(WinBattle.inst.grid.nodes[loc.x][loc.y], WinBattle.inst.grid.nodes[obj.m.x][obj.m.y]);
				WinBattle.inst.mover.init(path, obj, is_r, type);
				Node(this.grid.nodes[loc.x][loc.y]).walcable = 0;
				Node(this.grid.nodes[obj.m.x][obj.m.y]).walcable = 1;
				loc.x = obj.m.x;
				loc.y = obj.m.y;
				bat.cus = obj.n;
			}
			else if (obj.whm != null)
			{
				this.onUltimateData(obj)
			}
			else if (obj.ban != null)
			{
				this.useBanochka(obj);
			}
			else if(obj.is_w != null)
			{
				this.endBattle(obj)
			}
		}
		
		private function useBanochka(obj:Object):void {
			
			var hps:Object = WinBattle.bat.hps[obj.tu.t];
			var mps:Object = WinBattle.bat.mps[obj.tu.t];
			var unit:Object = WinBattle.bat.u[obj.tu.t][obj.tu.p];
			var hp:int = 0;
			var mp:int = 0;
			var banka:Object = UserStaticData.magazin_items[unit.t][Items.INVENTAR][obj.ban];
			var ef_coord:Object = bat.locs[obj.tu.t][obj.tu.p];
			var node:Node = WinBattle.inst.grid.nodes[ef_coord.x][ef_coord.y];
			if (banka.c[Items.INVENTAR_TYPE] == Items.INVENTAR_HPBANKA || banka.c[Items.INVENTAR_TYPE] == Items.INVENTAR_MPBANKA) 
			{
				
			    App.sound.playSound("botl", App.sound.onVoice, 1);
				if (banka.c[Items.INVENTAR_TYPE] == Items.INVENTAR_HPBANKA) {
					hps[obj.tu.p] = Math.min(hps[obj.tu.p] + banka.c[Items.BANOCHKATYPe_QTY], unit.hp);
					LifeManajer.un_Data[obj.tu.t][obj.tu.p].currLife = hps[obj.tu.p];
					EffManajer.effBotleHill.init(node.x, node.y);
				} else {
					mps[obj.tu.p] = Math.min(mps[obj.tu.p] + banka.c[Items.BANOCHKATYPe_QTY], unit.mp);
					LifeManajer.un_Data[obj.tu.t][obj.tu.p].currMana = mps[obj.tu.p];
					BotleManaEff(EffManajer.getEff('manaHill')).init(node.x, node.y)
				}
				LifeManajer.updateCurrLife(obj.tu.t, obj.tu.p);
				return;
			}
			if (banka.c[Items.INVENTAR_TYPE] == Items.INTENTAR_SVDeffence) 
			{
				App.sound.playSound("sw", App.sound.onVoice, 1);
				SwDeffEff(EffManajer.getEff('swDeff')).init(node.x, node.y);
				LifeManajer.updateCurrLife(obj.tu.t, obj.tu.p);
				return;
			}
			if (banka.c[Items.INVENTAR_TYPE] == Items.INTENTAR_SVAttack) 
			{
				App.sound.playSound("sw", App.sound.onVoice, 1);
				SwAtackEff(EffManajer.getEff('swAtack')).init(node.x, node.y);
				LifeManajer.updateCurrLife(obj.tu.t, obj.tu.p);
				return;
			}
			
		}
		
		private function onUltimateData(obj:Object):void {
			var ef_coord:Object;
			var node:Node;
			switch(obj.t) {
				case 0:
					App.sound.playSound("battle_cry", App.sound.onVoice, 1);
					ef_coord = bat.locs[obj.whm.t][obj.whm.p];
					node = WinBattle.inst.grid.nodes[ef_coord.x][ef_coord.y];
					U_Warwar(WinBattle.units[obj.whm.t][obj.whm.p]).showBuff(1);
					BaseEff(EffManajer.getEff("base")).init(WinBattle.spr, node.x, node.y, 2);
					bat.u[obj.wh.t][obj.wh.p].b[5] = new Object();
					break;
				case 1:
					App.sound.playSound("eff_heal", App.sound.onVoice, 1);
					ef_coord = bat.locs[obj.whm.t][obj.whm.p];
					node = WinBattle.inst.grid.nodes[ef_coord.x][ef_coord.y];
					BaseEff(EffManajer.getEff("base")).init(WinBattle.spr, node.x, node.y, 1);
					break;
				case 2:
					App.sound.playSound("eff_arrow", App.sound.onVoice, 1);
					ef_coord = bat.locs[obj.whm.t][obj.whm.p];
					node = WinBattle.inst.grid.nodes[ef_coord.x][ef_coord.y];
					BaseEff(EffManajer.getEff("base")).init(WinBattle.spr, node.x, node.y + 25, 3);
					break;
				case 3:
					ef_coord = bat.locs[obj.whm.t][obj.whm.p];
					node = WinBattle.inst.grid.nodes[ef_coord.x][ef_coord.y];
					EffManajer.showLgs(30, WinBattle.spr, 0xFFFFFF, node.x, node.y - 1000, node.x, node.y-40);
					EffManajer.lgs.update();
					var tim:Timer = new Timer(15, 15);
					tim.addEventListener(TimerEvent.TIMER, this.onLgsTimer);
					tim.addEventListener(TimerEvent.TIMER_COMPLETE, this.onLgsTimerCplt);
					tim.start();
					break;
			}
			//who unit
			var t_obj:Object = bat.mps[obj.wh.t];
			t_obj[obj.wh.p] = obj.mcl;
			LifeManajer.un_Data[obj.wh.t][obj.wh.p].currMana = obj.mcl;
			
			//whom unit
			t_obj = bat.hps[obj.whm.t];
			t_obj[obj.whm.p] = obj.hpl;
			LifeManajer.un_Data[obj.whm.t][obj.whm.p].currLife = obj.hpl;
			
			if (obj.t == 0 || obj.t == 1) {
				if (WinBattle.bat['set'][WinBattle.bat.cus].t == WinBattle.myTeam && !this.topPanel.isAuto() && WinBattle.anim.length == 0) {
					this.getControlAfterUlt(false);
				}
				LifeManajer.updateCurrLife(obj.wh.t, obj.wh.p);
				LifeManajer.updateCurrLife(obj.whm.t, obj.whm.p);
				return;
			}
			var hurt_unit:MovieClip = WinBattle.units[obj.whm.t][obj.whm.p];
			var tim1:Timer;;
			if (obj.t == 2) tim1 = new Timer(470, 1);
			else if (obj.t == 3) tim1 = new Timer(100, 1);
			tim1.addEventListener(TimerEvent.TIMER_COMPLETE, 
				function onTimCompl(e:TimerEvent):void {
					tim1.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimCompl); 
					if (WinBattle.bat['set'][WinBattle.bat.cus].t == WinBattle.myTeam && !topPanel.isAuto() && WinBattle.anim.length == 0) {
						getControlAfterUlt(false);
					}
					LifeManajer.updateCurrLife(obj.wh.t, obj.wh.p);
					LifeManajer.updateCurrLife(obj.whm.t, obj.whm.p);
					if (obj.hpl != 0) {
						hurt_unit.gotoAndPlay("hurt");
						return
					}
					var coord:Object = bat.locs[obj.whm.t][obj.whm.p];
					hurt_unit.gotoAndPlay("die");
					hurt_unit.addEventListener("DIE", mover.onUnitDie);
					for (var i:int = 0; i < WinBattle.sortArr.length; i++) {
						if (WinBattle.sortArr[i] == hurt_unit) {
							WinBattle.sortArr.splice(i, 1);
							break;
						}
					}
					WinBattle.bat.map.grid[coord.x][coord.y].id = 0;
					Node(WinBattle.inst.grid.nodes[coord.x][coord.y]).walcable = 0;
					WinBattle.units[obj.whm.t][obj.whm.p] = null;
				} 
			);
			tim1.start();
		}
		
		private function onLgsTimerCplt(e:TimerEvent):void 
		{
			Timer(e.currentTarget).removeEventListener(TimerEvent.TIMER, this.onLgsTimer);
			Timer(e.currentTarget).removeEventListener(TimerEvent.TIMER_COMPLETE, this.onLgsTimerCplt);
			WinBattle.spr.removeChild(EffManajer.lgs);
		}
		
		private function onLgsTimer(e:TimerEvent):void 
		{
			EffManajer.lgs.update();
		}
		
		private function endBattle(obj:Object):void {
			WinBattle.bat.is_end
			this.grid.clearNodesControl();
			var mc:MovieClip;
			if (obj.is_w) {
				mc = WinBattle.winAfterBattle;
				App.sound.playSound('win', App.sound.onVoice, 1);
				if (obj.mcd != null) {
					var mapNum:int = int(obj.mcd.mapn);
					var missNum:int = int(obj.mcd.misn);
					var hero:Hero = UserStaticData.hero;
					if (UserStaticData.hero.miss[mapNum].mn[missNum] == null) {
						UserStaticData.hero.miss[mapNum].mn[missNum] = new Object; 
						if ((missNum + 1) % 11 == 0) {
							hero.miss[mapNum + 1] = { mn:new Object };
							hero.fs++;
							hero.exp = 0;
							hero.level = mapNum + 2;
						} else {
							UserStaticData.hero.exp = missNum + 1;
						}
						this.gift_id = obj.mcd.gift.k;
						hero.chest[obj.mcd.gift.d] = Maker.clone(UserStaticData.magazin_items[0][7][this.gift_id]);
						
					}
					UserStaticData.hero.miss[mapNum].mn[missNum].st = obj.mcd.sa;
					UserStaticData.hero.gold += obj.mcd.g;
					UserStaticData.hero.silver += obj.mcd.s;
					mc.starBar.visible = true;
					mc.ress.visible = true;
					mc.ress.txtGold.text = obj.mcd.g;
					mc.ress.txtSilver.text = obj.mcd.s;
					for (var j:int = 0; j < 4; j++) {
						if (obj.mcd.sa[j] == 1) {
							mc.starBar["st" + j].visible = true;
						} else {
							mc.starBar["st" + j].visible = false;
						}
					}
				} else {
					mc.starBar.visible = false;
					mc.ress.visible = false;
				}
			} else {
				mc = WinBattle.looseAfterBattle;
			}
			mc.gotoAndPlay(1);
			App.spr.addChild(mc);
			var all_units:Object = bat.u[WinBattle.myTeam];
			for (var i:int = 0; i < 4; i++)  {
				var blank:mcBlankWinn = mc[String("k" + i)];
				if (UserStaticData.hero.units[i] != null) {
					UserStaticData.hero.units[i].inv = all_units[i].inv;
					delete(all_units[i].inv);
					blank.txt1.visible = true;
					blank.txt2.visible = true;
					var unit_data:Object = UserStaticData.hero.units[i];
					var unit:Object = UnitCache.getUnit(Slot.namesUnit[unit_data.t]);
					var living:Boolean = (obj.st[i].d == 0);
					unit.itemUpdate(Slot.getUnitItemsArray(unit_data))
					unit.init(blank);
					unit.x = 25; unit.y = 50;
					this.unitsInWin.push(unit);
					blank.txt1.text = "Убито: " + obj.st[i].k;
					if (living) {
						blank.txt2.textColor = 0x62F523; 
						blank.txt2.text = "+" + obj.exp +" опыта";
						unit_data.exp += obj.exp;
					} else {
						blank.txt2.textColor = 0xF52323 ; 
						blank.txt2.text = "Умер";
						unit_data.l += obj.st[i].d;
					}
					unit_data.k += obj.st[i].k;
				} else {
					blank.txt1.visible = false;
					blank.txt2.visible = false;
				}
			}
			Main.THIS.chat.visible = true;
			Main.THIS.stage.removeChild(WinBattle.battleChat);
			Main.THIS.chat.setFocus();
		}
		
		private function isAlive(ul:Object, user_pos:int):Boolean 
		{
			for (var key:Object in ul)
			{
				if (ul[key] == user_pos)
					return true;
			}
			return false;
		}
		 
		public function setCurrStep():void {
			this.ult_clicked = false;
			WinBattle.sortSpr();
			var cus:Object = WinBattle.bat['set'][WinBattle.bat.cus];
			if (currUnit != null) {
				currUnit.filters = []; currUnit.shawdow.alpha = 1; 
			}
			WinBattle.currUnit = WinBattle.units[cus.t][cus.p]; 
			App.btnOverFilter.color = 0xFFFFFF;
			MovieClip(currUnit).filters = [App.btnOverFilter]; currUnit.shawdow.alpha = 0;
			WinBattle.showCurrUnit(cus.t);
			this.grid.clearNodesControl();
			this.grid.lightUnits(bat.locs[0], bat.hps[0], 0);
			this.grid.lightUnits(bat.locs[1], bat.hps[1], 1);
			var cur_unit:Object = WinBattle.bat.u[myTeam][cus.p];
			var lifeObject:Object = LifeManajer.un_Data[cus.t][cus.p];
			this.bigLifeBar.mcLife.gotoAndStop(int(1 + lifeObject.currLife / lifeObject.maxLife * 100));
			this.bigLifeBar.mcLife.txt.text = lifeObject.currLife + "/" + lifeObject.maxLife;
			this.bigLifeBar.mcMana.gotoAndStop(int(1 + lifeObject.currMana / lifeObject.maxMana * 100));
			this.bigLifeBar.mcMana.txt.text = lifeObject.currMana + "/" + lifeObject.maxMana;
			
			if (cus.t == myTeam && WinBattle.anim.length == 0) {
				var is_arr:int = cur_unit.t_d;
				var r:int = cur_unit.sp;
				var loc:Object = WinBattle.bat.locs[myTeam][cus.p];
				if (WinBattle.anim.length == 0) {
					if (this.topPanel.isAuto() == false) {
						this.grid.showAvailableCells(loc.x, loc.y, r, is_arr);
						this.makeUltimate(cur_unit, cus);
						this.makeBanochki(cur_unit, cus);
						this.topPanel.setDefence(true);
					} else {
						Node(this.grid.nodes[0][0]).sendStep();
					}
				}
				WinBattle.ult_btn.gotoAndStop(cur_unit.t+2);
			} else {
				WinBattle.ult_btn.gotoAndStop(1);
				WinBattle.ult_btn.mc.visible = false;
				WinBattle.ult_btn.buttonMode = false;
				this.removeUltEvents();
			}
			
		}
		
		private function makeBanochki(cur_unit:Object, cus:Object = null):void 
		{
			for (var i:int = 0; i < WinBattle.inv_btns.length; i++) 
			{
				this.updateBanochka(cur_unit, i);
			}
		}
		
		private function onBankaClick(e:MouseEvent):void 
		{
			App.lock.init();
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, this.onBanochkaRes);
			data.sendData(COMMANDS.USE_BANOCHKA, e.currentTarget.name, true);
		}
		
		private function onBanochkaRes(e:DataExchangeEvent):void 
		{
			DataExchange(e.currentTarget).removeEventListener(DataExchangeEvent.ON_RESULT, onBanochkaRes);
			var obj:Object = JSON2.decode(e.result);
			if (obj.error == null) {
				App.lock.frees();
				var unit:Object
				var cur_pos:int = WinBattle.bat['set'][WinBattle.bat.cus].p;
				var inv_place:int = int(obj.res);
				unit = bat.u[WinBattle.myTeam][cur_pos];
				delete(unit.inv[inv_place]);
				this.updateBanochka(unit, inv_place);
			} else {
				App.lock.init(obj.error);
			}
		}
		
		public function disableBanochki():void
		{
			for (var i:int = 0; i < inv_btns.length; i++) 
			{
				var mc:Panel_Inv = WinBattle.inv_btns[i];
				mc.gotoAndStop(1);
				mc.buttonMode = false;
				mc.removeEventListener(MouseEvent.ROLL_OVER, this.onBankaOver);
				mc.removeEventListener(MouseEvent.ROLL_OUT, this.onBankaOut);
				mc.removeEventListener(MouseEvent.CLICK, this.onBankaClick);
			}
		}
		
		private function updateBanochka(unit:Object, inv_pace:int):void 
		{
			var mc:Panel_Inv = WinBattle.inv_btns[inv_pace];
			if (unit.inv[inv_pace] != null)
			{
				mc.gotoAndStop(unit.inv[inv_pace].id+1);
				mc.buttonMode = true;
				mc.addEventListener(MouseEvent.ROLL_OVER, this.onBankaOver);
				mc.addEventListener(MouseEvent.ROLL_OUT, this.onBankaOut);
				mc.addEventListener(MouseEvent.CLICK, this.onBankaClick);
			}
			else
			{
				if (mc.currentFrame != 1)
				{
					mc.gotoAndStop(1);
					mc.buttonMode = false;
					mc.removeEventListener(MouseEvent.ROLL_OVER, this.onBankaOver);
					mc.removeEventListener(MouseEvent.ROLL_OUT, this.onBankaOut);
					mc.removeEventListener(MouseEvent.CLICK, this.onBankaClick);
				}
			}
		}
		
		private function onBankaOut(e:MouseEvent):void 
		{
			
		}
		
		private function onBankaOver(e:MouseEvent):void 
		{
			
		}
		
		private function makeUltimate(cur_unit:Object, cus:Object):void 
		{
			var t_mp:Object = bat.mps[myTeam];
			if (cur_unit.ult != null && cur_unit.ult.lvl != 0 && t_mp[cus.p] >= cur_unit.ult.mc && !bat.is_ult)
			{
				WinBattle.ult_btn.mc.visible = false;
				WinBattle.ult_btn.buttonMode = true;
				this.addUltEvents();
			}
			else
			{
				WinBattle.ult_btn.mc.visible = true;
				this.removeUltEvents();
			}
		}
		
		public function removeUltEvents():void
		{
			WinBattle.ult_btn.buttonMode = false;
			WinBattle.ult_btn.removeEventListener(MouseEvent.ROLL_OVER, this.onUltOver);
			WinBattle.ult_btn.removeEventListener(MouseEvent.ROLL_OUT, this.onUltOut);
			WinBattle.ult_btn.removeEventListener(MouseEvent.CLICK, this.onUltClick);
		}
		
		private function addUltEvents():void
		{
			WinBattle.ult_btn.addEventListener(MouseEvent.ROLL_OVER, this.onUltOver);
			WinBattle.ult_btn.addEventListener(MouseEvent.ROLL_OUT, this.onUltOut);
			WinBattle.ult_btn.addEventListener(MouseEvent.CLICK, this.onUltClick);
			WinBattle.ult_btn.buttonMode = true;
		}
		 
		private function onUltClick(e:MouseEvent):void {
			if (!RemindCursors.is_ult) {
				if (WinBattle.atackNode.parent) {
					WinBattle.atackNode.parent.removeChild(WinBattle.atackNode);
					WinBattle.atackNode.currNode = null;
				}
				RemindCursors.is_ult = true;
				App.cursor.changeCursor("ult");
				this.grid.clearNodesControl();
				var cus:Object = WinBattle.bat['set'][WinBattle.bat.cus];
				var unit_type:int = WinBattle.bat.u[WinBattle.myTeam][cus.p].t;
				this.grid.highLightUltCells(unit_type);
			} else {
				RemindCursors.is_ult = false;
				App.cursor.changeCursor(App.cursor.mainCursor);
				this.addUltEvents();
				this.grid.disLightUltCells(unit_type);
				this.getControlAfterUlt(true);
			}
		}
		 
		private function onUltOut(e:MouseEvent):void 
		{
			
		}
		 
		private function onUltOver(e:MouseEvent):void 
		{
			
		}
		 
		public function update():void
		{
			mover.update();
			effManajer.update();
		}
		
		public function frees():void {
			DataExchange.socket.removeEventListener(DataExchangeEvent.BATTLE_MASSAGE, this.onBattleMassage);
			this.freeUnits(units[0]);
			this.freeUnits(units[1]);
			WinBattle.units = null;
			this.lifeManajer.frees();
			WinBattle.atackNode.frees();
			this.grid.frees();
			this.addListenersToChekboks(this.chekLifeBar, 2, false);
			this.mover.unit = null;
			this.mover.cur_obj = null;
			WinBattle.currUnit = null;
			UserStaticData.hero.bat = -1;
			UserStaticData.hero.mbat = null;
			effManajer.frees();
			for (var i:int = 0; i < unitsInWin.length; i++) {
				unitsInWin[i].frees();
			}
			sortArr.splice(0, sortArr.length);
		}
		
		private function freeUnits(unit:Object):void 
		{
			for (var key:Object in unit)
			{
				if (unit[key] != null)
				{
					unit[key].frees();
				}
				delete(unit[key]);
			}
		}
		 
		private function getMyTeam():void
		{
			myTeam = - 1;
			var id:String = UserStaticData.from + UserStaticData.id;
			if (UserStaticData.hero.bat > -1) {
				WinBattle.bat= UserStaticData.hero.mbat; 
			}
			if (WinBattle.bat.ids[0] == id)
			{myTeam = 0;}
			else if (WinBattle.bat.ids[1] == id)
			{myTeam = 1;}
		}
		
		public static function showCurrUnit(team_n:int):void {
			WinBattle.arrow.x = WinBattle.currUnit.x;
			WinBattle.arrow.y = WinBattle.currUnit.y + WinBattle.currUnit._head.y - WinBattle.currUnit._head.height/2;
			if (WinBattle.myTeam == team_n) {
				WinBattle.arrow.mc.gotoAndStop(1);
			} else {
				WinBattle.arrow.mc.gotoAndStop(2);
			}
			App.spr.addChild(arrow);
			WinBattle.arrow.visible = true; 
			WinBattle.arrow.play();
		}
		 
		static public function sortSpr():void 
		{
			var newArr:Array = sortArr.sortOn('y', Array.NUMERIC);
			for (var j:int = 0; j < newArr.length; j++) 
				spr.addChild(newArr[j]); 
		}
		
		static public function makeUltimate(whom:int):void {
			WinBattle.inst.removeUltEvents();
			WinBattle.inst.grid.disLightUltCells(WinBattle.bat.u[WinBattle.myTeam][WinBattle.bat['set'][WinBattle.bat.cus].p].t);
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, WinBattle.onUltimateResult);
			data.sendData(COMMANDS.ULTIMATE, whom.toString(), true);
		}
		
		private static function onUltimateResult(e:DataExchangeEvent):void 
		{
			RemindCursors.is_ult = false;
			App.cursor.changeCursor(App.cursor.mainCursor);
			var obj:Object = JSON2.decode(e.result);
			if (obj.res != null)
			{
				App.lock.frees();
			}
		}
		
		private function getControlAfterUlt(is_ult_btn:Boolean):void
		{
			WinBattle.inst.grid.lightUnits(bat.locs[0], bat.hps[0], 0);
			WinBattle.inst.grid.lightUnits(bat.locs[1], bat.hps[1], 1);
			var cus:Object = WinBattle.bat['set'][WinBattle.bat.cus];
			var r:int;
			var is_arr:int;
			var cur_unit:Object = WinBattle.bat.u[myTeam][cus.p];
			var loc:Object = WinBattle.bat.locs[myTeam][cus.p];
			r = cur_unit.sp;
			is_arr = cur_unit.t_d;
			WinBattle.inst.grid.showAvailableCells(loc.x, loc.y, r, is_arr);
			WinBattle.ult_btn.mc.visible = !is_ult_btn;
		}
		
		public static function inverseTeam(team:int):int
		{
			return (team -1 ) * -1;
		}
		
		
	}

}