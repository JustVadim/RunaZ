package artur.display 
{
	import Server.COMMANDS;
	import Server.DataExchange;
	import artur.App;
	import artur.RasterClip;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Utils.Functions;
	
	
	public class SprVip extends Sprite
	{
		private var bg:Bitmap = RasterClip.getBitmap(new mcWinVip());
		private var btnClose:BaseButton ;
		private var btn_Bye:BaseButton;
		private var titleText:TextField = Functions.getTitledTextfield(164.05, 90, 485.1, 37, new Art().fontName, 30, 0xFFD23F, TextFormatAlign.CENTER, "Бонусы VIP акаунта:", 1);
		private var bonus1:TextField =  Functions.getTitledTextfield(172.1, 138.55, 275.05, 67, new Art().fontName, 18, 0xFFFDF4, TextFormatAlign.LEFT, "Золотая рамка и золотой цвет текста в чате", 1);
		private var bonus2:TextField =  Functions.getTitledTextfield(368.15, 222.55, 275.05, 67, new Art().fontName, 18, 0xFFFDF4, TextFormatAlign.LEFT, "Доступ к VIP сложности в мисиях", 1);
		private var bonus3:TextField =  Functions.getTitledTextfield(176.1, 311.1, 275.05, 67, new Art().fontName, 18, 0xFFFDF4, TextFormatAlign.LEFT, "В два раза быстрее востановлениe энергии", 1);
		public function SprVip() 
		{
			this.addChild(bg);
			btnClose = new BaseButton(87);
			btn_Bye = new BaseButton(88);
			this.addChild(btnClose);
			this.addChild(btn_Bye);
			btnClose.x = 687.5;
			btnClose.y = 49.65;
			btn_Bye.x  = 418.5;
			btn_Bye.y = 403.7;
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
			this.btnClose.addEventListener(MouseEvent.CLICK, this.onClick);
			this.btn_Bye.addEventListener(MouseEvent.CLICK, this.onClickBuy);
            //bonus1.multyline = true;
		}
		
		
		private function onClickBuy(e:MouseEvent):void {
			this.frees();
			if(UserStaticData.from == "v") {
					var params:Object =	{
											type: 'item',
											item: 11
										};
					Main.VK.callMethod('showOrderBox', params);
			} else if(UserStaticData.from == "c") {
				new DataExchange().sendData(COMMANDS.BYE_COINS, "11", false);
			}
		}
		
		private function onClick(e:MouseEvent):void {
			this.frees();
		}
		
		public function init():void {
			App.spr.addChild(this);
		}
		
		public function frees():void {
			App.spr.removeChild(this);
		}
		
	}

}