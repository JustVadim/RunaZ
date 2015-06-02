package artur.display
{
	import artur.App;
	import artur.win.WinBattle;
	import artur.win.WinCastle;
	import com.greensock.TweenLite;
	import datacalsses.Hero;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import mx.core.FlexMovieClip;
	import report.Report;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Utils.json.JSON2;
	
	public class HeroInventar extends Sprite
	{
		private var bg:MyBitMap;
		private var currHead:MovieClip = new I_Head();
		private var currBody:MovieClip = new I_Body();
		private var currBoot:MovieClip  = new I_Boot();
		private var currHendTop:MovieClip = new I_HendTop();
		private var currHendDown:MovieClip = new I_HendDown();
		
		private var currGun:MovieClip;
		public var guns1:Array =  [new I_WarGun() ,new I_PallGun1() ,new I_Bows(), new I_MagGun()];
		public var guns2:Array = [new MovieClip() ,new I_PallGun2(),new MovieClip(), new MovieClip()];
		
		public var heroType:int;
		public var itemType:int;
		public var itemID:int;
		public var invPlace:int;
		public var parts:Array = [currHead, currBody, currBoot, currHendTop, currHendDown];
		public var inv_array:Array = [new I_Inv(),new I_Inv(),new I_Inv(),new I_Inv()];
		
		public var bin:Boolean = false;
		private var mcText:mcTextHeroInventar = new mcTextHeroInventar();
		private var call:ItemCall;
		private var progresEXP:progresBar = new progresBar();
		private var battle_init:Boolean;
		
		public function HeroInventar(battle_init:Boolean = false)
		{
			this.tabEnabled = false;
			this.tabChildren = false;
			this.battle_init = battle_init;
			
			for (var k:int = 0; k < parts.length; k++) 
			{
				MovieClip(parts[k]).buttonMode = true;
				MovieClip(parts[k]).mouseChildren = false;
			}
			if (this.battle_init)
			{
				this.addChild(WinBattle.inv_bg);
				WinBattle.inv_bg.x = WinBattle.inv_bg.y = -10;
				this.progresEXP.x = 5;
				this.progresEXP.y = 295
				this.mouseChildren = false;
				this.mouseEnabled = false;
				this.scaleX = this.scaleY = 0.9;
			}
			else
			{
				progresEXP.x = 10;  progresEXP.y = 283;
			}
			bg = new MyBitMap(App.prepare.cach[13]);
			this.addChild(bg);
			this.addChild(mcText);
			this.x = 119.75;
			this.y = 60.5;
			var yps:Array = [91, 164.4, 233.1, 133.6, 175.6];
			for (var j:int = 0; j < parts.length; j++) 
			{
				this.setItem(MovieClip(parts[j]),192, yps[j], j);
			}	 
			for (j = 0; j < guns1.length; j++) 
			{
				this.setItem(guns1[j], 192, 165.7, 5)
				this.setItem(guns2[j], 192, 165.7, 6)
			}
			for (j = 0; j < inv_array.length; j++) 
			{
				var inv:I_Inv = inv_array[j];
				this.setItem(inv, 40, 137+j*40, 7);
			}
			if (!battle_init)
			{
				this.addEventsToBuffBtn(this.mcText.sk_crit);
				this.addEventsToBuffBtn(this.mcText.sk_miss);
				this.addEventsToBuffBtn(this.mcText.sk_double);
				this.addEventsToBuffBtn(this.mcText.sk_out);
				this.addEventsToBuffBtn(this.mcText.sk_return);
				this.addEventsToBuffBtn(this.mcText.sk_ult);
			}
		}
		
		private function setItem(mc:MovieClip, xx:Number, yy:Number, name:int):void 
		{
			mc.x = xx;
			mc.y = yy;
			if (!battle_init)
			{
				mc.addEventListener(MouseEvent.ROLL_OVER, over);
				mc.addEventListener(MouseEvent.ROLL_OUT, out);
				mc.addEventListener(MouseEvent.CLICK, onItem);
				mc.addEventListener(MouseEvent.MOUSE_DOWN, strFrag );
				mc.buttonMode = true;
			}
			if (mc.greenRect)
			{
				mc.greenRect.visible = false;
				mc.yRect.visible = false;
			}
			mc.name = String(name.toString());
		}
		
		private function strFrag(e:MouseEvent):void 
		{
			App.info.frees();
			if (e.currentTarget.currentFrame != 1)
			{
				Mouse.hide();
				App.spr.addChild(WinCastle.mcSell); WinCastle.mcSell.gotoAndPlay(1);
				this.itemType = int(e.currentTarget.name);
				this.itemID = int(e.currentTarget.currentFrame);
				this.invPlace = this.getIsInv(MovieClip(e.currentTarget));
				call= ItemCall.getCall();
				call.init(heroType, this.itemType, this.itemID - 1);
				call.x = App.spr.mouseX  - call.width / 2 + 8;
				call.y = App.spr.mouseY - call.height / 2 + 8;
				call.startDrag();
				call.addEventListener(MouseEvent.MOUSE_UP, up);
				call.addEventListener(MouseEvent.MOUSE_MOVE, move);
				e.currentTarget.gotoAndStop(1);
				Main.THIS.stage.addEventListener(Event.MOUSE_LEAVE, fo);
			}
		}
		
		private function fo(e:Event):void 
		{
			Main.THIS.stage.removeEventListener(Event.MOUSE_LEAVE, fo);
			call.removeEventListener(MouseEvent.MOUSE_UP, up);
			call.removeEventListener(MouseEvent.MOUSE_MOVE,move);
			call.frees();
			Mouse.show();
			call.stopDrag();
			if (this.itemType != 5 && this.itemType != 6) { MovieClip(parts[this.itemType]).gotoAndStop(this.itemID);}
			else 
			{
				if(this.itemType == 5)
					MovieClip(guns1[heroType]).gotoAndStop(this.itemID);
				else
					MovieClip(guns2[heroType]).gotoAndStop(this.itemID);
			}
		}
		
		private function move(e:MouseEvent):void 
		{
			e.updateAfterEvent();
			if (e.currentTarget.dropTarget!=null && e.currentTarget.dropTarget.parent != null)
			{
				var str:String = e.currentTarget.dropTarget.parent.name;
				if (str.length >= 5 && str.substr(0, 5) == "celll")
				{
					WinCastle.chest.clearCells();
					var obj:Object = JSON2.decode(str.substr(5, str.length - 1));	
					WinCastle.chest.selectToPut(obj.n, true, this.invPlace);
				}
				else
				{
					if (str == "sellSprite")
					{
						if (WinCastle.mcSell.sellSprite.currentFrame == 1)
							WinCastle.mcSell.sellSprite.gotoAndStop(2);
					}
					else
					{
						if (WinCastle.mcSell.sellSprite.currentFrame == 2)
							WinCastle.mcSell.sellSprite.gotoAndStop(1);
					}
					WinCastle.chest.clearCells();
				}
			}
		}
		
		private function up(e:MouseEvent):void 
		{
			call.removeEventListener(e.type, up);
			call.removeEventListener(MouseEvent.MOUSE_MOVE, move);
			Main.THIS.stage.removeEventListener(Event.MOUSE_LEAVE, fo);
			call.frees();
			Mouse.show();
			this.stopDrag();
			if (e.currentTarget.dropTarget==null || e.currentTarget.dropTarget.parent == null)
			{
				this.putOnOldPlace();
			}
			else
			{
				var str:String = e.currentTarget.dropTarget.parent.name;
				if (str.length>=5 && str.substr(0, 5) == "celll")
				{
					var obj:Object = JSON2.decode(str.substr(5, str.length - 1));
					if (UserStaticData.hero.chest[obj.n].id != 0)
					{
						this.putOnOldPlace();
					}
					else
					{
						var cell_y:int = obj.n / WinCastle.chest.wd;
						var cell_x:int = obj.n - cell_y * WinCastle.chest.wd;
						var item:Object;
						item = UserStaticData.hero.units[WinCastle.currSlotClick].it[this.itemType];
						if (WinCastle.chest.isFreeCells(cell_x, cell_y, item.c[104], item.c[105]))
						{
							App.lock.init();
							var data:DataExchange = new DataExchange();
							data.addEventListener(DataExchangeEvent.ON_RESULT, this.onPutItemToChest);
							var send_obj:Object = {cn:obj.n,un:int(WinCastle.currSlotClick),it:itemType};
							data.sendData(COMMANDS.FROM_UNIT_TO_CHEST, JSON2.encode(send_obj), true);
						}
						else
						{
							this.putOnOldPlace();
						}
						WinCastle.chest.clearCells();
					}
				}
                else if (str == 'sellSprite')
				{
					App.byeWin.init("Я хочу продать", "эту хрень", 0, int(UserStaticData.hero.units[int(WinCastle.currSlotClick)].it[itemType].c[100])/2 ,NaN,3,NaN);
				}
				else 
				{
					this.putOnOldPlace();
				}
			}
			if (App.spr.contains(WinCastle.mcSell))
			{
				App.spr.removeChild(WinCastle.mcSell);
				WinCastle.mcSell.sellSprite.gotoAndStop(1);
			}
		}
		
		public function putOnOldPlace():void 
		{
			Report.addMassage(this.itemType + " " + this.itemID  + " " + this.invPlace)
			App.sound.playSound(ItemCall.sounds[itemType][itemID - 2], App.sound.onVoice, 1); 
			switch(true)
			{
				case (this.itemType < 5):
					MovieClip(parts[this.itemType]).gotoAndStop(this.itemID);
					break;
				case (this.itemType == 5):
					MovieClip(guns1[heroType]).gotoAndStop(this.itemID);
					break;
				case (this.itemType == 6):
					MovieClip(guns2[heroType]).gotoAndStop(this.itemID);
					break;
				case (this.itemType == 7):
					var unit:Object = UserStaticData.hero.units[WinCastle.currSlotClick];
					this.updateInv(this.invPlace, unit);
					break;
			}
		}
		
		private function onPutItemToChest(e:DataExchangeEvent):void 
		{
			DataExchange(e.currentTarget).removeEventListener(e.type, onPutItemToChest);
			var obj:Object = JSON2.decode(e.result);
			if (obj.error == null)
			{
				 App.sound.playSound(ItemCall.sounds[itemType][itemID-2], App.sound.onVoice, 1);
				delete(UserStaticData.hero.units[WinCastle.currSlotClick].it[this.itemType]);
				UserStaticData.hero.chest = obj.ch;
				delete(obj.ch);
				WinCastle.chest.frees();
				WinCastle.chest.init();
				WinCastle.getCastle().slots[int(WinCastle.currSlotClick)].unit.itemUpdate(Slot.getUnitItemsArray(UserStaticData.hero.units[WinCastle.currSlotClick]));
				this.init1(UserStaticData.hero.units[WinCastle.currSlotClick], false);
				App.lock.frees();
			}
			else
			{
				App.lock.init('Error: '+obj.error);
			}
			
		}
		
		private function onItem(e:MouseEvent):void 
		{
			if (MovieClip(e.currentTarget).currentFrame == 1) 
			{
				WinCastle.shopInventar.init(int(e.currentTarget.name),int(UserStaticData.hero.units[WinCastle.currSlotClick].t),this.getIsInv(MovieClip(e.currentTarget)));
			}
		}
		
		private function getIsInv(mc:MovieClip):int 
		{
			for (var i:int = 0; i < inv_array.length; i++) 
			{
				if (inv_array[i] == mc)
					return i;
			}
			return -1;
		}
		
		private function out(e:MouseEvent):void
		{
			App.info.frees();
			e.currentTarget.mc.scaleX = 1;
			e.currentTarget.mc.scaleY = 1;
			e.currentTarget.mc.filters = [];
			if (e.currentTarget.mc2)
			{
				e.currentTarget.mc2.scaleX = 1;
				e.currentTarget.mc2.scaleY = 1;
				e.currentTarget.mc2.filters = [];
			}
		}
		
		private function over(e:MouseEvent):void
		{
			var bat:MovieClip = MovieClip(e.currentTarget);
			bat.mc.scaleX = 1.3;
			bat.mc.scaleY = 1.3;
			App.btnOverFilter.color = 0xFBFBFB;
			bat.mc.filters = [App.btnOverFilter];
			if (bat.mc2)
			{
				bat.mc2.scaleX = 1.3;
				bat.mc2.scaleY = 1.3;
				bat.mc2.filters = [App.btnOverFilter];
			}
			App.sound.playSound('overItem', App.sound.onVoice, 1);
			if (bat.currentFrame == 1)
			{
				App.info.init(bat.x + this.x - bat.width / 2 - 5 , bat.y + this.y + bat.height / 2 + 5, {txtInfo_w:135,txtInfo_h:37,txtInfo_t:"Нажмите, чтобы\n купить вещь",type:0} )
			}
			else
			{
				switch(true)
				{
					case (int(bat.name) < 5):
						App.info.init(bat.x + this.x - 236 - bat.width / 2 - 5 , bat.y + this.y + bat.height / 2 + 5, { title:"Шмотка", type:2, chars:UserStaticData.hero.units[int(WinCastle.currSlotClick)].it[int(bat.name)].c, bye:false } )
						break;
					case (int(bat.name) == 5 || int(bat.name) == 6):
						App.info.init(bat.x + this.x - bat.width / 2 - 5 , bat.y + this.y + bat.height / 2 + 5, { title:"Шмотка", type:2, chars:UserStaticData.hero.units[int(WinCastle.currSlotClick)].it[int(bat.name)].c, bye:false} )	
						break;
					case (int(bat.name) == 7):
						break;
				}
			}
		}
		
		public function init1(unit:Object, anim:Boolean = true, xx:int = 10, yy:int = 50):void
		{
			frees();
			this.heroType = unit.t;
			if (anim)
			{
				this.alpha = 0;
				this.scaleX = 0.2;
				this.scaleY = 0.2;
				TweenLite.to(this, 0.5, { alpha: 1, scaleX: 1, scaleY: 1 });	
			}
			var unit_tems_ids:Object = Slot.getUnitItemsArray(unit);
			for (var i:int = 0; i < parts.length; i++)
			{
				parts[i].gotoAndStop(int(unit_tems_ids[i] + 1));
				this.addChild(parts[i]);
			}
			if (guns1[heroType] == null)
			{
				guns1[0].gotoAndStop(1);
				this.addChild(guns1[0]);
			}
			else
			{
				guns1[heroType].gotoAndStop(int(unit_tems_ids[5] + 1));
				guns2[heroType].gotoAndStop(int(unit_tems_ids[6] + 1));
				this.addChild(guns1[heroType]);
				this.addChild(guns2[heroType]);
			}
			for (i = 0; i < inv_array.length; i++) 
			{
				var inv:I_Inv = inv_array[i];
				this.addChild(inv);
				this.updateInv(i, unit);
			}
			
			var chars:Object;
			if (this.battle_init) 
			{
				chars = [0, 0, 0, 0, 0];
				this.x = xx;
				this.y = yy;
			}
			else chars = [0, UserStaticData.hero.skills.energy , UserStaticData.hero.skills.attack, UserStaticData.hero.skills.defence, UserStaticData.hero.skills.defence];
			for (var key:Object in unit.it)
				for (var key2:Object in unit.it[key].c )
					chars[int(key2)] += unit.it[key].c[key2];
			mcText.txtLife.text = String(unit.hp );
			mcText.txtLife2.text = String(chars[0]);
			mcText.txtMana.text = String(unit.mp );
			mcText.txtMana2.text = String(chars[1]);
			mcText.txtDmg.text = String(unit.min_d +' - ' + unit.max_d  );
			mcText.txtDmg2.text =  String(chars[2]);
			mcText.txtFizDeff.text = String(unit.f_d);
			mcText.txtFizDeff2.text = String(chars[3]);
			mcText.txtMagDeff.text = String(unit.m_d);
			mcText.txtMagDeff2.text = String(chars[4]);
			mcText.txtInic.text = String(unit["in"]);
			mcText.txtInic2.text = "0";
			mcText.txtSpeed.text = String(unit.sp);
			mcText.txtSpeed2.text = "0";
			mcText.txtKilled.text = String(" Убил: " + unit.k);
			mcText.txtDied.text = String(" Умер: " + unit.l);
			this.bin = true;
			this.addChild(progresEXP); this.progresEXP.txt.text = unit.exp + "/" + unit.nle; this.progresEXP.gotoAndStop(int(100 * unit.exp / unit.nle));
			this.progresEXP.txt2.text = unit.lvl;
			App.spr.addChild(this);
			if(this.battle_init)
				this.updateSkills(unit);
			else
				this.updateSkills();
		}
		
		private function addEventsToBuffBtn(mc:MovieClip):void 
		{
			mc.mouseChildren = false;
			mc.addEventListener(MouseEvent.ROLL_OVER, this.onBuffOver);
			mc.addEventListener(MouseEvent.ROLL_OUT, this.onBuffOut);
			mc.mouseChildren = false;
			mc.buttonMode = true;
			mc.tabEnabled = false;
			mc.tabChildren = false;
		}
		
		private function updateSkills(unit:Object = null):void 
		{
			if(unit == null)
				var unit:Object = UserStaticData.hero.units[WinCastle.currSlotClick];
			this.mcText.txt_sk_crit.text = unit.b[0].l;
			this.mcText.txt_sk_miss.text = unit.b[1].l;
			this.mcText.txt_sk_double.text = unit.b[2].l;
			this.mcText.txt_sk_out.text = unit.b[3].l;
			this.mcText.txt_sk_return.text = unit.b[4].l;
			this.mcText.sk_ult.gotoAndStop(this.heroType+1);
			this.mcText.mcFreeskils.textf.text = "Доступно: " + unit.fs;
			
			if (unit.fs > 0 && !battle_init)
			{
				this.mcText.mcFreeskils.visible = true;
				this.addBuffClick(this.mcText.sk_crit);
				this.addBuffClick(this.mcText.sk_miss);
				this.addBuffClick(this.mcText.sk_double);
				this.addBuffClick(this.mcText.sk_out);
				this.addBuffClick(this.mcText.sk_return);
				this.addBuffClick(this.mcText.sk_ult);
			}
			else
			{
				this.mcText.mcFreeskils.visible = false;
				this.removeBuffClick(this.mcText.sk_crit);
				this.removeBuffClick(this.mcText.sk_miss);
				this.removeBuffClick(this.mcText.sk_double);
				this.removeBuffClick(this.mcText.sk_out);
				this.removeBuffClick(this.mcText.sk_return);
			}
		}
		
		private function removeBuffClick(mc:MovieClip):void 
		{
			mc.removeEventListener(MouseEvent.CLICK, this.onBuffClick);
		}
		
		private function addBuffClick(mc:MovieClip):void 
		{
			mc.addEventListener(MouseEvent.CLICK, this.onBuffClick);
		}
		
		private function onBuffClick(e:MouseEvent):void 
		{
			 var mc:MovieClip = MovieClip(e.currentTarget);
			 UserStaticData.hero.units[WinCastle.currSlotClick].fs--;
		 	 App.sound.playSound('skillUp', App.sound.onVoice, 1);
			switch(true)
			{
				case(mc == this.mcText.sk_crit):
					UserStaticData.hero.units[WinCastle.currSlotClick].b[0].l++;
					break;
				case(this.mcText.sk_miss == mc):
					UserStaticData.hero.units[WinCastle.currSlotClick].b[1].l++;
					break;
				case(this.mcText.sk_double == mc):
					UserStaticData.hero.units[WinCastle.currSlotClick].b[2].l++;
					break;
				case(this.mcText.sk_out == mc):
					UserStaticData.hero.units[WinCastle.currSlotClick].b[3].l++;
					break;
				case(this.mcText.sk_return == mc):
					UserStaticData.hero.units[WinCastle.currSlotClick].b[4].l++;
					break;
			}
			Slot(WinCastle.getCastle().slots[WinCastle.currSlotClick]).higlightLvlStar();
			this.updateSkills();
			this.onBuffOut(e);
			this.onBuffOver(e);
		}
		
		
		private function onBuffOut(e:MouseEvent):void 
		{
			var mc:MovieClip = MovieClip(e.currentTarget);
			mc.filters = [];
			App.info.frees();
		}
		
		private function onBuffOver(e:MouseEvent):void 
		{
			var mc:MovieClip = MovieClip(e.currentTarget);
			App.sound.playSound('over2', App.sound.onVoice, 1);
			if (this.mcText.mcFreeskils.visible)
			{
				App.btnOverFilter.color = 0xFFFFFF;
				mc.filters = [App.btnOverFilter];
				
			}
			var p:Point = mc.localToGlobal(new Point(0, 0));
			var descr:String = "";
			var ub:Object = UserStaticData.hero.units[WinCastle.currSlotClick].b;
			
			switch(true)
			{
				case(mc == this.mcText.sk_crit):
					descr = "<font color=\"#00FF00\">Критический урон</font>\n<font color=\"#FFFFFF\">"+ UserStaticData.buffs_chances[0][ub[0].l]+"% шанс нанести двойной урон</font>\n Следующий уровень - " + UserStaticData.buffs_chances[0][ub[0].l+1] + "%";
					break;
				case(this.mcText.sk_miss == mc):
					descr = "<font color=\"#00FF00\">Уворот</font>\n<font color=\"#FFFFFF\">"+ UserStaticData.buffs_chances[1][ub[1].l]+"% шанс уклониться от удара</font>\n Следующий уровень - " + UserStaticData.buffs_chances[1][ub[1].l+1] + "%";
					break;
				case(this.mcText.sk_double == mc):
					descr = "<font color=\"#00FF00\">Двойная атака</font>\n<font color=\"#FFFFFF\">"+ UserStaticData.buffs_chances[2][ub[2].l]+"% шанс атаковать два раза</font>\n Следующий уровень - " + UserStaticData.buffs_chances[2][ub[2].l+1] + "%";
					break;
				case(this.mcText.sk_out == mc):
					descr = "<font color=\"#00FF00\">Бешенсво</font>\n<font color=\"#FFFFFF\">"+ UserStaticData.buffs_chances[3][ub[3].l]+"% шанс атаковать сквозь защиту</font>\n Следующий уровень - " + UserStaticData.buffs_chances[3][ub[3].l+1] + "%";
					break;
				case(this.mcText.sk_return == mc):
					descr = "<font color=\"#00FF00\">Ответный удар</font>\n<font color=\"#FFFFFF\">"+ UserStaticData.buffs_chances[4][ub[4].l]+"% шанс нанести ответный удар</font>\n Следующий уровень - " + UserStaticData.buffs_chances[4][ub[4].l+1] + "%";
					break;
				case (this.mcText.sk_ult == mc):
					switch(UserStaticData.hero.units[WinCastle.currSlotClick].t)
					{
						case 0:
							descr = "<font color=\"#00FF00\">Ярость</font>\n<font color=\"#FFFFFF\">"+ "";
							break;
						case 1:
							descr = "<font color=\"#00FF00\">Лечение</font>\n<font color=\"#FFFFFF\">"+ "";
							break;
						case 2:
							descr = "<font color=\"#00FF00\">Огненная стрела</font>\n<font color=\"#FFFFFF\">"+ "";
							break;
						case 3:
							descr = "<font color=\"#00FF00\">Молния</font>\n<font color=\"#FFFFFF\">"+ "";
							break;
					}
					break;
			}
			if (this.mcText.mcFreeskils.visible)
			{
				descr += "\n\n<font color=\"#00FF00\" size=\"10\">Нажмите что бы улучшить!</font>"
			}
			
			App.info.init(p.x + 35, p.y + 35, { type:0, title:"Навык", txtInfo_w:290, txtInfo_h:48, txtInfo_t:descr} );
		}
		
		
		public function update():void
		{
			
		}
		
		public function frees():void
		{
			if (bin)
			{
				bin = false;
				for (var i:int = 0; i < parts.length; i++)
				{
					this.removeChild(parts[i]);
				}
				if (guns1[heroType] == null)
				{
					this.removeChild(guns1[0]);
				}
				else
				{
					this.removeChild(guns1[heroType]);
					this.removeChild(guns2[heroType]);
				}
				if(App.spr.contains(this))
				     App.spr.removeChild(this);
			}
		}
		
		public function sellItem():void 
		{
			App.lock.init();
			var data1:DataExchange = new DataExchange();
			data1.addEventListener(DataExchangeEvent.ON_RESULT, this.unitSell);
			data1.sendData(COMMANDS.SELL_ITEM_UNIT, JSON2.encode({un:int(WinCastle.currSlotClick), it:itemType}), true);
		}
		
		public function updateInv(invPlace:int, unit:Object):void 
		{
			if (unit.inv[invPlace] != null)
					MovieClip(this.inv_array[invPlace]).gotoAndStop(unit.inv[invPlace].id + 1);
			else MovieClip(this.inv_array[invPlace]).gotoAndStop(1);
		}
		
		private function unitSell(e:DataExchangeEvent):void 
		{
			DataExchange(e.currentTarget).removeEventListener(e.type, unitSell);
			var obj:Object = JSON2.decode(e.result);
			if (!obj.error)
			{
				UserStaticData.hero.silver = obj.s;
				WinCastle.txtCastle.txtSilver.text = String(obj.s);
				
				delete(UserStaticData.hero.units[int(WinCastle.currSlotClick)].it[itemType]);
				App.sound.playSound('gold', App.sound.onVoice, 1);
				WinCastle.getCastle().slots[WinCastle.currSlotClick].unit.itemUpdate(Slot.getUnitItemsArray(UserStaticData.hero.units[WinCastle.currSlotClick]));
				App.lock.frees();
			}
			else
			{
				App.lock.init('Error: '+obj.error)
			    this.putOnOldPlace();
			}
		}
	
	}

}