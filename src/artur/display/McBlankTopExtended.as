package artur.display {
	import Server.Lang;
	import Utils.Functions;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filters.GlowFilter;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.text.engine.Kerning;
	import report.Report;
	public class McBlankTopExtended extends mcBlankTop {
		private var txtName:TextField = Functions.getTitledTextfield(70.25, 1, 95.25, 35, new Art().fontName, 12, 0xFFF642, TextFormatAlign.CENTER, UserStaticData.fname + "\n" + UserStaticData.sname, 1, Kerning.OFF, -1, false);
		private var txtLevel:TextField = Functions.getTitledTextfield(258.5, 1, 35.75, 14.5, new Art().fontName, 11, 0xFFF642, TextFormatAlign.CENTER, "22", 1, Kerning.ON, 1, false);
		private var txtExp:TextField = Functions.getTitledTextfield(248, 22, 55, 15, new Art().fontName, 9, 0xFFF642, TextFormatAlign.CENTER, "22222", 1, Kerning.ON, 0.5, false);
		private var place:TextField = Functions.getTitledTextfield(2, 4, 33, 22, new Art().fontName, 18, 0xFFF642, TextFormatAlign.CENTER, "20", 1, Kerning.ON, 0.5, false);
		private var txtGold:TextField = Functions.getTitledTextfield(186.75, -1, 59.75, 16, new Art().fontName, 12, 0xFFF642, TextFormatAlign.CENTER, "99999", 1, Kerning.ON, 0.5, false);
		private var txtSilver:TextField = Functions.getTitledTextfield(186.75, 17, 59.75, 16, new Art().fontName, 12, 0xFFFFFF, TextFormatAlign.CENTER, "99999", 1, Kerning.ON, 0.5, false);
		private var ratText:TextField = Functions.getTitledTextfield(306.5, 18, 50, 16, new Art().fontName, 12, 0xFFF642, TextFormatAlign.CENTER, "99999", 1, Kerning.ON, 0.5, false);
		private var loader:Loader = new Loader();
		
		public function McBlankTopExtended(xx:Number, yy:Number, place:int) {
			this.mouseChildren = false;
			this.x = xx;
			this.y = yy;
			this.buttonMode = true;
			this.tabEnabled = this.tabChildren = false;
			this.place.text = place.toString();
			this.addChild(this.txtName);
			this.addChild(this.txtLevel);
			this.addChild(this.txtExp);
			this.addChild(this.place);
			this.addChild(this.txtGold);
			this.addChild(this.txtSilver);
			this.addChild(this.ratText);
			this.addChild(this.loader);
			this.loader.tabChildren = false;
			this.loader.mouseEnabled = false;
			this.loader.mouseChildren = false;
			this.loader.tabEnabled = false;
			this.loader.x = 35;
			this.loader.y = 1;
			this.txtName.filters = this.txtLevel.filters = this.txtExp.filters = this.place.filters = this.txtGold.filters = this.txtSilver.filters = [new GlowFilter(0x0, 1, 3, 3, 2)];
		}
		
		public function update(obj:Object):void {
			this.visible = obj.ui != null;
			if(this.visible) {
				Functions.compareAndSet(this.txtGold, obj.g);
				Functions.compareAndSet(this.txtSilver, obj.s);
				Functions.compareAndSet(this.txtExp, obj.exp);
				Functions.compareAndSet(this.txtLevel, obj.lvl);
				Functions.compareAndSet(this.txtName, obj.ui.fn + "\n" + obj.ui.sn);
				Functions.compareAndSet(this.ratText, obj.rat);
				this.loader.contentLoaderInfo.addEventListener(Event.UNLOAD, this.onUnload);
				this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoad);
				this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
				this.loader.unload();
				this.loader.load(new URLRequest(obj.ui.pl));
			}
		}
		
		private function onUnload(e:Event):void {
			this.loader.contentLoaderInfo.removeEventListener(Event.UNLOAD, this.onUnload);
			this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoad);
			this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
		}
		
		private function onError(e:IOErrorEvent):void {
			this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoad);
			this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			Report.addMassage("loading error");
		}
		
		private function onLoad(e:Event):void {
			this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoad);
			this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			this.loader.width = 34;
			this.loader.height = 34;
		}
		
	}

}