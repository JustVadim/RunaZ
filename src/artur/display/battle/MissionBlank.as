package artur.display.battle {
	import artur.display.BaseButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	import Utils.Functions;
	
	public class MissionBlank extends mcBlankMap {
		
		public var btn:BaseButton = new BaseButton(30);
		private var title:TextField = Functions.getTitledTextfield(-4, 3, 200, 15, new Art().fontName, 11, 0xFFFFFF, TextFormatAlign.CENTER, "", 0.9);
		
		public function MissionBlank(name:int, xx:Number, yy:Number, handl:Function) {
			this.title.filters = [new GlowFilter(0, 1, 1, 1, 1)];
			this.mouseEnabled = this.tabEnabled = this.tabChildren = false;
			this.gotoAndStop(1); this.starBar.gotoAndStop(1);
			this.x = xx; this.y = yy;
			this.addChild(this.btn);
			this.btn.name = name.toString();
			this.btn.addEventListener(MouseEvent.CLICK, handl);
			this.btn.x = 273.75 + this.btn.width / 2; this.btn.y = -9.7 + this.btn.height / 2;
			this.title.mouseEnabled = false;
			this.title.selectable = false;
			this.title.autoSize = TextFieldAutoSize.LEFT;
			this.title.textColor = 0xFFFFFF;
			this.title.y = -9; this.title.x = 17;
			this.addChild(this.title);
		}
		
		public function enableMission():void {
			this.gotoAndStop(2);
			this.btn.visible = true;
			this.title.textColor = 0xFFFFFF;
		}
		
		public function hasComplete(obj:Object):void 
		{
			this.gotoAndStop(3);
			this.btn.visible = true;
			for (var j:int = 0; j < 4; j++) 
			{
				if (obj.st[j] == 1)
					this.starBar['st' + j].visible = true;
				else
					this.starBar['st' + j].visible = false;
			}
			this.title.textColor = 0xFFFFFF;
		}
		
		public function hideMission():void 
		{
			this.gotoAndStop(1);
			this.btn.visible = false;
			this.starBar.st0.visible = false;
			this.starBar.st1.visible = false;
			this.starBar.st2.visible = false;
			this.starBar.st3.visible = false;
			this.title.textColor = 0x797979;
		}
		
		public function setName(title:String):void 
		{
			this.title.text = title;
		}
		
	}
}