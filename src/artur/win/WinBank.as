package artur.win {
	import Server.COMMANDS;
	import Server.DataExchange;
	import artur.App;
	import artur.McTextCastleWinExtend;
	import artur.display.BaseButton;
	import artur.PrepareGr;
	import artur.util.Maker;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import report.Report;
	
	public class WinBank {
		private var bg:Bitmap = PrepareGr.creatBms(new mcBank())[0];
		private var close:BaseButton;
		private var mcBtns:mcBankBtns = new mcBankBtns();
		private static var f:GlowFilter = new GlowFilter(0xFFFFFF, 1, 3, 3, 2, 1);
		
		private var textsGold:Array = 
		[
			'Купить 25 золота за 2 голоса',
			'Купить 60 золота за 4 голоса',
			'Купить 150 золота за 8 голоса',
			'Купить 400 золота за 16 голоса'
		];
		
		private var textsSilver:Array = 
		[
			'Купить 500 серебра за 2 голоса',
			'Купить 1200 золота за 4 голоса',
			'Купить 3000 золота за 8 голоса',
			'Купить 8000 золота за 16 голоса'
		];
		
		
		public function WinBank() {
		    for (var i:int = 0; i < 4; i++) {
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
	   
	   private function onOut(e:MouseEvent):void {
		    Sprite(e.currentTarget).filters = [];
	   }
	   
	   private function onOver(e:MouseEvent):void {
		   Sprite(e.currentTarget).filters = [f];
	   }
	   
		private function onBtn(e:MouseEvent):void {
			this.frees();
			var mc:MovieClip = MovieClip(e.target);
			var num:int = this.getNum(mc);
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
			for (var i:int = 0; i < 4; i++) { 
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
			if (!close) {
				close = new BaseButton(15);
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