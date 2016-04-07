package artur.display 
{
	import Server.Lang;
	import artur.App;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import report.Report;
	import Utils.Functions;
	public class WinRootMcText extends Sprite {	
		public var txtAtack:TextField = Functions.getTitledTextfield(39.5, 118.65, 30.35, 19, new Art().fontName, 16, 0xEECB85, TextFormatAlign.CENTER, "12", 0.9, Kerning.OFF, -1);
		public var txtDeff:TextField = Functions.getTitledTextfield(39.5, 143.1, 30.35, 19, new Art().fontName, 16, 0x9CF751, TextFormatAlign.CENTER, "12", 0.9, Kerning.OFF, -1);
		public var txtMana:TextField = Functions.getTitledTextfield(39.5, 167, 30.35, 19, new Art().fontName, 16, 0x99F3F5, TextFormatAlign.CENTER, "12", 0.9, Kerning.OFF, -1);
		public var txtEnergy:TextField = Functions.getTitledTextfield(39.5, 191, 30.35, 19, new Art().fontName, 16, 0xEE930A, TextFormatAlign.CENTER, "12", 0.9, Kerning.OFF, -1);
		private var userArray:Array = [null, new mcUserParam, new mcUserParam, new mcUserParam, new mcUserParam];
		
		public function WinRootMcText() {
			for (var i:int = 1; i < this.userArray.length; i++) {
				var mc:mcUserParam = userArray[i];
				mc.x = 0;
				mc.y = 120 + (i - 1) * mc.height;
				mc.gotoAndStop(i);
				mc.buttonMode = true;
				mc.mouseChildren = false;
				mc.name = i.toString();
				this.addChild(mc);
			}
			Functions.SetPriteAtributs(this, false, true, 0, 0);
			this.txtAtack.filters = this.txtDeff.filters = this.txtMana.filters = this.txtEnergy.filters = [new GlowFilter(0x0, 1, 2, 2, 2, 1, false, false)];
			this.addChild(this.txtAtack);
			this.addChild(this.txtDeff);
			this.addChild(this.txtMana);
			this.addChild(this.txtEnergy);
			this.addEventListener(Event.ADDED_TO_STAGE, this.onAdded);
		}	
		
		private function onAdded(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, this.onAdded);
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
			for (var i:int = 1; i < this.userArray.length; i++) {
				var mc:mcUserParam = this.userArray[i];
				mc.addEventListener(MouseEvent.ROLL_OVER, this.onOver);
				mc.addEventListener(MouseEvent.ROLL_OUT, this.onOut);
			}
		}
		
		private function onOut(e:MouseEvent):void {
			App.info.frees();
		}
		
		private function onOver(e:MouseEvent):void {
			var mc:mcUserParam = mcUserParam(e.target);
			var num:int = int(mc.name) - 1;
			var str:String = "";
			switch(num) {
				case 0:
					str += "+" + UserStaticData.hero.skills.attack + Lang.getTitle(179, num);
					break;
				case 1:
					str += "+" + UserStaticData.hero.skills.defence + Lang.getTitle(179, num);
					break;
				case 2:
					str += "+" + UserStaticData.hero.skills.energy * 10 + Lang.getTitle(179, num);
					break;
				case 3:
					str += UserStaticData.hero.skills.vitality * 10 + Lang.getTitle(179, num);
					break;
			}
			App.info.init( mc.x + 100, mc.y + 30, { title:Lang.getTitle(178, num), txtInfo_w:350, txtInfo_h:37, txtInfo_t:str, type:0 });
		}	
		
		private function onRemoved(e:Event):void {
			this.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
			this.addEventListener(Event.ADDED_TO_STAGE, this.onAdded);
			for (var i:int = 1; i < this.userArray.length; i++) {
				var mc:mcUserParam = this.userArray[i];
				mc.removeEventListener(MouseEvent.ROLL_OVER, this.onOver);
				mc.removeEventListener(MouseEvent.ROLL_OUT, this.onOut);
			}
		}
	}
}