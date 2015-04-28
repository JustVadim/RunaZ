package artur.display 
{
	import artur.App;
	import artur.units.UnitCache;
	import artur.win.WinCastle;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import report.Report;
	/**
	 * ...
	 * @author art
	 */
	public class Slot extends Sprite
	{
		 public var btnByeUnit:BaseButton;
		 public var unit:Object;
		 public var bg:slotBg = new slotBg();
		 public static var namesUnit:Object = new Object();//{0:'Barbarian', 1:'Paladin', 2:'Lyk',100:'Bot_1'};
		 namesUnit[0] = 'Barbarian';
		 namesUnit[1] = 'Paladin';
		 namesUnit[2] = 'Lyk';
		 namesUnit[100] = 'Bot1';
		 
		 
		 
		public function Slot() 
		{
			this.tabEnabled = false;
			this.tabChildren = false;
			btnByeUnit = new BaseButton(8, 0.9, 5, 'click1', 'over1', 0x000000);
			this.addEventListener(MouseEvent.CLICK, onSlotClick);
			this.addEventListener(MouseEvent.ROLL_OVER, over);
			this.addEventListener(MouseEvent.ROLL_OUT, out);
			this.addChild(bg);
			bg.x = -8;
			this.buttonMode = true;
		}
		
		private function onSlotClick(e:MouseEvent):void 
		{
			if (unit == null)
			{
				this.onBtnAddUnit();
			}
			else
			{
				this.clickUnit();
			}
		}
		
		private function out(e:MouseEvent):void 
		{
			App.info.frees();
			if (!UserStaticData.hero.units[int(e.currentTarget.name)])
			return;
			unit.out();
		}
		
		private function over(e:MouseEvent):void 
		{
			   App.sound.playSound('over1', App.sound.onVoice, 1);
			if (!UserStaticData.hero.units[int(e.currentTarget.name)])
			return;
			
			unit.over();
			var obj:Object = UserStaticData.hero.units[int(e.currentTarget.name)];
			var chars:Object = new Object();
			chars[0] = obj.hp;
			chars[1] = obj.mp;
			chars[2] = obj.min_d;
			chars[3] = obj.f_d;
			chars[4] = obj.m_d;
			chars[5] = obj.sp;
			chars[6] = obj["in"];
			chars[7] = obj.max_d;
			chars[8] = obj.t_d;
			chars[200] = 0;
			chars[201] = UserStaticData.hero.skills.energy;
			chars[202] = UserStaticData.hero.skills.attack;
			chars[203] = UserStaticData.hero.skills.defence;
			chars[204] = UserStaticData.hero.skills.defence;
			chars[205] = 0;
			for (var key:Object in obj.it)
			{
				for (var key2:Object in obj.it[key].c )
				{
					chars[int(key2)+200] += obj.it[key].c[key2];
				}
			}
			 if(WinCastle.currSlotClick != this.name)
			     App.info.init(this.x + this.btnByeUnit.width / 2 + 15 , this.y - (115 / 2), { title:"Варвар", type:1, chars:chars } );
		}
		public function init():void
		{
			
			 if (UserStaticData.hero.units[int(name)] == null) 
			 {
				if (this.unit != null && this.contains(MovieClip(this.unit)))
					this.unit.frees();
				this.addChild(btnByeUnit);
			 }
			 else
			 {
				
				if ( !WinCastle.getCastle().mcCurr.parent )
				{
					WinCastle.currSlotClick = this.name;
					this.addChild(WinCastle.getCastle().mcCurr);
					WinCastle.getCastle().mcCurr.x = -7;
					
					WinCastle.inventar.init(Slot.getUnitItemsArray(UserStaticData.hero.units[this.name]),int(UserStaticData.hero.units[int(this.name)].t));
				}
				else
				{
					if (WinCastle.getCastle().mcCurr.parent == this)
					{
						WinCastle.inventar.init(Slot.getUnitItemsArray(UserStaticData.hero.units[this.name]), int(UserStaticData.hero.units[int(this.name)].t),false);
					}
				}
				
				if (this.contains(this.btnByeUnit))
					this.removeChild(this.btnByeUnit);
				
				 if (unit == null)
				 {
					     this.unit = UnitCache.getUnit(namesUnit[UserStaticData.hero.units[int(this.name)].t]);
						 unit.itemUpdate(Slot.getUnitItemsArray(UserStaticData.hero.units[this.name]));
					     this.unit.init(this);
						 this.unit.x = 0; this.unit.y = 0;
					     
				 }
				 this.addChild(MovieClip(unit));	 
				 MovieClip(unit).y = 39;
				
			}
		}
		
		public  static function getUnitItemsArray( un_obj:Object ):Array
		{
			var arr:Array = new Array();
			 // var un_obj:Object = un_obj // ;
			  for (var i:int = 0; i < 7; i++) 
			  {
					if (un_obj.it[i] == null)
					{
						arr[i] = 0;
					}
					else
					{
						arr[i] = un_obj.it[i].id;
					}
			  }
			  return arr;
		}
		
		public function getItemId(obj:Object):int
		{
			if (obj == null)
				return 0;
			else
				return int(obj.id);
		}
		private function clickUnit():void 
		{
			App.info.frees();
			 if (WinCastle.currSlotClick != this.name)
			 {
				 App.sound.playSound('inventar', App.sound.onVoice, 1);
				 this.addChild(WinCastle.getCastle().mcCurr);
				 WinCastle.currSlotClick = this.name;
				 this.addChild(MovieClip(unit));
				 WinCastle.txtCastle.scroll.visible = false;
				 WinCastle.inventar.init(Slot.getUnitItemsArray(UserStaticData.hero.units[this.name]), int(UserStaticData.hero.units[int(this.name)].t));
			 }
		}
		private function onBtnAddUnit():void 
		{
			WinCastle.txtCastle.scroll.visible = true;
			WinCastle.currSlotClick = this.name;
			this.addChild(WinCastle.getCastle().mcCurr);
			WinCastle.getCastle().mcCurr.x = -7;
			this.addChild(btnByeUnit);
			WinCastle.inventar.frees();
			//Report.addMassage(currSlotClick);
		}
		public function frees():void
		{
			if ( this.contains(WinCastle.getCastle().mcCurr) ) 
			{
				this.removeChild(WinCastle.getCastle().mcCurr);
			}
			if (unit) 
			{
				unit.frees();
				Sprite(unit).removeEventListener(MouseEvent.CLICK, clickUnit);
				unit = null;
			}
		}
		
	}

}