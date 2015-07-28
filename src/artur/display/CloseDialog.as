package artur.display 
{
	import artur.App;
	import flash.events.MouseEvent;
	
	public class CloseDialog extends dialogBye
	{
		private var btnEx:BaseButton;
		
		public function CloseDialog() 
		{
			 btnEx = new BaseButton(11); btnEx.x = 507.9; btnEx.y = 258.75 - 100;
			 txtGold.visible = false; iconGold.visible = false
			 txtSilver.visible = false; iconSilver.visible = false;
			 btnEx.addEventListener(MouseEvent.CLICK, onBtn);
			 this.addChild(btnEx);
			 this.txt.y+=20
			 this.txt.height += 20;
		}
		
		private function onBtn(e:MouseEvent):void 
		{
			frees();
		}
		
		public function init(text:String):void
		{
		     App.spr.addChild(this);
			 this.txt.text = text;
		}
		
		private function frees():void 
		{
			if (parent) 
			{
				parent.removeChild(this);
			}
		}
		
	}

}