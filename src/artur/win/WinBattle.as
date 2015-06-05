package artur.win 
{
	import artur.App;
	import artur.display.battle.AttackNode;
	import artur.display.battle.BattleGrid;
	import artur.display.battle.eff.BaseEff;
	import artur.display.battle.eff.EffManajer;
	import artur.display.battle.LifeManajer;
	import artur.display.battle.MoveUnit;
	import artur.display.battle.Node;
	import artur.display.HeroInventar;
	import artur.display.Slot;
	import artur.PrepareGr;
	import artur.RasterClip;
	import artur.units.U_Warwar;
	import artur.units.UnitCache;
	import artur.util.RemindCursors;
	import com.greensock.events.LoaderEvent;
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

	public class WinBattle 
	{
		private var bgs:Array = [RasterClip.raster(new Bg_Battle_1(),820,420)];
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
		public  var chekAvtoboi:ChecAvtoboi = new ChecAvtoboi();
		public var bin:Boolean = false;
		private var unitsInWin:Array = [];
		public static var winAfterBattle:mcAfterBattle = new mcAfterBattle();
		public static var looseAfterBattle:mcAfterBattleLose = new mcAfterBattleLose();
		public static var inv_bg:mcBgBatleInventar = new mcBgBatleInventar();
		public static var hero_inv:HeroInventar;
		private static var skill_pannel:Bitmap = PrepareGr.creatBms(new mcPanelBattle())[0];
		private static var ult_btn:UltSkillPanel = new UltSkillPanel();
		private static var inv_btns:Array = [new Panel_Inv, new Panel_Inv, new Panel_Inv, new Panel_Inv];
		private var ult_clicked:Boolean = false;
		
		
		
		public function WinBattle() 
		{
			WinBattle.winAfterBattle.btn.addEventListener(MouseEvent.CLICK, this.onCloseWin);
			WinBattle.looseAfterBattle.btn.addEventListener(MouseEvent.CLICK, this.onCloseWin);
			
			WinBattle.hero_inv = new HeroInventar(true);
			inst = this;
			arrow.gotoAndStop(1);
			atackNode = new AttackNode();
			chekAvtoboi.y = 14;
			this.chekAvtoboi.buttonMode = this.chekLifeBar.buttonMode = true;
			WinBattle.skill_pannel.x = 581; WinBattle.skill_pannel.y = 360;
			WinBattle.ult_btn.x = 741; WinBattle.ult_btn.y = 365;
			WinBattle.ult_btn.stop();
			WinBattle.ult_btn.buttonMode = WinBattle.ult_btn.mouseChildren = WinBattle.ult_btn.tabEnabled = WinBattle.ult_btn.tabChildren = this.chekAvtoboi.tabChildren = this.chekAvtoboi.tabEnabled = this.chekLifeBar.tabEnabled = this.chekLifeBar.tabChildren = false;
			for (var i:int = 0; i < WinBattle.inv_btns.length; i++) 
			{
				var mc:Panel_Inv = WinBattle.inv_btns[i];
				mc.x = 592 + 37*i;
				mc.y = 387;
				mc.gotoAndStop(1);
				mc.mouseChildren = mc.tabEnabled = mc.tabChildren = false;
				mc.buttonMode = true;11
			}
		}
		
		private function onCloseWin(e:MouseEvent):void 
		{
			App.winManajer.swapWin(2);
		}
		
		private function checkCLick(e:MouseEvent):void 
		{
			if (MovieClip(e.currentTarget).currentFrame == 1)
			{
				e.currentTarget.gotoAndStop(2);
				if (e.currentTarget is CheckLife) {this.lifeManajer.showLB(true);}
				else if(bat.set[bat.cus].t == myTeam) {Node(this.grid.nodes[0][0]).sendStep();}
				
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
			this.unitsInWin = [];
			this.bin = true;
			WinBattle.units = [[], []];
			this.getMyTeam();
			App.spr.addChild(bgs[0]);
			App.spr.addChild(spr);
			App.spr.addChild(WinBattle.ult_btn);
			for (var i:int = 0; i < WinBattle.inv_btns.length; i++) 
			{
				var mc:Cell_Inv = WinBattle.inv_btns[i];
				App.spr.addChild(mc);
			}
			App.spr.addChild(WinBattle.skill_pannel);
			this.addListenersToChekboks(this.chekAvtoboi, 1);
			this.addListenersToChekboks(this.chekLifeBar, 2);
			this.grid.init();
			this.lifeManajer.init();
			this.setCurrStep();
			DataExchange.socket.addEventListener(DataExchangeEvent.BATTLE_MASSAGE, this.onBattleMassage);
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
				var loc:Object = (obj.m.u.t == 0)?WinBattle.bat.t1_locs[obj.m.u.p]:WinBattle.bat.t2_locs[obj.m.u.p];
				var is_r:Boolean;
				var type:int;
				var unit:Object;
				if (obj.m.u.t == 0)
				{
					loc = WinBattle.bat.t1_locs[obj.m.u.p];
					unit = bat.t1_u[obj.m.u.p];
					is_r = (unit.t_d == 1);
					type = unit.t
				}
				else
				{
					loc = WinBattle.bat.t2_locs[obj.m.u.p];
					unit = bat.t2_u[obj.m.u.p];
					is_r = (unit.t_d == 1);
					type = unit.t
				}
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
			else if(obj.is_w != null)
			{
				this.endBattle(obj)
			}
		}
		
		private function onUltimateData(obj:Object):void 
		{
			var ef_coord:Object;
			var node:Node;
			switch(obj.t)
			{
				case 0:
					App.sound.playSound("battle_cry", App.sound.onVoice, 1);
					ef_coord = (obj.whm.t == 0) ? bat.t1_locs[obj.whm.p]:bat.t1_locs[obj.whm.p];
					node = WinBattle.inst.grid.nodes[ef_coord.x][ef_coord.y];
					U_Warwar(WinBattle.units[obj.whm.t][obj.whm.p]).showBuff(1);
					BaseEff(EffManajer.getEff("base")).init(WinBattle.spr, node.x, node.y, 2);
					if (obj.wh.t == 0) bat.t1_u[obj.wh.p].b[5] = new Object(); else bat.t2_u[obj.wh.p].b[5] = new Object();
					break;
				case 1:
					App.sound.playSound("eff_heal", App.sound.onVoice, 1);
					ef_coord = (obj.whm.t == 0) ? bat.t1_locs[obj.whm.p]:bat.t1_locs[obj.whm.p];
					node = WinBattle.inst.grid.nodes[ef_coord.x][ef_coord.y];
					BaseEff(EffManajer.getEff("base")).init(WinBattle.spr, node.x, node.y, 1);
					break;
				case 2:
					App.sound.playSound("eff_arrow", App.sound.onVoice, 1);
					ef_coord = (obj.whm.t == 0) ? bat.t1_locs[obj.whm.p]:bat.t2_locs[obj.whm.p];
					node = WinBattle.inst.grid.nodes[ef_coord.x][ef_coord.y];
					BaseEff(EffManajer.getEff("base")).init(WinBattle.spr, node.x, node.y + 25, 3);
					break;
				case 3:
					ef_coord = (obj.whm.t == 0) ? bat.t1_locs[obj.whm.p]:bat.t2_locs[obj.whm.p];
					node = WinBattle.inst.grid.nodes[ef_coord.x][ef_coord.y];
					EffManajer.showLgs(30, WinBattle.spr, 0xFFFFFF, node.x, node.y - 1000, node.x, node.y-40);
					EffManajer.lgs.update();
					var tim:Timer = new Timer(15, 15);
					tim.addEventListener(TimerEvent.TIMER, this.onLgsTimer);
					tim.addEventListener(TimerEvent.TIMER_COMPLETE, this.onLgsTimerCplt);
					tim.start();
					break;
			}
			//whom unit
			var t_obj:Object = (obj.wh.t == 0) ? bat.t1_mp:bat.t2_mp;
			t_obj[obj.wh.p] = obj.mcl;
			LifeManajer.un_Data[obj.wh.t][obj.wh.p].currMana = obj.mcl;
			LifeManajer.updateCurrLife(obj.wh.t, obj.wh.p);
			//whom unit
			t_obj = (obj.whm.t == 0) ? bat.t1_hp:bat.t2_hp;
			t_obj[obj.wh.p] = obj.hpl;
			LifeManajer.un_Data[obj.whm.t][obj.whm.p].currLife = obj.hpl;
			LifeManajer.updateCurrLife(obj.whm.t, obj.whm.p);
			var hurt_unit:MovieClip = WinBattle.units[obj.whm.t][obj.whm.p];
			if (obj.hpl == 0)
			{
				var coord:Object = (obj.whm.t == 0) ? bat.t1_locs[obj.whm.p]:bat.t1_locs[obj.whm.p];
				hurt_unit.gotoAndPlay("die");
				hurt_unit.addEventListener("DIE", this.mover.onUnitDie);
				for (var i:int = 0; i < WinBattle.sortArr.length; i++) 
				{
					if (WinBattle.sortArr[i] == hurt_unit)
					{
						WinBattle.sortArr.splice(i, 1);
						break;
					}
				}
				WinBattle.bat.map.grid[coord.x][coord.y].id = 0;
				Node(WinBattle.inst.grid.nodes[coord.x][coord.y]).walcable = 0;
				WinBattle.units[obj.whm.t][obj.whm.p] = null;
			}
			else
			{
				if (obj.t == 2 || obj.t == 3)
				{
					var tim1:Timer;;
					if (obj.t == 2) tim1 = new Timer(470, 1);
					else if (obj.t == 3) tim1 = new Timer(100, 1);
					tim1.addEventListener(TimerEvent.TIMER_COMPLETE, function onTimCompl(e:TimerEvent):void { tim1.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimCompl); hurt_unit.gotoAndPlay("hurt") } );
					tim1.start();
				}
			}
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
		
		private function endBattle(obj:Object):void 
		{
			this.grid.clearNodesControl();
			var mc:MovieClip;
			if (obj.is_w)
			{
				mc = WinBattle.winAfterBattle;
				App.sound.playSound('win', App.sound.onVoice, 1);
			}
			else
			{
				mc = WinBattle.looseAfterBattle;
			}
			mc.gotoAndPlay(1);
			App.spr.addChild(mc);
			for (var i:int = 0; i < 4; i++) 
			{
				var blank:mcBlankWinn = mc[String("k" + i)];
				if (UserStaticData.hero.units[i] != null)
				{
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
					if (living) 
					{
						blank.txt2.textColor = 0x62F523; 
						blank.txt2.text = "+" + obj.exp +" опыта";
						unit_data.exp += obj.exp;
					}
					else
					{
						blank.txt2.textColor = 0xF52323 ; 
						blank.txt2.text = "Умер";
						unit_data.l += obj.st[i].d;
					}
					unit_data.k += obj.st[i].k;
				}
				else
				{
					blank.txt1.visible = false;
					blank.txt2.visible = false;
				}
			}
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
		 
		public function setCurrStep():void 
		{
			this.ult_clicked = false;
			WinBattle.sortSpr();
			var cus:Object = WinBattle.bat['set'][WinBattle.bat.cus];
			if (currUnit) {currUnit.filters = []; currUnit.shawdow.alpha = 1;} 
			currUnit = WinBattle.units[cus.t][cus.p]; 
			App.btnOverFilter.color = 0xFFFFFF;
			MovieClip(currUnit).filters = [App.btnOverFilter]; currUnit.shawdow.alpha = 0;
			WinBattle.showCurrUnit(cus.t);
			grid.clearNodesControl();
			grid.lightUnits(bat.t1_locs, bat.t1_hp, 0);
			grid.lightUnits(bat.t2_locs, bat.t2_hp, 1);
			if (cus.t == myTeam)
			{
				var loc:Object;
				var r:int;
				var is_arr:int;
				var cur_unit:Object;
				if (myTeam == 0)
				{
					cur_unit = WinBattle.bat.t1_u[cus.p]
					loc = WinBattle.bat.t1_locs[cus.p];
				}
				else
				{
					cur_unit = WinBattle.bat.t2_u[cus.p]
					loc = WinBattle.bat.t2_locs[cus.p];
				}
				r = cur_unit.sp;
				is_arr = cur_unit.t_d;
				if (WinBattle.anim.length == 0)
				{
					if (this.chekAvtoboi.currentFrame == 1)
					{
						grid.showAvailableCells(loc.x, loc.y, r, is_arr);
						this.makeUltimate(cur_unit, cus);
						this.makeBanochki(cur_unit, cus);
					}
					else
					{
						Node(this.grid.nodes[0][0]).sendStep();
					}
				}
				WinBattle.ult_btn.gotoAndStop(cur_unit.t+2);
			}
			else
			{
				WinBattle.ult_btn.gotoAndStop(1);
				WinBattle.ult_btn.mc.visible = false;
				WinBattle.ult_btn.buttonMode = false;
				this.removeUltEvents();
			}
			
		}
		
		private function makeBanochki(cur_unit:Object, cus:Object):void 
		{
			for (var i:int = 0; i < WinBattle.inv_btns.length; i++) 
			{
				if (cur_unit.inv[i] != null)
				{
					App.spr.addChild(WinBattle.inv_btns[i]);
				}
			}
		}
		
		private function makeUltimate(cur_unit:Object, cus:Object):void 
		{
			var t_mp:Object = (myTeam == 0)? bat.t1_mp:bat.t2_mp
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
		 
		private function onUltClick(e:MouseEvent):void 
		{
			if (!RemindCursors.is_ult)
			{
				if (WinBattle.atackNode.parent)
				{
					WinBattle.atackNode.parent.removeChild(WinBattle.atackNode);
					WinBattle.atackNode.currNode = null;
				}
				RemindCursors.is_ult = true;
				App.cursor.changeCursor("ult");
				this.grid.clearNodesControl();
				var cus:Object = WinBattle.bat['set'][WinBattle.bat.cus];
				var unit_type:int = (WinBattle.myTeam == 0)? WinBattle.bat.t1_u[cus.p].t:WinBattle.bat.t2_u[cus.p].t;
				this.grid.highLightUltCells(unit_type);
			}
			else
			{
				RemindCursors.is_ult = false;
				App.cursor.changeCursor(App.cursor.mainCursor);
				this.addUltEvents();
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
		
		public function frees():void
		{
			DataExchange.socket.removeEventListener(DataExchangeEvent.BATTLE_MASSAGE, this.onBattleMassage);
			this.freeUnits(units[0]);
			this.freeUnits(units[1]);
			
			WinBattle.units = null;
			this.lifeManajer.frees();
			WinBattle.atackNode.frees();
			this.grid.frees();
			this.addListenersToChekboks(this.chekAvtoboi, 1, false);
			this.addListenersToChekboks(this.chekLifeBar, 2, false);
		
			this.mover.unit = null;
			this.mover.cur_obj = null;
			WinBattle.currUnit = null;
			UserStaticData.hero.bat = -1;
			UserStaticData.hero.mbat = null;
			effManajer.frees();
			for (var i:int = 0; i < unitsInWin.length; i++) 
			{
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
			if (UserStaticData.hero.bat > -1)
			{WinBattle.bat= UserStaticData.hero.mbat; }
			if (WinBattle.bat.t1_id == id)
			{myTeam = 0;}
			else if (WinBattle.bat.t2_id == id)
			{myTeam = 1;}
		}
		
		public static function showCurrUnit(team_n:int):void
		{
			WinBattle.arrow.x = WinBattle.currUnit.x;
			WinBattle.arrow.y = WinBattle.currUnit.y + WinBattle.currUnit._head.y - WinBattle.currUnit._head.height/2;
			if (WinBattle.myTeam == team_n)
				WinBattle.arrow.mc.gotoAndStop(1);
			else
				WinBattle.arrow.mc.gotoAndStop(2);
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
		
		static public function makeUltimate(whom:int):void 
		{
			WinBattle.inst.removeUltEvents();
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
				WinBattle.inst.getControlAfterUlt(false);
			}
		}
		
		private function getControlAfterUlt(is_ult_btn:Boolean):void
		{
			WinBattle.inst.grid.lightUnits(bat.t1_locs, bat.t1_hp, 0);
			WinBattle.inst.grid.lightUnits(bat.t2_locs, bat.t2_hp, 1);
			var cus:Object = WinBattle.bat['set'][WinBattle.bat.cus];
			var loc:Object;
			var r:int;
			var is_arr:int;
			var cur_unit:Object;
			if (myTeam == 0)
			{
				cur_unit = WinBattle.bat.t1_u[cus.p]
				loc = WinBattle.bat.t1_locs[cus.p];
			}
			else
			{
				cur_unit = WinBattle.bat.t2_u[cus.p]
				loc = WinBattle.bat.t2_locs[cus.p];
			}
			r = cur_unit.sp;
			is_arr = cur_unit.t_d;
			WinBattle.inst.grid.showAvailableCells(loc.x, loc.y, r, is_arr);
			WinBattle.ult_btn.mc.visible = !is_ult_btn;
		}
		
		
	}

}