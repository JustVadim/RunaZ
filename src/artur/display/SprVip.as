package artur.display 
{
	import artur.App;
	import artur.RasterClip;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Utils.Functions;
	/**
	 * ...
	 * @author Som911
	 */
	public class SprVip extends Sprite
	{
		private var bg:Bitmap = RasterClip.getBitmap(new mcWinVip());
		private var btnClose:BaseButton ;
		private var btnBye:BaseButton;
		private var titleText:TextField = Functions.getTitledTextfield(164.05, 90, 485.1, 37, new Art().fontName, 30, 0xFFD23F, TextFormatAlign.CENTER, "Бонусы VIP акаунта:", 1);
		private var bonus1:TextField =  Functions.getTitledTextfield(172.1, 138.55, 275.05, 67, new Art().fontName, 18, 0xFFFDF4, TextFormatAlign.LEFT, "Золотая рамка и золотой цвет текста в чате", 1);
		private var bonus2:TextField =  Functions.getTitledTextfield(368.15, 222.55, 275.05, 67, new Art().fontName, 18, 0xFFFDF4, TextFormatAlign.LEFT, "Доступ к VIP сложности в мисиях", 1);
		private var bonus3:TextField =  Functions.getTitledTextfield(176.1, 311.1, 275.05, 67, new Art().fontName, 18, 0xFFFDF4, TextFormatAlign.LEFT, "В два раза быстрее востановлениe энергии", 1);
		public function SprVip() 
		{
			this.addChild(bg);
			btnClose = new BaseButton(87);
			btnBye = new BaseButton(88);
			this.addChild(btnClose);
			this.addChild(btnBye);
			btnClose.x = 687.5;
			btnClose.y = 49.65;
			btnBye.x  = 418.5;
			btnBye.y = 403.7;
			this.addChild(titleText);
			this.addChild(bonus1);
			this.addChild(bonus2);
			this.addChild(bonus3);
			bonus1.wordWrap = true;
			bonus2.wordWrap = true;
			bonus3.wordWrap = true;
			var f:GlowFilter = new GlowFilter(0x000000, 1, 3, 3, 2);
			bonus1.filters = [f];
			bonus2.filters = [f];
			bonus3.filters = [f];
			titleText.filters = [f];
            //bonus1.multyline = true;
		}
		public function init():void
		{
			App.spr.addChild(this);
		}
		public function frees():void
		{
			App.spr.removeChild(this);
		}
		
	}

}