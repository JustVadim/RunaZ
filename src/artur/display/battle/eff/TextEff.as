package artur.display.battle.eff 
{
	import artur.App;
	import artur.util.Maker;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class TextEff 
	{
		public var type:String = 'text';
		public var free:Boolean = true;
		private var txt:TextField = Maker.getTextField(100, 20, 0xFFFFFF, false, false, false);	
		
		public function TextEff() 
		{ 
			App.btnOverFilter.color = 0x000000;
			this.txt.filters = [App.btnOverFilter];
			this.txt.selectable = false;
			this.txt.mouseEnabled = false;
			this.txt.tabEnabled = false;
			this.txt.autoSize = TextFieldAutoSize.CENTER;
		}
		public function init(xp:int,yp:int,str:String,txtColor:uint= 0xFFFFFF):void
		{
			txt.text = str;
			txt.x = xp - txt.width / 2;
			if (txt.x < 0)
				txt.x = 5;
			txt.y = yp;
			txt.alpha = 1;
			free = false;
			Main.THIS.stage.addChild(txt);
			txt.textColor = txtColor;
			
		}
		public function update():void
		{
			if (!free) 
			{
				txt.y-=1.25;
				txt.alpha -= 0.02
				if ( txt.alpha < 0 ) 
				{
					frees();
				}
			}
		}
		public function frees():void
		{
			if (txt.parent) 
			{
				txt.parent.removeChild(txt);
			}
			free = true;
		}
		
	}

}