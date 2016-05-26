package artur.win {
	import Server.COMMANDS;
	import Server.DataExchange;
	import Utils.Functions;
	import artur.App;
	import artur.McTextCastleWinExtend;
	import artur.RasterClip;
	import artur.display.BaseButton;
	import artur.PrepareGr;
	import artur.util.Maker;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import report.Report;
	
	public class WinBank {
		private var bg:Bitmap = RasterClip.getMovedBitmap(new mcBank());//PrepareGr.creatBms(new mcBank())[0];
		private var close:BaseButton;
		private var mcBtns:mcBankBtns = new mcBankBtns();
		private static var f:GlowFilter = new GlowFilter(0xFFFFFF, 1, 3, 3, 2, 1);
		
		private var textsGold:Array = 
		[
			"Купить 60 золота\nза 5 голосов",
			'Купить 130 золота\nза 10 голосов',
			'Купить 700 золота\nза 50 голосов',
			'Купить 3000 золота\nза 200 голосов',
			'Купить 8200 золота\nза 500 голосов'
		];
		
		private var textsSilver:Array = 
		[
			'Купить 720 серебра\nза 5 голосов',
			'Купить 1560 серебра\nза 10 голосов',
			'Купить 8400 серебра\nза 50 голосов',
			'Купить 36000 серебра\nза 200 голосов',
			'Купить 100000 серебра\nза 500 голосов'
		];
		
		//Report.addMassage("Bank Economy btn: " + String(Number(500 /5)/Number(8200/ 60)));
		/*Report.addMassage("Bank Economy btn" + i + ": " + )
		Report.addMassage("Bank Economy btn" + i + ": " + )
		Report.addMassage("Bank Economy btn" + i + ": " + )
		Report.addMassage("Bank Economy btn" + i + ": " + )*/
		
		public function WinBank() {
			var f:GlowFilter   = new GlowFilter(0, 1, 2, 2, 6, 3);
		    for (var i:int = 0; i < 5; i++) {
				var text1:TextField = Functions.getTitledTextfield(0, 22, 233, 36, new Art().fontName, 13, 0xFFF642, TextFormatAlign.CENTER, "", 1);
				var text2:TextField = Functions.getTitledTextfield(0, 22, 233, 36, new Art().fontName, 13, 0xFFFFFF, TextFormatAlign.CENTER, "", 0.9);
				text1.text = textsGold[i];
				text2.text = textsSilver[i];
				
				
				text1.filters  = [f];
				text2.filters   = [f];
				
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
			mcBtns.icons.mouseChildren = false;
			mcBtns.icons.mouseEnabled  = true;
	   }
	   
	   private function onOut(e:MouseEvent):void {
		    Sprite(e.currentTarget).filters = [];
	   }
	   
	   private function onOver(e:MouseEvent):void {
		   Sprite(e.currentTarget).filters = [f];
	   }
	   
		private function onBtn(e:MouseEvent):void {
			this.frees();
			var mc:MovieClip = MovieClip(e.target);
			//var num:int = this.getNum(mc);
			if(UserStaticData.from == "v") {
					var params:Object =	{
											type: 'item',
											item: this.getNum(mc)
										};
					Main.VK.callMethod('showOrderBox', params);
			} else if (UserStaticData.from == "c") {
				new DataExchange().sendData(COMMANDS.BYE_COINS, String(this.getNum(mc)), false);
			}
		}
		
		private function getNum(mc:MovieClip):int {
			var res:int = 0;
			for (var i:int = 0; i < 5; i++) { 
				if(mc == mcBtns["s" + String(i + 1)]) {
					res = 1 + i * 2;
				} else if(mc == mcBtns["g" + String(i + 1)]) {
					res = i * 2 + 2;
				}
			}
			return res;
		}
		
		private function onClose(e:MouseEvent):void {
			frees();
		}
		
		public function init():void {
			App.sound.playSound('inventar', App.sound.onVoice, 1);
			if (!close) {
				close = new BaseButton(61);
				close.addEventListener(MouseEvent.CLICK, onClose);
				close.x = 410;
				close.y = 400;
			}
			App.spr.addChild(bg);
			App.spr.addChild(close);
			App.spr.addChild(mcBtns);
		}
		
		public function frees():void {
		      App.spr.removeChild(bg);
			  App.spr.removeChild(close);
			  App.spr.removeChild(mcBtns);
		}
	
	}

}