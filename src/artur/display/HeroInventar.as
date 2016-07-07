package artur.display
{
	import Utils.BuffsVars;
	import artur.App;
	import artur.ProgressBarExtended;
	import artur.RasterClip;
	import artur.win.WinBattle;
	import artur.win.WinCastle;
	import com.greensock.events.LoaderEvent;
	import com.greensock.TweenLite;
	import datacalsses.Hero;
	import fl.text.TLFTextField;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.ui.Mouse;
	import mx.core.FlexMovieClip;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Server.Lang;
	import Utils.Functions;
	import Utils.json.JSON2;
	import report.Report;
	
	public class HeroInventar extends Sprite  {
		private var bg:Bitmap;
		private var currHead:MovieClip = new I_Head();
		private var currBody:MovieClip = new I_Body();
		private var currBoot:MovieClip  = new I_Boot();
		private var currHendTop:MovieClip = new I_HendTop();
		private var currHendDown:MovieClip = new I_HendDown();
		private var currGun:MovieClip;
		public var guns1:Array =  [new I_WarGun() ,new I_PallGun1() ,new I_Bows(), new I_MagGun()];
		public var guns2:Array = [new MovieClip() , new I_PallGun2(), new MovieClip(), new MovieClip()];
		
		public var heroType:int;
		public var itemType:int;
		public var itemID:int;
		public var invPlace:int;
		public var parts:Array = [currHead, currBody, currBoot, currHendTop, currHendDown];
		public var inv_array:Array = [new I_Inv(), new I_Inv(), new I_Inv(), new I_Inv()];
		public var bin:Boolean = false;
		public var removeHeroBtn:BaseButton;
		private var mcText:mcTextHeroInventarExtend = new mcTextHeroInventarExtend();
		private var call:ItemCall;
		private var progresEXP:ProgressBarExtended = new ProgressBarExtended();
		private var battle_init:Boolean;
		private var lastDT:String;
		private var bufsArray:Array;
		
		
		public function HeroInventar(battle_init:Boolean = false) {
			this.battle_init = battle_init;
			this.tabEnabled = this.tabChildren = this.mouseEnabled = false;
			this.x = 119.75; this.y = 60.5;
			this.mcText.tabEnabled = this.mcText.tabChildren = false;
			this.bufsArray = [this.mcText.sk_crit, this.mcText.sk_miss, this.mcText.sk_double, this.mcText.sk_out, this.mcText.sk_return, this.mcText.sk_ult];
			
			if (this.battle_init) {
				WinBattle.inv_bg.x = WinBattle.inv_bg.y = -10;
				this.addChild(WinBattle.inv_bg);
				this.progresEXP.x = 5;
				this.progresEXP.y = 295
				this.mouseChildren = false;
				this.scaleX = this.scaleY = 0.9;
				this.mcText.mcFreeskils.visible = false;
				this.mcText.battleInit();
			} else {
				progresEXP.x = 10;  progresEXP.y = 283;
				this.setBuffsBtnsProperties();
			}
			this.addChild(this.bg = RasterClip.getBitmapFromBmd(App.prepare.cach[13]));
			this.addChild(this.mcText);
			var yps:Array = [91, 164.4, 233.1, 133.6, 175.6];
			
			for (var j:int = 0; j < parts.length; j++) {
				setInventarBtnProp(MovieClip(parts[j]), 192, yps[j], j);
				this.addChild(parts[j]);
			}	 
			for (j = 0; j < guns1.length; j++) {
				setInventarBtnProp(guns1[j], 192, 165.7, 5)
				setInventarBtnProp(guns2[j], 192, 165.7, 6)
			}
			for (j = 0; j < inv_array.length; j++) {
				var inv:I_Inv = inv_array[j];
				setInventarBtnProp(inv, 360, 137 + j * 40, 7);
				this.addChild(inv);
			}
			
			function setInventarBtnProp(mc:MovieClip, xx:Number, yy:Number, name:int):void {
				mc.x = xx;
				mc.y = yy;
				mc.buttonMode = true;
				mc.mouseChildren = false;
				if (mc.greenRect) {
					mc.greenRect.visible = false;
					mc.yRect.visible = false;
				}
				mc.name = String(name.toString());
			}
			this.addChild(progresEXP);
			if(!this.battle_init) {
				this.addChild(this.removeHeroBtn = new BaseButton(31));
				this.removeHeroBtn.x = 30;
				this.removeHeroBtn.y = 250;
			}
		}
		
		private function setBuffsBtnsProperties():void {
			for (var i:int = 0; i < bufsArray.length; i++) {
				setProp(MovieClip(bufsArray[i]));
			}
			function setProp(mc:MovieClip):void {
				mc.mouseChildren = false;
				mc.buttonMode = true;
				mc.tabEnabled = false;
				mc.tabChildren = false;
			}
		}
		
		public function init1(unit:Object, anim:Boolean = true, xx:int = 10, yy:int = 50):void {
			this.bin = true;
			if (anim) {
				this.alpha = 0;
				this.scaleX = this.scaleY = 0.2;
				TweenLite.to(this, 0.5, { alpha: 1, scaleX: 1, scaleY: 1 });	
			}
			this.heroType = unit.t;
			var unit_tems_ids:Object = Slot.getUnitItemsArray(unit);
			for (var i:int = 0; i < parts.length; i++) {
				this.parts[i].gotoAndStop(unit_tems_ids[i]+ 1);
			}
			if (guns1[heroType] == null) {
				guns1[0].gotoAndStop(1);
				this.addChild(guns1[0]);
			} else {
				guns1[heroType].gotoAndStop(int(unit_tems_ids[5] + 1));
				guns2[heroType].gotoAndStop(int(unit_tems_ids[6] + 1));
				this.addChild(guns1[heroType]);
				this.addChild(guns2[heroType]);
			}
			for (i = 0; i < inv_array.length; i++) {
				this.updateInv(i, unit);
			}
			var chars:Object;
			if(!this.battle_init) {
				chars = Functions.GetHeroChars();
				this.mcText.mcFreeskils.visible = unit.fs > 0;
				this.enabledAllEvents(true);
				this.initRemoveBtn();
			} else {
				this.x = xx; this.y = yy;
				chars = [0, 0, 0, 0, 0];
			}
			this.calculateUnitStats(chars, unit);
			this.updateSkillsStats(unit);
			if (unit.ult != null) {
				this.mcText.sk_ult.visible = true;
				this.mcText.sk_ult.gotoAndStop(this.heroType + 1);
			} else {
				this.mcText.sk_ult.visible = true;
				this.mcText.sk_ult.gotoAndStop(1);
				
			}
			App.spr.addChild(this);
		}
		
		private function initRemoveBtn():void {
			if(this.removeHeroBtn != null) {
				this.removeHeroBtn.addEventListener(MouseEvent.CLICK, this.onRemoveClick);
				this.removeHeroBtn.addEventListener(MouseEvent.ROLL_OVER, this.onRemoveOver);
				this.removeHeroBtn.addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
			}
		}
		
		private function onRollOut(e:MouseEvent):void {
			App.info.frees();
		}
		
		private function onRemoveOver(e:MouseEvent):void {
			var btn:BaseButton = BaseButton(e.target);
			App.info.init(btn.x + 150, btn.y + 40, { type:0, txtInfo_w:150, txtInfo_h:48, txtInfo_t:Lang.getTitle(167)} );
		}
		
		private function onRemoveClick(e:MouseEvent):void {
			App.info.frees();
			App.byeWin.init(Lang.getTitle(168), Lang.getTitle(169, UserStaticData.hero.units[WinCastle.currSlotClick].t), 0, 800, NaN, 7);
		}
		
		public function calculateUnitStats(chars:Object, unit:Object):void {
			this.compareAndSet(this.mcText.txtLife.txt1, unit.hp);
			this.compareAndSet(this.mcText.txtMana.txt1, unit.mp);
			this.compareAndSet(this.mcText.txtFizDeff.txt1, unit.f_d);
			this.compareAndSet(this.mcText.txtMagDeff.txt1, unit.m_d);
			this.compareAndSet(this.mcText.txtInic.txt1, unit["in"]);
			this.compareAndSet(this.mcText.txtSpeed.txt1, unit.sp);
			if (!this.battle_init) {
				for (var key:Object in unit.it) {
					for (var key2:Object in unit.it[key].c ) {
						chars[int(key2)] += unit.it[key].c[key2];
					}
				}
				this.compareAndSet(this.mcText.txtLife.txt2, chars[0]);
				this.compareAndSet(this.mcText.txtMana.txt2, chars[1]);
				this.compareAndSet(this.mcText.txtFizDeff.txt2, chars[3]);
				this.compareAndSet(this.mcText.txtMagDeff.txt2, chars[4]);
				this.compareAndSet(this.mcText.txtInic.txt2, "0");
				this.compareAndSet(this.mcText.txtSpeed.txt2, "0");
				if (unit.it[5] != null) {
					var minD:int = Functions.getDamage(unit.min_d, unit.max_d, chars[2]);
					var maxD:int = unit.max_d + int(chars[2]);
					this.compareAndSet(this.mcText.txtDmg.txt1, String(" " + minD + " - " + maxD));
					this.mcText.txtDmg.txt1.textColor = 0xFFFFFF;
				} else {
					this.compareAndSet(this.mcText.txtDmg.txt1, Lang.getTitle(191));
					this.mcText.txtDmg.txt1.textColor = 0xFF1717;
				}
			} else {
				this.compareAndSet(this.mcText.txtDmg.txt1, String(" " + unit.min_d + " - " + unit.max_d));
			}
			this.compareAndSet(this.mcText.died, String(Lang.getTitle(35) + unit.l));
			this.compareAndSet(this.mcText.killed, String(Lang.getTitle(34) + unit.k));
			this.compareAndSet(this.progresEXP.lvl, unit.lvl);
			this.compareAndSet(this.progresEXP.exp, String(unit.exp + "/" + unit.nle));
			var frame:int = int(100 * unit.exp / unit.nle);
			if(this.progresEXP.currentFrame != frame) {
				this.progresEXP.gotoAndStop(frame);
			}
		}
		
		private function compareAndSet(textf:TextField, text:String):void {
			if(textf.text != text) {
				textf.text = text;
			}
		}
		
		public function updateInv(invPlace:int, unit:Object):void {
			if (unit.inv[invPlace] != null) {
				MovieClip(this.inv_array[invPlace]).gotoAndStop(unit.inv[invPlace].id + 1);
			}
			else {
				MovieClip(this.inv_array[invPlace]).gotoAndStop(1);
			}
		}
		
		private function updateSkillsStats(unit:Object = null):void {
			if(unit == null) {
				unit = UserStaticData.hero.units[WinCastle.currSlotClick];
			}
			this.compareAndSet(this.mcText.txt_sk_return, unit.b[4].l);
			this.compareAndSet(this.mcText.txt_sk_double, unit.b[2].l);
			this.compareAndSet(this.mcText.txt_sk_crit, unit.b[0].l);
			this.compareAndSet(this.mcText.txt_sk_miss, unit.b[1].l);
			this.compareAndSet(this.mcText.txt_sk_out, unit.b[3].l);
			this.compareAndSet(this.mcText.txt_sk_ult, unit.ult.lvl);
			this.compareAndSet(this.mcText.txt_available, Lang.getTitle(77) + ": " + unit.fs);
		}
		
		public function enabledAllEvents(cond:Boolean): void {
			if(this.bin) {
				var unit:Object = UserStaticData.hero.units[WinCastle.currSlotClick];
				for (var i:int = 0; i < bufsArray.length; i++) {
					this.addBuffEvents(MovieClip(bufsArray[i]), cond, unit);
				}
				for (i = 0; i < parts.length; i++) {
					this.addItemEvents(MovieClip(parts[i]), cond);
				}
				this.addItemEvents(this.guns1[heroType], cond);
				this.addItemEvents(this.guns2[heroType], cond);
				for (i = 0; i < inv_array.length; i++) {
					this.addItemEvents(MovieClip(inv_array[i]), cond);
				}
			}
		}
		
		private function addBuffEvents(mc:MovieClip, cond:Boolean, unit:Object):void {
			if(cond) {
				mc.addEventListener(MouseEvent.ROLL_OVER, this.onBuffOver);
				mc.addEventListener(MouseEvent.ROLL_OUT, this.onBuffOut);
				if(unit.fs) {
					mc.addEventListener(MouseEvent.CLICK, this.onBuffClick);
				}
			} else {
				mc.removeEventListener(MouseEvent.ROLL_OVER, this.onBuffOver);
				mc.removeEventListener(MouseEvent.ROLL_OUT, this.onBuffOut);
				if(mc.hasEventListener(MouseEvent.CLICK)) {
					mc.removeEventListener(MouseEvent.CLICK, this.onBuffClick);
				}
			}
		}
		
		private function onBuffOver(e:MouseEvent):void {
			var mc:MovieClip = MovieClip(e.target);
			App.sound.playSound('over2', App.sound.onVoice, 1);
			if (this.mcText.mcFreeskils.visible)
			{
				App.btnOverFilter.color = 0xFFFFFF;
				mc.filters = [App.btnOverFilter];
			}
			var p:Point = mc.localToGlobal(new Point(0, 0));
			var descr:String = "";
			var ub:Object = UserStaticData.hero.units[WinCastle.currSlotClick].b;
			var bc:Object = UserStaticData.buffs_chances;
			var uult:Object = UserStaticData.hero.units[WinCastle.currSlotClick].ult;
			
			
			if (mc != this.mcText.sk_ult) {
				var buff_num:int;
				switch(mc) {
					case this.mcText.sk_crit:
						buff_num = 0;
						break;
					case this.mcText.sk_miss:
						buff_num = 1;
						break;
					case this.mcText.sk_double:
						buff_num = 2
						break;
					case this.mcText.sk_out:
						buff_num = 3;
						break;
					case this.mcText.sk_return:
						buff_num = 4;
						break;
						
				}
				descr = "<font color=\"#00FF00\">" + Lang.getTitle(5 + buff_num) +"</font>\n<font color=\"#FFFFFF\">" + bc[buff_num][ub[buff_num].l] + "% " + Lang.getTitle(10, buff_num);
				if(ub[buff_num].l < 24) {
					descr += "\n" +  "<font color=\"#11B1FF\">" + Lang.getTitle(11) + ": " + bc[buff_num][ub[buff_num].l + 1] + "%</font>";
				} else {
					descr += "\n" +  "<font color=\"#11B1FF\">" + Lang.getTitle(12) + "%</font>";
				}
				
			} else {
				var type:int = UserStaticData.hero.units[WinCastle.currSlotClick].t;
				descr = Lang.getUltimateText(type, uult.lvl);
			}
			if (this.mcText.mcFreeskils.visible) {
				descr += "\n\n<font color=\"#00FF00\" size=\"10\">" + Lang.getTitle(30) + "</font>"
			}
			App.info.init(p.x + 35, p.y + 35, { type:0, title:Lang.getTitle(31), txtInfo_w:290, txtInfo_h:48, txtInfo_t:descr} );
		}
		
		private function onBuffOut(e:MouseEvent):void {
			var mc:MovieClip = MovieClip(e.target);
			mc.filters = [];
			App.info.frees();
		}
		
		private function onBuffClick(e:MouseEvent):void {
			App.tutor.frees();
			var skill_num:int = -1;
			var mc:MovieClip = MovieClip(e.currentTarget);
			switch(true) {
				case(mc == this.mcText.sk_crit):
					skill_num = 0;
					break;
				case(this.mcText.sk_miss == mc):
					skill_num = 1;
					break;
				case(this.mcText.sk_double == mc):
					skill_num = 2;
					break;
				case(this.mcText.sk_out == mc):
					skill_num = 3;
					break;
				case(this.mcText.sk_return == mc):
					skill_num = 4;
					break;
				default:
					skill_num = 5
					break;
			}
			var lvl:int = (skill_num < 5)? UserStaticData.hero.units[WinCastle.currSlotClick].b[skill_num].l:UserStaticData.hero.units[WinCastle.currSlotClick].ult.lvl;
			if (lvl < 24) {
				App.lock.init();
				var obj:Object = new Object();
				obj.un = WinCastle.currSlotClick;
				obj.sn = skill_num;
				var data:DataExchange = new DataExchange();
				data.addEventListener(DataExchangeEvent.ON_RESULT, onBuffUpdateRes);
				data.sendData(COMMANDS.UPDATE_SKILL, JSON2.encode(obj), true);
			} else {
				App.closedDialog.init1("Максимальный уровень любого навыка - 24. Ваш навык имеет максимальную прокачку.");
			}
			
			function onBuffUpdateRes(evn:DataExchangeEvent = null):void {
				data.removeEventListener(evn.type, onBuffUpdateRes);
				obj = JSON2.decode(evn.result);
				if (obj.res != null) {
					App.sound.playSound('skillUp', App.sound.onVoice, 1);
					var unit:Object = UserStaticData.hero.units[WinCastle.currSlotClick];
					unit.fs--;
					var res:int = int(obj.res);
					if (res < 5) {
						unit.b[res].l++;
					} else {
						unit.ult.lvl++;
					}
					Slot(WinCastle.getCastle().slots[WinCastle.currSlotClick]).higlightLvlStar(unit);
					updateSkillsStats();
					onBuffOut(e);
					onBuffOver(e);
					removeClickEventFromBuff(unit.fs == 0);
					mcText.mcFreeskils.visible = unit.fs > 0;
					App.lock.frees();
					if(unit.fs == 0) {
						for(var key:Object in UserStaticData.hero.units) {
							if(UserStaticData.hero.units[key].fs > 0) {
								WinCastle.inst.selectSlot(int(key));
								return;
							}
						}
						App.dialogManager.canShow();
					} else {
						if (UserStaticData.hero.level < 5) {
							App.tutor.init(21);
						}
					}
				}
				else {
					App.lock.init(obj.error);
				}
			}
		}
		
		private function removeClickEventFromBuff(isRemove:Boolean):void {
			if(isRemove) {
				for (var i:int = 0; i < this.bufsArray.length; i++) {
					var mc:MovieClip = MovieClip(this.bufsArray[i]);
					if(mc.hasEventListener(MouseEvent.CLICK)) {
						mc.removeEventListener(MouseEvent.CLICK, this.onBuffClick);
					}
				}
			}
		}
		
		private function addItemEvents(mc:MovieClip, cond:Boolean):void {
			if(cond) {
				mc.addEventListener(MouseEvent.ROLL_OVER, this.itemOver);
				mc.addEventListener(MouseEvent.ROLL_OUT, this.itemOut);
				mc.addEventListener(MouseEvent.CLICK, this.onItem);
				mc.addEventListener(MouseEvent.MOUSE_DOWN, this.onItemDown);
			} else {
				mc.removeEventListener(MouseEvent.ROLL_OVER, this.itemOver);
				mc.removeEventListener(MouseEvent.ROLL_OUT, this.itemOut);
				mc.removeEventListener(MouseEvent.CLICK, onItem);
				mc.removeEventListener(MouseEvent.MOUSE_DOWN, this.onItemDown);
			}
		}
		
		private function onItemDown(e:MouseEvent):void {
			App.info.frees();
			var mc:MovieClip = MovieClip(e.target);
			if (mc.currentFrame != 1) {
				Mouse.hide();
				this.itemOutDirect(mc);
				App.spr.addChild(WinCastle.mcSell); 
				WinCastle.mcSell.addEventListener(MouseEvent.ROLL_OVER, this.onItemSellOver);
				WinCastle.mcSell.addEventListener(MouseEvent.ROLL_OUT, this.onItemSellOut);
				WinCastle.mcSell.sellSprite.gotoAndStop(1);
				WinCastle.mcSell.gotoAndPlay(1);
				this.itemType = int(mc.name);
				this.itemID = int(mc.currentFrame);
				this.invPlace = this.getIsInv(mc);
				this.call = ItemCall.getCall(); 
				this.call.mouseEnabled = false;
				this.call.init(this.heroType, this.itemType, this.itemID - 1);
				this.call.x = App.spr.mouseX  - this.call.width / 2 + 8;
				this.call.y = App.spr.mouseY - this.call.height / 2 + 8;
				mc.gotoAndStop(1);
				this.enabledAllEvents(false);
				WinCastle.chest.initPutItemEvents(UserStaticData.magazin_items[this.heroType][this.itemType][this.itemID-1]);
				Main.THIS.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.dragMove);
				Main.THIS.stage.addEventListener(Event.MOUSE_LEAVE, onMouseLeave);
				Main.THIS.stage.addEventListener(MouseEvent.MOUSE_UP, this.onItemUp);
			}
		}
		
		private function onItemUp(e:MouseEvent):void {
			if (e.target.name == "sell") {
				this.afterPut();
				var item:Object;
				if (this.invPlace == -1) {
					item = UserStaticData.hero.units[int(WinCastle.currSlotClick)].it[itemType];
					App.byeWin.init(Lang.getTitle(32), Lang.getItemTitle(item.c[103], item.id, item.c[102]), 0, int(item.c[100]) / 2 , NaN, 3, NaN, this.invPlace);
				} else {
					item = UserStaticData.hero.units[int(WinCastle.currSlotClick)].inv[this.invPlace];
					App.byeWin.init(Lang.getTitle(32), Lang.getItemTitle(item.c[103], item.id, item.c[102]), 0, int(item.c[100]) / 2 , NaN, 3, NaN, this.invPlace);
				}
			} else if (e.target is mcCall) { 
				this.afterPut();
				var mcC:mcCall = mcCall(e.target);
				var cellNum:int = int(mcC.name);
				if(WinCastle.chest.isFreeCells(cellNum)) {
					App.lock.init();
					var data:DataExchange = new DataExchange();
					data.addEventListener(DataExchangeEvent.ON_RESULT, this.onPutItemToChest);
					var send_obj:Object = { cn:cellNum, un:int(WinCastle.currSlotClick), it:itemType, invP:this.invPlace };
					data.sendData(COMMANDS.FROM_UNIT_TO_CHEST, JSON2.encode(send_obj), true);
				} else {
					this.putOnOldPlace();
				}
				
			} else {
				this.onMouseLeave(e);
			}
		}
		
		private function onPutItemToChest(e:DataExchangeEvent):void {
			DataExchange(e.currentTarget).removeEventListener(e.type, onPutItemToChest);
			var obj:Object = JSON2.decode(e.result);
			if (obj.error == null) {
				App.sound.playSound('gloves1', App.sound.onVoice, 1);
				var unit:Object = UserStaticData.hero.units[WinCastle.currSlotClick];
				if (this.invPlace == -1) {
					delete(unit.it[this.itemType]);
					WinCastle.getCastle().slots[int(WinCastle.currSlotClick)].unit.itemUpdate(Slot.getUnitItemsArray(unit));
					this.updateItem(this.itemType, 0);
				} else {
					delete(unit.inv[this.invPlace]);
					this.updateInv(this.invPlace, unit);
				}
				UserStaticData.hero.chest = obj.ch;
				delete(obj.ch);
				WinCastle.chest.frees();
				WinCastle.chest.init();
				this.calculateUnitStats(Functions.GetHeroChars(), unit);
				App.lock.frees();
			} else {
				this.putOnOldPlace();
				App.lock.init('Error: ' + obj.error);
			}
		}
		
		private function onItemSellOut(e:MouseEvent):void {
			WinCastle.mcSell.sellSprite.gotoAndStop(1);
		}
		
		private function onItemSellOver(e:MouseEvent):void {
			WinCastle.mcSell.sellSprite.gotoAndStop(2);
		}
		
		private function onMouseLeave(e:Event):void {
			
			this.afterPut();
			this.putOnOldPlace();
		}
		
		public function afterPut():void {
			Main.THIS.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.dragMove);
			Main.THIS.stage.removeEventListener(Event.MOUSE_LEAVE, onMouseLeave);
			Main.THIS.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onItemUp);
			this.call.frees();
			if (WinCastle.mcSell.parent) {
				App.spr.removeChild(WinCastle.mcSell);
			}
			WinCastle.mcSell.removeEventListener(MouseEvent.ROLL_OVER, this.onItemSellOver);
			WinCastle.mcSell.removeEventListener(MouseEvent.ROLL_OUT, this.onItemSellOut);
			WinCastle.mcSell.gotoAndStop(1);
			Mouse.show();
			WinCastle.chest.removePutEvents();
			this.enabledAllEvents(true);
		}
		
		private function dragMove(e:MouseEvent):void {
			this.call.x = Main.THIS.stage.mouseX - this.call.width / 2 +8;
			this.call.y = Main.THIS.stage.mouseY - this.call.height / 2 +8;
		}
		
		private function itemOut(e:MouseEvent):void {
			var mc:MovieClip = MovieClip(e.target);
			this.itemOutDirect(mc);
		}
		
		private function itemOutDirect(mc:MovieClip):void {
			App.info.frees();
			mc.mc.scaleX = 1;
			mc.mc.scaleY = 1;
			mc.mc.filters = [];
			if (mc.mc2) {
				mc.mc2.scaleX = 1;
				mc.mc2.scaleY = 1;
				mc.mc2.filters = [];
			}
		}
		
		private function itemOver(e:MouseEvent):void {
			var bat:MovieClip = MovieClip(e.target);
			var itemId:int = int(bat.name);
			bat.mc.scaleX = 1.3;
			bat.mc.scaleY = 1.3;
			App.btnOverFilter.color = 0xFBFBFB;
			bat.mc.filters = [App.btnOverFilter];
			if (bat.mc2) {
				bat.mc2.scaleX = 1.3;
				bat.mc2.scaleY = 1.3;
				bat.mc2.filters = [App.btnOverFilter];
			}
			App.sound.playSound('overItem', App.sound.onVoice, 1);
			if (bat.currentFrame == 1) {
				App.info.init(bat.x + this.x - bat.width / 2 - 5 , bat.y + this.y + bat.height / 2 + 5, {title:Lang.getTitle(1, itemId), txtInfo_w:200, txtInfo_h:37,txtInfo_t:Lang.getTitle(33),type:0} )
			} else {
				var item:Object;
				switch(true) {
					case (itemId < 5):
						item = UserStaticData.hero.units[int(WinCastle.currSlotClick)].it[int(bat.name)];
						App.info.init(bat.x + this.x - 236 - bat.width / 2 - 5 , bat.y + this.y + bat.height / 2 + 5, { title:Lang.getItemTitle(item.c[103], item.id, item.c[102]), type:2, chars:item.c, bye:false } )
						break;
					case (itemId == 5 || itemId == 6):
						item = UserStaticData.hero.units[int(WinCastle.currSlotClick)].it[int(bat.name)];
						App.info.init(bat.x + this.x - bat.width / 2 - 5 , bat.y + this.y + bat.height / 2 + 5, { title:Lang.getItemTitle(item.c[103], item.id, item.c[102]), type:2, chars:item.c, bye:false} )	
						break;
					case (int(bat.name) == 7):
						item = UserStaticData.hero.units[int(WinCastle.currSlotClick)].inv[this.getIsInv(bat)];
						App.info.init(bat.x + this.x - bat.width / 2 - 5 , bat.y + this.y + bat.height / 2 + 12, { title:Lang.getItemTitle(item.c[103], item.id, item.c[102]), type:3, item:item, txtInfo_w:290,level: UserStaticData.hero.units[int(WinCastle.currSlotClick)].lvl, bye:false});
						break;
				}
			}
		}
		
		private function onItem(e:MouseEvent):void {
			var mc:MovieClip = MovieClip(e.currentTarget);
			if (mc.currentFrame == 1) {
				WinCastle.shopInventar.init(int(mc.name), this.heroType, this.getIsInv(mc));
			}
		}
		
		public function getIsInv(mc:MovieClip):int {
			for (var i:int = 0; i < inv_array.length; i++) {
				if (inv_array[i] == mc) {
					return i;
				}
			}
			return -1;
		}
		
		public function putOnOldPlace():void {
			App.sound.playSound(ItemCall.sounds[itemType][itemID - 2], App.sound.onVoice, 1); 
			switch(true) {
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
		
		public function sellItem():void {
			App.lock.init();
			var data:DataExchange = new DataExchange();
			data.addEventListener(DataExchangeEvent.ON_RESULT, this.sellItemResult);
			data.sendData(COMMANDS.SELL_ITEM_UNIT, JSON2.encode({un:int(WinCastle.currSlotClick), it:itemType, invP:this.invPlace}), true);
		}
		
		private function sellItemResult(e:DataExchangeEvent):void {
			DataExchange(e.currentTarget).removeEventListener(e.type, this.sellItemResult);
			var obj:Object = JSON2.decode(e.result);
			if (!obj.error) {
				UserStaticData.hero.silver = obj.s;
				App.topMenu.updateGold();
				if(this.invPlace == -1) {
					delete(UserStaticData.hero.units[int(WinCastle.currSlotClick)].it[itemType]);
				} else {
					delete(UserStaticData.hero.units[int(WinCastle.currSlotClick)].inv[this.invPlace]);
				}
				this.calculateUnitStats(Functions.GetHeroChars(), UserStaticData.hero.units[WinCastle.currSlotClick]);
				App.sound.playSound('gold', App.sound.onVoice, 1);
				WinCastle.getCastle().slots[WinCastle.currSlotClick].unit.itemUpdate(Slot.getUnitItemsArray(UserStaticData.hero.units[WinCastle.currSlotClick]));
				App.lock.frees();
			} else {
				App.lock.init('Error: '+obj.error)
			    this.putOnOldPlace();
			}
		}
		
		public function updateItem(itemType:int, index:int):void {
			switch(true) {
				case itemType < 5:
					this.parts[itemType].gotoAndStop(index + 1);
					break;
				case itemType == 5:
					this.guns1[this.heroType].gotoAndStop(index + 1);
					break;
				case itemType == 6:
					this.guns2[this.heroType].gotoAndStop(index + 1);
					break;
			}
		}
		
		public function showGreenInv(uppedItemObj:Object):void {
			if (this.bin) {
				var lvl:int = (uppedItemObj.c[108] == null)? 1:uppedItemObj.c[108];
				if (UserStaticData.hero.units[WinCastle.currSlotClick].lvl < lvl) {
					return;
				}
				var type:int = uppedItemObj.c[103];
				var unit:Object = UserStaticData.hero.units[WinCastle.currSlotClick];
				switch(true) {
					case type < 5:
						if(UserStaticData.hero.units[WinCastle.currSlotClick].it[type] == null) {
							this.addChestEvents(this.parts[type]);
						}
						break;
					case ((type == 5) || (type == 6)):
						if (this.heroType == uppedItemObj.c[102]) {
							if(type == 5) {
								if(unit.it[5] == null) {
									this.addChestEvents(this.guns1[this.heroType]);
								}
							} else {
								if(unit.it[6] == null) {
									this.addChestEvents(this.guns2[this.heroType]);
								}
							}
						}
						break;
					case type == 7:
						for (var i:int = 0; i < this.inv_array.length; i++) {
							if(unit.inv[i] == null) {
								this.addChestEvents(this.inv_array[i]);
							}
						}
						break;
				}
			}
		}
		
		public function hideGreenInv(uppedItemObj:Object):void {
			if (this.bin) {
				var type:int = uppedItemObj.c[103];
				var unit:Object = UserStaticData.hero.units[WinCastle.currSlotClick];
				switch(true) {
					case type < 5:
						if(UserStaticData.hero.units[WinCastle.currSlotClick].it[type] == null) {
							this.removeChestEvents(this.parts[type]);
						}
						break;
					case ((type == 5) || (type == 6)):
						if (this.heroType == uppedItemObj.c[102]) {
							if(type == 5) {
								if(unit.it[5] == null) {
									this.removeChestEvents(this.guns1[this.heroType]);
								}
							} else {
								if(unit.it[6] == null) {
									this.removeChestEvents(this.guns2[this.heroType]);
								}
							}
						}
						break;
					case type == 7:
						for (var i:int = 0; i < this.inv_array.length; i++) {
							if(unit.inv[i] == null) {
								this.removeChestEvents(this.inv_array[i]);
							}
						}
						break;
				}
			}
		}
		
		private function addChestEvents(mc:MovieClip):void {
			mc.addEventListener(MouseEvent.ROLL_OVER, this.onChestPutOver);
			mc.addEventListener(MouseEvent.ROLL_OUT, this.onChestPutOut);
			mc.greenRect.visible = true;
		}
		
		private function removeChestEvents(mc:MovieClip):void {
			mc.removeEventListener(MouseEvent.ROLL_OVER, this.onChestPutOver);
			mc.removeEventListener(MouseEvent.ROLL_OUT, this.onChestPutOut);
			mc.greenRect.visible = false;
			mc.yRect.visible = false;
		}
		
		private function onChestPutOut(e:MouseEvent):void {
			var mc:MovieClip = MovieClip(e.currentTarget);
			mc.greenRect.visible = true;
			mc.yRect.visible = false;
		}
		
		private function onChestPutOver(e:MouseEvent):void {
			var mc:MovieClip = MovieClip(e.currentTarget);
			mc.greenRect.visible = false;
			mc.yRect.visible = true;
		}
		
		public function frees1():void {
			if (this.bin) {
				Report.addMassage("freesssss");
				if(!this.battle_init) {
					this.enabledAllEvents(false);
				}
				if(this.guns1[this.heroType] == null) {
					this.removeChild(this.guns1[0]);
				} else {
					this.removeChild(this.guns1[heroType]);
					this.removeChild(this.guns2[heroType]);
				}
				if(this.parent) {
					this.parent.removeChild(this);
				}
				this.bin = false;
			}			
		}
	}
}