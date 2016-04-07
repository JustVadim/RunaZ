package artur.display {
	import Server.COMMANDS;
	import Server.DataExchange;
	import Utils.json.JSON2;
	import _SN_vk.events.CustomEvent;
	import artur.RasterClip;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import report.Report;
	
	public class UpPanel extends Sprite {
		private var btns:Array;
		private var settingsNum:int = 8451;
		
		public function UpPanel() {
			this.y = 600;
			var mc:MovieClip = new bgTopMenu();
			this.addChild(RasterClip.raster(mc, mc.width, mc.height));
		    btns = [new BaseButtonWithGalochka(51, false), new BaseButtonWithGalochka(52, false), new BaseButtonWithGalochka(53, true), new BaseButtonWithGalochka(54, true), new BaseButtonWithGalochka(55, true, -73)];
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
				if(UserStaticData.hero.sett.app_i != 1) {
					this.changeSettings(0, 1);
				}
				BaseButtonWithGalochka(btns[0]).addGalochka();
				this.onVKSettingsChange(null);
				this.checkVKGroup();
				if (UserStaticData.hero.sett.app_fq > 9) {
					BaseButtonWithGalochka(btns[2]).addGalochka();
				} else {
					BaseButtonWithGalochka(btns[2]).removeGalochka();
				}
				this.checkBonus();
			}
		}
		
		private function checkBonus():void {
			var temp:int = UserStaticData.hero.sett.app_i + UserStaticData.hero.sett.app_g + UserStaticData.hero.sett.app_m;
			Report.addMassage("tttteeeempp: " + temp);
			if(temp==3 && UserStaticData.hero.sett.app_fq > 9) {
				BaseButtonWithGalochka(btns[4]).addGalochka();
			} else {
				BaseButtonWithGalochka(btns[4]).removeGalochka();
			}
		}
		
		private function changeSettings(setNum:int, setQty:int):void {
			new DataExchange().sendData(COMMANDS.CHANGE_SETTINGS, "{\"set\":" + setNum + ", \"sq\":" + setQty + "}",false);
		}
		
		public function checkVKGroup():void {
			var url_loader:URLLoader = new URLLoader(new URLRequest("https://api.vk.com/method/groups.isMember?group_id=118450370&user_id=" + UserStaticData.id));
			url_loader.addEventListener(Event.COMPLETE, this.onVkIsGroupCheck);
		}
		
		private function onVkIsGroupCheck(e:Event):void {
			URLLoader(e.target).removeEventListener(e.type, this.onVkIsGroupCheck);
			var obj:Object = JSON2.decode(URLLoader(e.target).data);
			if(obj.response != null) {
				if(obj.response == 0) {
					BaseButtonWithGalochka(btns[3]).removeGalochka();
					if (UserStaticData.hero.sett.app_g == 1) {
						UserStaticData.hero.sett.app_g = 0;
						this.changeSettings(2, 0);
						this.checkBonus();
					}
				} else {
					BaseButtonWithGalochka(btns[3]).addGalochka();
					if (UserStaticData.hero.sett.app_g == 0) {
						UserStaticData.hero.sett.app_g = 1;
						this.changeSettings(2, 1);
						this.checkBonus();
					}
				}
			} else {
				
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
			} else if(btn == BaseButtonWithGalochka(btns[2])) {
				switch(UserStaticData.from) {
					case "v":
						Main.VK.callMethod("showInviteBox");
						break;
				}
			} else if(btn == BaseButtonWithGalochka(btns[3])) {
				switch(UserStaticData.from) {
					case "v":
						navigateToURL(new URLRequest("http://vk.com/club118450370"));
						break;
				}
			}
		}
		
		public function onVKSettingsChange(e:CustomEvent = null):void {
			if (e == null) {
				if(UserStaticData.flash_vars.api_settings < this.settingsNum) {
					BaseButtonWithGalochka(btns[1]).removeGalochka();
					if(UserStaticData.hero.sett.app_m == 1) {
						UserStaticData.hero.sett.app_m = 0;
						this.changeSettings(1, 0);
						this.checkBonus();
					}
				} else {
					BaseButtonWithGalochka(btns[1]).addGalochka();
					if(UserStaticData.hero.sett.app_m == 0) {
						UserStaticData.hero.sett.app_m = 1;
						this.changeSettings(1, 1);
						this.checkBonus();
					}
				}
			} else {
				if (UserStaticData.flash_vars.api_settings != e.params[0]) {
					UserStaticData.flash_vars.api_settings = e.params[0];
					if(UserStaticData.flash_vars.api_settings < this.settingsNum) {
						BaseButtonWithGalochka(btns[1]).removeGalochka();
						if(UserStaticData.hero.sett.app_m == 1) {
							UserStaticData.hero.sett.app_m = 0;
							this.changeSettings(1, 0);
							this.checkBonus();
						}
					} else {
						BaseButtonWithGalochka(btns[1]).addGalochka();
						if(UserStaticData.hero.sett.app_m == 0) {
							UserStaticData.hero.sett.app_m = 1;
							this.changeSettings(1, 1);
							this.checkBonus();
						}
					}
				}
			}
		}
	}

}