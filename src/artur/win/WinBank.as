package artur.win
{
	import artur.App;
	import artur.display.BaseButton;
	import artur.PrepareGr;
	import artur.util.Maker;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	
	public class WinBank
	{
		private var bg:Bitmap = PrepareGr.creatBms(new mcBank())[0];
		private var close:BaseButton 
		private var mcBtns:mcBankBtns = new mcBankBtns();
		private static var f:GlowFilter = new GlowFilter(0xFFFFFF, 1, 3, 3, 2, 1);
		
		private var textsGold:Array = 
		[
		 'Купить 10 золота за 2 голоса',
		  'Купить 20 золота за 4 голоса',
		  'Купить 40 золота за 8 голоса',
		  'Купить 80 золота за 16 голоса'
		];
		
		private var textsSilver:Array = 
		[
		 'Купить 10 золота за 2 голоса',
		  'Купить 20 золота за 4 голоса',
		  'Купить 40 золота за 8 голоса',
		  'Купить 80 золота за 16 голоса'
		];
		
		
		public function WinBank()
		{
		    for (var i:int = 0; i < 4; i++) 
			{
				var text1:TextField = Maker.getTextField(190, 60, 0xF7E29B, false, false, true,15,0xF7E29B,0xF7E29B,1);
				var text2:TextField = Maker.getTextField(190, 60, 0xFFFFFF, false, false, true);
				text1.text = textsGold[i];
				text2.text = textsSilver[i];
				text1.x = 28;
				text1.y = 20;
				text2.x = 28;
				text2.y = 20;
				mcBtns[String('g' + (i + 1))].addChild(text1);
				mcBtns[String('s' + (i + 1))].addChild(text2);
				mcBtns[String('s' + (i + 1))].buttonMode = true;
				mcBtns[String('g' + (i + 1))].buttonMode = true;
				mcBtns[String('s' + (i + 1))].addEventListener(MouseEvent.CLICK, onBtn);
				mcBtns[String('g' + (i + 1))].addEventListener(MouseEvent.CLICK, onBtn);
				
				mcBtns[String('s' + (i + 1))].addEventListener(MouseEvent.ROLL_OVER, onOver);
				mcBtns[String('g' + (i + 1))].addEventListener(MouseEvent.ROLL_OVER, onOver);
					
				mcBtns[String('s' + (i + 1))].addEventListener(MouseEvent.ROLL_OUT, onOut);
				mcBtns[String('g' + (i + 1))].addEventListener(MouseEvent.ROLL_OUT, onOut);
				 
			}
			
			
	   }
	   
	   private function onOut(e:MouseEvent):void 
	   {
		    Sprite(e.currentTarget).filters = [];
	   }
	   
	   private function onOver(e:MouseEvent):void 
	   {
		   Sprite(e.currentTarget).filters = [f];
	   }
	   
	   private function onBtn(e:MouseEvent):void 
	   {
		   
	   }
		private function onClose(e:MouseEvent):void 
		{
			frees();
		}
		
		public function init():void
		{
			if (!close)
			{
				close = new BaseButton(15);
				close.addEventListener(MouseEvent.CLICK, onClose);
				close.x = 410;
				close.y = 400;
				
			}
			App.spr.addChild(bg);
			App.spr.addChild(close);
			App.spr.addChild(mcBtns);
		}
		
		public function frees():void
		{
		      App.spr.removeChild(bg);
			  App.spr.removeChild(close);
			  App.spr.removeChild(mcBtns);
		}
	
	}

}