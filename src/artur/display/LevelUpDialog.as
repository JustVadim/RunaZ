package artur.display 
{
	import artur.App;
	import artur.RasterClip;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Utils.Functions;
	/**
	 * ...
	 * @author Som911
	 */
	public class LevelUpDialog extends Sprite
	{
		private var bg:Bitmap = RasterClip.raster(new mcUpdSkill(), 800, 440);
		private var btns:Array = [];
		private var txts:Array  = [];
		private var btnOk:BaseButton;
		private var txtUp:TextField  = Functions.getTitledTextfield(317.7, 110.3, 167.5, 26, new Art().fontName, 15, 0x232101, TextFormatAlign.CENTER, "Новый уровень", 1);
		private var txtDown:TextField  = Functions.getTitledTextfield(222.2, 249.4, 167.5, 33.15, new Art().fontName, 20 ,  0xFDDD5B, TextFormatAlign.CENTER, "Ваша награда", 1);
		private var txtGold:TextField  = Functions.getTitledTextfield(447.1, 253.05, 48, 28, new Art().fontName, 20 , 0xFDDD5B, TextFormatAlign.CENTER, "10", 1);
		private var txtSilver:TextField  = Functions.getTitledTextfield(527.65, 253.05, 48, 28, new Art().fontName, 20 , 0xC0C0C0, TextFormatAlign.CENTER, "50", 1);
		
		public function LevelUpDialog() 
		{
			var f:GlowFilter = new GlowFilter(0x000000, 0.5);
			this.addChild(bg);
			this.addChild(txtUp);
			this.addChild(txtDown);
			this.addChild(txtGold);
			this.addChild(txtSilver);
			txtDown.filters = [f];
			txtSilver.filters = [f];
			txtGold.filters = [f];
			for (var i:int = 0; i < 4; i++) 
			{
			   
				var btn:BaseButton = new BaseButton(74 + i);
				
				btns.push(btn);
				
				btn.name = String(i);
				btn.x = 282.75 + i * 75;
				btn.y = 194.25;
				this.addChild(btn);
				var txt:TextField = Functions.getTitledTextfield(btn.x -18, btn.y + 20.5, 40, 23, new Art().fontName, 15,0x393502, TextFormatAlign.CENTER, "21", 1);
				btn.addEventListener(MouseEvent.CLICK, onBtn);
				txts.push(txt);
				this.addChild(txt);
				
			}
			btnOk = new BaseButton(78);
			this.addChild(btnOk);
			btnOk.x = 400;
			btnOk.y = 316.85;
			btnOk.addEventListener(MouseEvent.CLICK, onOk);
		}
		
		private function onOk(e:MouseEvent):void 
		{
			
		}
		
		private function onBtn(e:MouseEvent):void 
		{
			
		}
		public function init():void
		{
			App.sound.playSound('levelUp', App.sound.onVoice, 1);
			App.spr.addChild(this);
		}

		
	}

}