package artur.display {
	import flash.text.engine.Kerning;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Utils.Functions;
	public class mcTextHeroInventarExtend extends mcTextHeroInventar {
		public var txtLife:McInfoInfos = new McInfoInfos();
		public var txtMana:McInfoInfos = new McInfoInfos();
		public var txtDmg:McInfoInfos = new McInfoInfos();
		public var txtFizDeff:McInfoInfos = new McInfoInfos();
		public var txtMagDeff:McInfoInfos = new McInfoInfos();
		public var txtInic:McInfoInfos = new McInfoInfos();
		public var txtSpeed:McInfoInfos = new McInfoInfos();
		public var died:TextField = Functions.getTitledTextfield( 135, 11, 80, 15, new Art().fontName, 12, 0xFA5454, TextFormatAlign.LEFT, "", 1, Kerning.AUTO, 0);
		public var killed:TextField = Functions.getTitledTextfield( 216, 11, 80, 15, new Art().fontName, 12, 0xB1E724, TextFormatAlign.LEFT, "", 1, Kerning.AUTO, 0);
		public var txt_sk_return:TextField = Functions.getTitledTextfield( 297.55, 39.75, 22, 13, new Art().fontName, 9, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.OFF, -1, true);
		public var txt_sk_double:TextField = Functions.getTitledTextfield( 327.2, 39.75, 22, 13, new Art().fontName, 9, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.OFF, -1, true);
		public var txt_sk_crit:TextField = Functions.getTitledTextfield( 357.25, 39.75, 22, 13, new Art().fontName, 9, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.OFF, -1, true);
		public var txt_sk_out:TextField = Functions.getTitledTextfield( 297.55, 79.75, 22, 13, new Art().fontName, 9, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.OFF, -1, true);
		public var txt_sk_miss:TextField = Functions.getTitledTextfield( 327.2, 79.75, 22, 13, new Art().fontName, 9, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.OFF, -1, true);
		public var txt_sk_ult:TextField = Functions.getTitledTextfield( 357.25, 79.75, 22, 13, new Art().fontName, 9, 0xFFFFFF, TextFormatAlign.CENTER, "", 1, Kerning.OFF, -1, true);
		public var txt_available:TextField = Functions.getTitledTextfield( 295.25, -1, 88.60, 13, new Art().fontName, 10, 0xFAC94E, TextFormatAlign.CENTER, "", 1, Kerning.AUTO, 0, false);
		
		
		public function mcTextHeroInventarExtend() {
			Functions.SetPriteAtributs(this, false, true, 0, 0);
			this.addChild(this.txtLife);
			this.addChild(this.txtMana);
			this.addChild(this.txtDmg);
			this.addChild(this.txtFizDeff);
			this.addChild(this.txtMagDeff);
			this.addChild(this.txtInic);
			this.addChild(this.txtSpeed);
			this.addChild(this.died);
			this.addChild(this.killed);
			this.addChild(this.txt_sk_return);
			this.addChild(this.txt_sk_double);
			this.addChild(this.txt_sk_crit);
			this.addChild(this.txt_sk_out);
			this.addChild(this.txt_sk_miss);
			this.addChild(this.txt_sk_ult);
			this.addChild(this.txt_available);
			this.txtLife.x = this.txtMana.x = this.txtDmg.x = this.txtFizDeff.x = this.txtMagDeff.x = this.txtInic.x = this.txtSpeed.x = -83; 
			this.txtLife.y = -2;
			this.txtMana.y = 15;
			this.txtDmg.y = 32;
			this.txtFizDeff.y = 49;
			this.txtMagDeff.y = 66;
			this.txtInic.y = 83;
			this.txtSpeed.y = 100;
			
			this.txtDmg.txtPlus.visible = false;
			this.txtDmg.txt2.visible = false;
			this.txtDmg.txt1.width = 110;
		}
		
		public function battleInit():void {
			this.txtLife.battleInit();
			this.txtMana.battleInit();
			this.txtDmg.battleInit();
			this.txtFizDeff.battleInit();
			this.txtMagDeff.battleInit();
			this.txtInic.battleInit();
			this.txtSpeed.battleInit();
		}
	}
}