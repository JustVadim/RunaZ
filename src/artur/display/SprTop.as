package artur.display 
{
	import artur.App;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Som911
	 */
	public class SprTop extends mcTopBg
	{
		private var btnReiting:BaseButton;
		private var btnGold:BaseButton;
		private var btnLevel:BaseButton;
		private var _btns:Array;
		private var btns:Array;
		private var btnClose:BaseButton
		public function SprTop() 
		{
			btnClose = new BaseButton(31); btnClose.x = 571.9; btnClose.y = 17.8;
			
			btnReiting = new BaseButton(67);
			btnGold = new BaseButton(67);
			btnLevel = new BaseButton(67);
			_btns = [this.b1, this.b2, this.b3];
			btns = [btnReiting, btnGold, btnLevel];
			for (var i:int = 0; i < _btns.length; i++) 
			{
				btns[i].x = _btns[i].x;
				btns[i].y = _btns[i].y;
				btns[i].name = String(i);
				this.addChild(btns[i]);
				BaseButton(btns[i]).addEventListener(MouseEvent.CLICK, onBtn);
			}
			hideCurrBtn(0);
			this.addChild(btnClose)
		}
		public function init():void
		{
			App.spr.addChild(this);
		}
		private function onBtn(e:MouseEvent):void 
		{
			hideCurrBtn(int(e.currentTarget.name));
		}
		public function hideCurrBtn(index:int):void
		{
			btns[index].visible = false;
			for (var i:int = 0; i < btns.length; i++) 
			{
				if (i != index)
				btns[i].visible = true;
				_btns[i].visible = !btns[i].visible 
			}
		}
		
	}

}