package artur.display 
{
	import artur.App;
	import artur.UnitBlankTxt;
	import artur.units.UnitCache;
	import artur.util.Maker;
	import artur.win.WinCastle;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Server.DataExchangeEvent;
	import Server.Lang;
	import Utils.BuffsVars;
	import Utils.json.JSON2;
	
	public class UnitBlank extends Sprite {
		public var index:int;
		public var btn:BaseButton;
		private var mcText:UnitBlankTxt;
		private var whRect:sideRect = new sideRect();
		private var unit:Object;
		private var unitType:String;
		
		public function UnitBlank(index:int, unit:String, chars:Object) {
			this.index = index;
			this.unitType = unit;
			this.addChild(new  MyBitMap(App.prepare.cach[10]));
			//whRect
			this.whRect.alpha = 0.01; this.whRect.width = this.width; whRect.height = this.height; this.addChild(this.whRect);
			//btn
			this.addChild(this.btn = new BaseButton(9, 0.9, 2, 'click3', 'over3', 0xFFFFFF)); this.btn.x = 338.75; btn.y = 132; this.btn.addEventListener(MouseEvent.CLICK, this.onBtn);
			// mcText
			this.addChild(this.mcText = new UnitBlankTxt());
			this.mcText.txtName.text = Lang.getTitle(38, index);
			this.mcText.txtGold.text = String(chars.pg);
			this.mcText.txtSilver.text = String(chars.ps);
			this.mcText.txt_sk_double.text = String(chars.b[BuffsVars.combo].l);
			this.mcText.txt_sk_crit.text = String(chars.b[BuffsVars.crit].l);
			this.mcText.txt_sk_return.text = String(chars.b[BuffsVars.feedback].l);
			this.mcText.txt_sk_miss.text = String(chars.b[BuffsVars.miss].l);
			this.mcText.txt_sk_out.text = String(chars.b[BuffsVars.armorness].l);
			this.mcText.txt_sk_ult.text = String(1);
			this.mcText.txtLife.text = String(chars.hp);
			this.mcText.txtMana.text = String(chars.mp);
			this.mcText.txtDamage.text = String(chars.min_d + ' - ' + chars.max_d);
			this.mcText.txtFizDef.text = String(chars.f_d);
			this.mcText.txtMagDef.text = String(chars.m_d);
			this.mcText.txtInc.text = String(chars['in']);
			this.mcText.txtSpeed.text = String(chars.sp);
			this.addSkillListener(this.mcText.sk_crit);
			this.addSkillListener(this.mcText.sk_double);
			this.addSkillListener(this.mcText.sk_out);
			this.addSkillListener(this.mcText.sk_miss);
			this.addSkillListener(this.mcText.sk_return);
			this.addSkillListener(MovieClip(this.mcText.sk_ult));
			this.mcText.sk_ult.gotoAndStop(this.index + 1);
		}
		
		private function addSkillListener(skill:MovieClip):void {
			skill.addEventListener(MouseEvent.ROLL_OVER, onSkillOver);
			skill.addEventListener(MouseEvent.ROLL_OUT, onSkillOut);
		}
		
		private function onSkillOver(e:MouseEvent):void {
			var mc:MovieClip = MovieClip(e.currentTarget);
			var p:Point = mc.localToGlobal(new Point(0, 0));
			App.btnOverFilter.color = 0xFFFFFF;
			mc.filters = [App.btnOverFilter];
			var descr:String = "";
			switch(true)
			{
				case(mc == this.mcText.sk_crit):
					descr = "<font color=\"#00FF00\">" + Lang.getTitle(5) + "</font>\n<font color=\"#FFFFFF\">"+Lang.getTitle(80)+"</font>";
					break;
				case(mc == this.mcText.sk_double):
					descr = "<font color=\"#00FF00\">"+ Lang.getTitle(7) +"</font>\n<font color=\"#FFFFFF\">" + Lang.getTitle(79) + "</font>";
					break;
				case(mc == this.mcText.sk_out):
					descr = "<font color=\"#00FF00\">" + Lang.getTitle(8) + "</font>\n<font color=\"#FFFFFF\">"+Lang.getTitle(81)+"</font>";
					break;
				case(mc == this.mcText.sk_miss):
					descr = "<font color=\"#00FF00\">" + Lang.getTitle(6) + "</font>\n<font color=\"#FFFFFF\">" + Lang.getTitle(82) + "</font>";
					break;
				case(this.mcText.sk_return == mc):
					descr = "<font color=\"#00FF00\">" + Lang.getTitle(9) +"</font>\n<font color=\"#FFFFFF\">" + Lang.getTitle(83) + "</font>";
					break;
				case (this.mcText.sk_ult == mc):
					descr = "<font color=\"#00FF00\">" + Lang.getTitle(13, this.index) + "</font>";
					descr += "\n" + Lang.getTitle(14, this.index);
					break;
			}
			App.info.init(p.x + 35, p.y + 35, { type:0, title:Lang.getTitle(31), txtInfo_w:300, txtInfo_h:48, txtInfo_t:descr} );
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
			if (WinCastle.isMoney(g,s)) {
				App.byeWin.init(Lang.getTitle(39), Lang.getTitle(38, index), g, s,index);
			} else {
				App.closedDialog.init1(Lang.getTitle(4), false, true, true);
			}
		}
		
		
		
		private function out(e:MouseEvent):void {
			whRect.alpha = 0.01;
			MovieClip(unit).gotoAndPlay('idle');
			unit.out();
		}
		
		private function over(e:MouseEvent):void {
			whRect.alpha = 0.05;
			unit.over();
			MovieClip(unit).gotoAndPlay('run');
		}
		
		public function init():void {
			unit = UnitCache.getUnit(unitType);
			unit.init(this);
			this.addChild(MovieClip(unit));
			unit.x = 50; unit.y = 95;
			this.addEventListener(MouseEvent.ROLL_OVER, over);
			this.addEventListener(MouseEvent.ROLL_OUT, out);
			this.addEventListener(MouseEvent.CLICK, this.onBtn);
			this.buttonMode = true;
		}
		
		public function update():void {
			
		}
		
		public function frees():void {
			 unit.frees();
			 this.removeEventListener(MouseEvent.ROLL_OVER, over);
			 this.removeEventListener(MouseEvent.ROLL_OUT, out);
		}
		
	}

}