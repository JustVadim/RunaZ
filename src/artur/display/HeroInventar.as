package artur.display
{
	import artur.App;
	import artur.win.WinCastle;
	import com.greensock.TweenLite;
	import datacalsses.Hero;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
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
		private var currInv1:MovieClip = new I_Inv();
		private var currInv2:MovieClip = new I_Inv();
		private var currInv3:MovieClip = new I_Inv();
		private var currInv4:MovieClip = new I_Inv();
		
		private var currGun:MovieClip;
		
		public var guns1:Array =  [new I_WarGun() ,new I_PallGun1() ,new I_Bows()];
		public var guns2:Array = [new MovieClip() ,new I_PallGun2(),new I_PallGun2()];
		
		public var heroType:int;
		public var itemType:int;
		public var itemID:int;
		public var parts:Array = [currHead, currBody, currBoot, currHendTop, currHendDown,currInv1,currInv2,currInv3,currInv4];
		
		public var bin:Boolean = false;
		private var mcText:mcTextHeroInventar = new mcTextHeroInventar();
		private var call:ItemCall;
		private var progresEXP:progresBar = new progresBar();
		public function HeroInventar()
		{
			bg = new MyBitMap(App.prepare.cach[13]);
			this.addChild(bg);
			this.addChild(mcText);
			this.x = 119.75;
			this.y = 60.5;
			var yps:Array = [91, 164.4, 233.1, 133.6, 175.6, 137,177,217,257];
			 
			
			for (var j:int = 0; j < parts.length; j++) 
				 {
				    
					   parts[j].x = 192;
					   parts[j].y = yps[j];
					   parts[j].addEventListener(MouseEvent.ROLL_OVER, over);
					   parts[j].addEventListener(MouseEvent.ROLL_OUT, out);
					   parts[j].addEventListener(MouseEvent.CLICK, onItem);
					   parts[j].addEventListener(MouseEvent.MOUSE_DOWN, strFrag );
					   parts[j].buttonMode = true;
				       parts[j].greenRect.visible = false;
					   parts[j].yRect.visible = false;
					   parts[j].name = String(j);
				 }
				 
				 for (var i:int = 0; i < guns1.length; i++) 
				 {
					 guns1[i].x = 192;
					 guns1[i].y = 165.7;
					 guns1[i].addEventListener(MouseEvent.ROLL_OVER, over);
					 guns1[i].addEventListener(MouseEvent.ROLL_OUT, out);
					 guns1[i].addEventListener(MouseEvent.CLICK, onItem);
					 guns1[i].addEventListener(MouseEvent.MOUSE_DOWN, strFrag );
					 guns1[i].buttonMode = true;
				     guns1[i].greenRect.visible = false;
					 guns1[i].yRect.visible = false;
					 guns1[i].name = String(5);
					 
					 guns2[i].x = 192;
					 guns2[i].y = 165.7;
					 guns2[i].addEventListener(MouseEvent.ROLL_OVER, over);
					 guns2[i].addEventListener(MouseEvent.ROLL_OUT, out);
					 guns2[i].addEventListener(MouseEvent.CLICK, onItem);
					 guns2[i].addEventListener(MouseEvent.MOUSE_DOWN, strFrag );
					 guns2[i].buttonMode = true;
					 if (guns2[i].greenRect)
					 {
				         guns2[i].greenRect.visible = false;
						 guns2[i].yRect.visible = false;
					 }
					 guns2[i].name = String(6);
					 
				 }
				currInv1.x = 40; 
				currInv2.x = currInv1.x ; currInv3.x = currInv2.x ; currInv4.x = currInv3.x ;
		
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
				
				call= ItemCall.getCall();
				call.init(heroType, int(e.currentTarget.name), e.currentTarget.currentFrame - 1);
				call.x = App.spr.mouseX  - call.width/2 +8;
				call.y = App.spr.mouseY - call.height / 2 +8;
				call.startDrag();
				call.addEventListener(MouseEvent.MOUSE_UP, up);
				call.addEventListener(MouseEvent.MOUSE_MOVE, move);
				e.currentTarget.gotoAndStop(1);
				Main.THIS.stage.addEventListener(Event.MOUSE_LEAVE, fo);
			}
		}
		
		private function fo(e:Event):void 
		{
			//Report.addMassage('leav')
			Main.THIS.stage.removeEventListener(Event.MOUSE_LEAVE, fo);
			call.removeEventListener(MouseEvent.MOUSE_UP, up);
			call.removeEventListener(MouseEvent.MOUSE_MOVE,move);
			call.frees();
			Mouse.show();
			call.stopDrag();
			if (this.itemType != 5)
			{
				 MovieClip(parts[this.itemType]).gotoAndStop(this.itemID);
			}
			else
			{
				  MovieClip(guns1[heroType]).gotoAndStop(this.itemID);
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
					WinCastle.chest.selectToPut(obj.n, true);
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
			 App.sound.playSound(ItemCall.sounds[itemType][itemID-2], App.sound.onVoice, 1);
			if (this.itemType < 5)
			{
				 MovieClip(parts[this.itemType]).gotoAndStop(this.itemID);
			}
			else if (this.itemType == 5)
			{
				  MovieClip(guns1[heroType]).gotoAndStop(this.itemID);
			}
			else if (this.itemType == 6)
			{
				 MovieClip(guns2[heroType]).gotoAndStop(this.itemID);
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
				this.init(Slot.getUnitItemsArray(UserStaticData.hero.units[WinCastle.currSlotClick]), heroType, false);
				App.lock.frees();
			}
			else
			{
				App.lock.init('Error: '+obj.error);
			}
			
		}
		
		private function onItem(e:MouseEvent):void 
		{
			if (MovieClip(e.currentTarget).currentFrame==1) 
			{
				WinCastle.shopInventar.init(int(e.currentTarget.name),int(UserStaticData.hero.units[WinCastle.currSlotClick].t) );
			}
		}
		
		private function out(e:MouseEvent):void
		{
			//e.currentTarget.nextFrame();
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
			e.currentTarget.mc.scaleX = 1.3;
			e.currentTarget.mc.scaleY = 1.3;
			App.btnOverFilter.color = 0xFBFBFB;
			e.currentTarget.mc.filters = [App.btnOverFilter];
			if (e.currentTarget.mc2)
			{
				e.currentTarget.mc2.scaleX = 1.3;
				e.currentTarget.mc2.scaleY = 1.3;
				e.currentTarget.mc2.filters = [App.btnOverFilter];
			}
			App.sound.playSound('overItem', App.sound.onVoice, 1);
			if (MovieClip(e.currentTarget).currentFrame == 1)
			{
				App.info.init(e.currentTarget.x + this.x - e.currentTarget.width / 2 - 5 , e.currentTarget.y + this.y + e.currentTarget.height / 2 + 5, {txtInfo_w:135,txtInfo_h:37,txtInfo_t:"Нажмите, чтобы\n купить вещь",type:0} )
			}
			else
			{
				if ((e.currentTarget.name) < 5)
				{
					App.info.init(e.currentTarget.x + this.x - 236 - e.currentTarget.width / 2 - 5 , e.currentTarget.y + this.y + e.currentTarget.height / 2 + 5, { title:"Шмотка", type:2, chars:UserStaticData.hero.units[int(WinCastle.currSlotClick)].it[int(e.currentTarget.name)].c, bye:false } )
				}	
				else
				{
					App.info.init(e.currentTarget.x + this.x - e.currentTarget.width / 2 - 5 , e.currentTarget.y + this.y + e.currentTarget.height / 2 + 5, { title:"Шмотка", type:2, chars:UserStaticData.hero.units[int(WinCastle.currSlotClick)].it[int(e.currentTarget.name)].c, bye:false} )	
				}	  
			}
		}
		
		public function init(obj:Object, heroType:int , anim:Boolean = true):void
		{
			frees();
			if (anim)
			{
				this.alpha = 0;
				this.scaleX = 0.2;
				this.scaleY = 0.2;
				TweenLite.to(this, 0.5, { alpha: 1, scaleX: 1, scaleY: 1 } );
				
			}
			
			for (var i:int = 0; i < parts.length; i++)
			{
				parts[i].gotoAndStop(int(obj[i] + 1));
				this.addChild(parts[i]);
			}
	  	     guns1[heroType].gotoAndStop(int(obj[5] + 1));
			 guns2[heroType].gotoAndStop(int(obj[6] + 1));
			 this.addChild(guns1[heroType]);
			 this.addChild(guns2[heroType]);
			
			
			var chars:Object = [0, UserStaticData.hero.skills.energy , UserStaticData.hero.skills.attack, UserStaticData.hero.skills.defence, UserStaticData.hero.skills.defence];
			var un:Object = UserStaticData.hero.units[int(WinCastle.currSlotClick)]
			for (var key:Object in un.it)
			{
				for (var key2:Object in un.it[key].c )
				{
					chars[int(key2)] += un.it[key].c[key2];
				}
			}
			mcText.txtLife.text = String(un.hp );
			mcText.txtLife2.text = String(chars[0]);
			mcText.txtMana.text = String(un.mp );
			mcText.txtMana2.text = String(chars[1]);
			mcText.txtDmg.text = String(un.min_d +' - ' + un.max_d  );
			mcText.txtDmg2.text =  String(chars[2]);
			mcText.txtFizDeff.text = String(un.f_d);
			mcText.txtFizDeff2.text = String(chars[3]);
			mcText.txtMagDeff.text = String(un.m_d);
			mcText.txtMagDeff2.text = String(chars[4]);
			mcText.txtInic.text = String(un["in"]);
			mcText.txtInic2.text = "0";
			mcText.txtSpeed.text = String(un.sp);
			mcText.txtSpeed2.text = "0";
			mcText.txtDied.text = String(un.l);
			mcText.txtKilled.text = String(un.k);
			this.heroType = heroType;
			bin = true;
			this.addChild(progresEXP); progresEXP.x = 10;  progresEXP.y = 283; this.progresEXP.txt.text = un.exp + "/" + un.nle; this.progresEXP.gotoAndStop(int(100 * un.exp / un.nle));
			this.progresEXP.txt2.text = un.lvl;
			App.spr.addChild(this);
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
				this.removeChild(guns1[heroType]);
				this.removeChild(guns2[heroType]);
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