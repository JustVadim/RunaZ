package artur.display.battle 
{
	import artur.App;
	import artur.PrepareGr;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Som911
	 */
	public class TopPanelBattle extends Sprite
	{
		private var bg:Bitmap  = PrepareGr.creatBms(new mcBgTopPanelBatle(), false)[0];
		private var mcBtns:mcBtnTopPanelBatle = new mcBtnTopPanelBatle();
		private var btns:Array = [];
		private var txts:Array = [];
		private var bmActive:Bitmap = PrepareGr.creatBms(new mcActiveAuto(), false)[0];
		private var bmActive2:Bitmap = PrepareGr.creatBms(new mcBtnsTopPanelBattle(), false)[0];
		public function TopPanelBattle() 
		{
			this.addChild(bg);
			this.addChild(bmActive);
			this.addChild(bmActive2);
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
			btns = [mcBtns.btnHold, mcBtns.btnAuto, mcBtns.btnFree];
			txts  = ['Удержание', "Автобой", "Сдаться"];
		}
		
		public function init():void 
		{
			App.spr.addChild(this);
			mcBtns.over.gotoAndStop(1);
			bmActive.visible = false;  
		    bmActive2.visible = !bmActive.visible;
			mcBtns.btnFree.visible = bmActive2.visible;
			mcBtns.btnHold.visible = bmActive2.visible
		}
		
		private function up(e:MouseEvent):void 
		{
			mcBtns.over.gotoAndStop(1);
		}
		
		private function down(e:MouseEvent):void 
		{
			mcBtns.over.gotoAndStop(2);
		}
	
		private function out(e:MouseEvent):void 
		{
			mcBtns.over.y = -200;
			mcBtns.over.gotoAndStop(1);
			App.info.frees();
		}
		
		private function over(e:MouseEvent):void 
		{
			mcBtns.over.x = e.currentTarget.x;
			mcBtns.over.y = e.currentTarget.y;
			App.sound.playSound('over1', App.sound.onVoice, 1);
			var t:String
			for (var i:int = 0; i < btns.length; i++) 
			{
				if (e.currentTarget.name == btns[i].name)
					t = txts[i]
			}
			App.info.init( e.currentTarget.x+ this.x+40, e.currentTarget.y+ 60, { txtInfo_w:100, txtInfo_h:37, txtInfo_t:t, type:0 } );
			
			
		}
		
		private function onBtn(e:MouseEvent):void 
		{
			switch(e.currentTarget.name)
			{
				case 'btnHold':
					 
				 break;
			     case 'btnAuto':
				     if (!bmActive.visible)
					 {
						  
					 }
					 else
					 {
						 
					 }
					 bmActive.visible = !bmActive.visible;
					 
		             bmActive2.visible = !bmActive.visible;
			         mcBtns.btnFree.visible = bmActive2.visible;
			         mcBtns.btnHold.visible = bmActive2.visible
					 
				 break;
			     case 'btnFree':
				     
				 break;
			
			}
			
			App.sound.playSound('click1', App.sound.onVoice, 1);
		}
	}

}