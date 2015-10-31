package artur.display.battle 
{
	import artur.App;
	import artur.PrepareGr;
	import artur.win.WinCastle;
	import artur.win.WinKyz;
	import artur.win.WinMap;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import report.Report;
	/**
	 * ...
	 * @author Som911
	 */
	public class TopPanel extends Sprite
	{
		private var bg:Bitmap  = PrepareGr.creatBms(new mcBgTopPanel(), false)[0];
		private var mcBtns:mcBtnTopPanel = new mcBtnTopPanel();
		private var mcCurrWin:Array = PrepareGr.creatBms(new mcTopPanelCurrWin(), false);
		public function TopPanel() 
		{
			this.addChild(bg);
			this.addChild(mcBtns);
			for (var i:int = 0; i < mcBtns.numChildren; i++) 
			{
				Sprite(mcBtns.getChildAt(i)).addEventListener(MouseEvent.CLICK, onBtn);
				Sprite(mcBtns.getChildAt(i)).addEventListener(MouseEvent.MOUSE_OVER, over);
				Sprite(mcBtns.getChildAt(i)).addEventListener(MouseEvent.MOUSE_OUT, out);
				Sprite(mcBtns.getChildAt(i)).addEventListener(MouseEvent.MOUSE_DOWN, down);
				Sprite(mcBtns.getChildAt(i)).addEventListener(MouseEvent.MOUSE_UP, up);
				Sprite(mcBtns.getChildAt(i)).buttonMode = true;
			}
			mcBtns.over.mouseChildren = false;
		    mcBtns.over.mouseEnabled = false;
			this.x = 400;
			mcBtns.over.gotoAndStop(1);
		}
		
		private function up(e:MouseEvent):void 
		{
			mcBtns.over.gotoAndStop(1);
		}
		
		private function down(e:MouseEvent):void 
		{
			mcBtns.over.gotoAndStop(2);
			Report.addMassage('MouseDown');
		}
	
		private function out(e:MouseEvent):void 
		{
			mcBtns.over.y = -200;
			mcBtns.over.gotoAndStop(1);
		}
		
		private function over(e:MouseEvent):void 
		{
			mcBtns.over.x = e.currentTarget.x;
			mcBtns.over.y = e.currentTarget.y;
			App.sound.playSound('over1', App.sound.onVoice, 1);
			
		}
		
		private function onBtn(e:MouseEvent):void 
		{
			switch(e.currentTarget.name)
			{
				case 'btnCastle':
					 App.winManajer.swapWin(1);
				 break;
				 case 'btnArena':
				 break;
			     case 'btnUp':
				     App.winManajer.swapWin(0);
				 break;
			 case 'btnMap':
				     App.winManajer.swapWin(2);
				 break;
			 case 'btnKyz':
				    App.winManajer.swapWin(4);
				 break;
			}
			
			App.sound.playSound('click1', App.sound.onVoice, 1);
		}
		
		public function init(clas:Object):void 
		{
			App.spr.addChild(this);
			mcBtns.over.gotoAndStop(1);
			for (var i:int = 0; i < mcBtns.numChildren; i++) 
			{
				mcBtns.getChildAt(i).visible = true;
			}
			
			if (clas is WinCastle) 
			{
				this.addChild(mcCurrWin[0]);
				mcBtns.btnCastle.visible = false;
			}
			else if (clas is WinMap)
			{
				this.addChild(mcCurrWin[2]);
				mcBtns.btnMap.visible = false;
			}
			else if (clas is WinKyz) 
			{
				this.addChild(mcCurrWin[3]);
				mcBtns.btnKyz.visible = false;
			}
			
			this.addChild(mcBtns);
		}
		public function frees():void
		{
			if (parent) parent.removeChild(this);
			for (var i:int = 0; i < mcCurrWin.length; i++) 
			{
				if (this.contains(mcCurrWin[i])) this.removeChild(mcCurrWin[i]);
			}
		}
		
	}

}