package artur.display 
{
	import artur.App;
	import artur.units.UnitCache;
	import artur.util.Maker;
	import artur.win.WinCastle;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import report.Report;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Utils.BuffsVars;
	import Utils.json.JSON2;
	
	public class UnitBlank extends Sprite
	{
		public var index:int;
		public var btn:BaseButton;
		private var mcText:txtBlank;
		private var whRect:sideRect = new sideRect();
		private var unit:Object;
		private var unitType:String;
		public static var names:Array = ['Варвар','Омник','Лучник', "Маг"];
		
		public function UnitBlank(index:int, unit:String, chars:Object) 
		{
			this.index = index;
			this.unitType = unit;
			
			this.addChild(new  MyBitMap(App.prepare.cach[10]));
			//whRect
			this.whRect.alpha = 0.01; this.whRect.width = this.width; whRect.height = this.height; this.addChild(this.whRect);
			//btn
			this.addChild(this.btn = new BaseButton(9, 0.9, 2, 'click3', 'over3', 0xFFFFFF)); this.btn.x = 338.75; btn.y = 132; this.btn.addEventListener(MouseEvent.CLICK, this.onBtn);
			// mcText
			this.addChild(this.mcText = new txtBlank());
			this.mcText.txtLife.text = String(chars.hp);
			this.mcText.txtMana.text = String(chars.mp);
			this.mcText.txtDamage.text = String(chars.min_d + ' - ' + chars.max_d);
			this.mcText.txtFizDef.text = String(chars.f_d);
			this.mcText.txtMagDef.text = String(chars.m_d);
			this.mcText.txtGold.text = String(chars.pg);
			this.mcText.txtSilver.text = String(chars.ps);
			this.mcText.txt_sk_crit.text = String(chars.b[BuffsVars.crit].l);
			this.mcText.txt_sk_miss.text = String(chars.b[BuffsVars.miss].l);
			this.mcText.txt_sk_double.text = String(chars.b[BuffsVars.combo].l);
			this.mcText.txt_sk_out.text = String(chars.b[BuffsVars.armorness].l);
			this.mcText.txtName.text = names[index];
			
			this.addSkillListener(this.mcText.sk_crit);
			this.addSkillListener(this.mcText.sk_double);
			this.addSkillListener(this.mcText.sk_out);
			this.addSkillListener(this.mcText.sk_miss);
			//Report.addMassage(this.index + 1);
			this.mcText.sk_ult.gotoAndStop(this.index + 1);
			this.mcText.sk_ult.txt.text = String(this.index + 1);
			
		}
		
		private function addSkillListener(skill:MovieClip):void 
		{
			skill.addEventListener(MouseEvent.MOUSE_OVER, onSkillOver);
			skill.addEventListener(MouseEvent.MOUSE_OUT, onSkillOut);
		}
		
		private function onSkillOver(e:MouseEvent):void 
		{
			var mc:MovieClip = MovieClip(e.currentTarget);
			var p:Point = mc.localToGlobal(new Point(0, 0));
			App.btnOverFilter.color = 0xFFFFFF;
			mc.filters = [App.btnOverFilter];
			var descr:String = "";
			switch(true)
			{
				case(mc == this.mcText.sk_crit):
					descr = "<font color=\"#00FF00\">Критический урон</font>\n<font color=\"#FFFFFF\">наносит в 2 раза больше урона</font>";
					break;
				case(mc == this.mcText.sk_double):
					descr = "<font color=\"#00FF00\">Двойная атака</font>\nбьет указанную цель 2 раза";
					break;
				case(mc == this.mcText.sk_out):
					descr = "<font color=\"#00FF00\">Ярость</font>\nнаносит урон врагу игнорируя его броню";
					break;
				case(mc == this.mcText.sk_miss):
					descr = "<font color=\"#00FF00\">Уворот</font>\nшанс уклониться от удара врага";
					break;
			}
			App.info.init(p.x + 35, p.y + 35, { type:0, title:"Навык", txtInfo_w:300, txtInfo_h:48, txtInfo_t:descr} );
		}

		private function onSkillOut(e:MouseEvent):void
		{
			e.currentTarget.filters = [];
			App.info.frees();
		}
		
		private function onBtn(e:MouseEvent):void 
		{
			var g:int = int(mcText.txtGold.text);
			var s:int = int(mcText.txtSilver.text);
			if (WinCastle.isMoney(g,s))
			{
				App.byeWin.init('Я желаю нанять', names[index], g, s,index);
			}
			else
			{
				
				//dialog pokupki deneg
			}
		}
		
		
		
		private function out(e:MouseEvent):void 
		{
			whRect.alpha = 0.01;
			MovieClip(unit).gotoAndPlay('idle');
			unit.out();
		}
		
		private function over(e:MouseEvent):void 
		{
			whRect.alpha = 0.05;
			unit.over();
			MovieClip(unit).gotoAndPlay('run');
		}
		
		public function init():void
		{
			 unit = UnitCache.getUnit(unitType);
			 unit.init(this);
			 this.addChild(MovieClip(unit));
			 unit.x = 50; unit.y = 95;
			 this.addEventListener(MouseEvent.ROLL_OVER, over);
			 this.addEventListener(MouseEvent.ROLL_OUT, out);
			 
		}
		
		public function update():void
		{
			
		}
		
		public function frees():void
		{
			 unit.frees();
			 this.removeEventListener(MouseEvent.ROLL_OVER, over);
			 this.removeEventListener(MouseEvent.ROLL_OUT, out);
		}
		
	}

}