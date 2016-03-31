package artur.display {
	import _SN_vk.events.CustomEvent;
	import artur.RasterClip;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import report.Report;
	
	public class UpPanel extends Sprite {
		private var btns:Array;
		private var settingsNum:int = 8451;
		
		public function UpPanel() {
			this.y = 600;
			var mc:MovieClip = new bgTopMenu();
			this.addChild(RasterClip.raster(mc, mc.width, mc.height));
		    btns = [new BaseButtonWithGalochka(51), new BaseButtonWithGalochka(52), new BaseButtonWithGalochka(53), new BaseButtonWithGalochka(54), new BaseButtonWithGalochka(55, -73)];
			var xps:Array = [127.5, 257.5, 387.5, 517.5, 659.75];
			
			
			for (var i:int = 0; i < btns.length; i++) {
				var btn:BaseButtonWithGalochka = btns[i];
				btn.x  = xps[i]; btn.y  = 38;
				this.addChild(btn);
				btn.addEventListener(MouseEvent.CLICK, this.onBtnClick);
			}
			
			if(UserStaticData.from == "c") {
				BaseButtonWithGalochka(btns[0]).addGalochka();
				BaseButtonWithGalochka(btns[1]).addGalochka();
				BaseButtonWithGalochka(btns[2]).addGalochka();
				BaseButtonWithGalochka(btns[3]).addGalochka();
				BaseButtonWithGalochka(btns[4]).addGalochka();
			} else if(UserStaticData.from == "v") {
				BaseButtonWithGalochka(btns[0]).addGalochka();
				this.onVKSettingsChange(null);
			}
		}
		
		private function onBtnClick(e:MouseEvent):void {
			var btn:BaseButtonWithGalochka = BaseButtonWithGalochka(e.target);
			if(btn == BaseButtonWithGalochka(btns[1])) {
				switch(UserStaticData.from) {
					case "v":
						Main.VK.callMethod("showSettingsBox", 257);
						break;
				}
			}
		}
		
		public function onVKSettingsChange(e:CustomEvent = null):void {
			if (e == null) {
				Report.addMassage("base settings " + UserStaticData.flash_vars.api_settings);
				if(UserStaticData.flash_vars.api_settings < this.settingsNum) {
					BaseButtonWithGalochka(btns[1]).removeGalochka();
				} else {
					BaseButtonWithGalochka(btns[1]).addGalochka();
				}
			} else {
				Report.addMassage("settingsChange " + e.params[0]);
				if (UserStaticData.flash_vars.api_settings != e.params[0]) {
					UserStaticData.flash_vars.api_settings = e.params[0];
					if(UserStaticData.flash_vars.api_settings < this.settingsNum) {
						BaseButtonWithGalochka(btns[1]).removeGalochka();
					} else {
						BaseButtonWithGalochka(btns[1]).addGalochka();
					}
				}
			}
		}
	}

}