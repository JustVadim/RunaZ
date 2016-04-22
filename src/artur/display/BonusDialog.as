package artur.display 
{
	import Server.Lang;
	import Utils.Functions;
	import artur.App;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.text.engine.Kerning;
	public class BonusDialog extends mcDialogBonus {
		
		private var txt:TextField = Functions.getTitledTextfield(265, 163, 263, 150, new Art().fontName, 13, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.AUTO, 0, false, 2);
		private var title:TextField = Functions.getTitledTextfield(313, 38, 160, 52, new Art().fontName, 18, 0x00DF00, TextFormatAlign.CENTER, "Ежедневный\nБонус", 1, Kerning.AUTO, 0, false, 2);
		private var btnEx:BaseButton = new BaseButton(15);
		
		public function BonusDialog() {
			Functions.SetPriteAtributs(this, false, true);
			this.txt.filters = this.title.filters = [new GlowFilter(0x0, 1, 2, 2)];;
			this.txt.wordWrap = this.txt.multiline = true;
			this.btnEx.x = 400;
			this.btnEx.y = 315;
			this.addChild(this.txt);
			this.addChild(this.title);
			this.addChild(this.btnEx);
		}	
		
		public function init(type:int):void {
			switch(type) {
				case 0:
					Functions.compareAndSet(this.title, Lang.getTitle(164));
					Functions.compareAndSetHTML(this.txt, Lang.getTitle(165));
					UserStaticData.hero.gold += 5;
					UserStaticData.hero.cur_vitality += 50;
					App.sound.playSound("gold", App.sound.onVoice, 1);
					this.txt.y = 150;
					break;
			}
			this.txt.height = 20 * this.txt.numLines;
			App.topMenu.updateGold();
			App.topMenu.updateAva();
			App.spr.addChild(this);
			this.btnEx.addEventListener(MouseEvent.CLICK, this.onClick);
		}
		
		private function onClick(e:MouseEvent):void {
			this.frees();
		}
		
		public function frees():void {
			App.dialogManager.canShow();
			if (this.parent) {
				this.btnEx.removeEventListener(MouseEvent.CLICK, this.onClick);
				this.parent.removeChild(this);
			}
		}
	}

}