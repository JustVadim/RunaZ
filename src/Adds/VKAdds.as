package Adds 
{
	import artur.App;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import report.Report;
	public class VKAdds {
		public static var vkContainer:Object;
		private static var loader:Loader = new Loader();
		
		public static function init():void {
			new URLLoader().load(new URLRequest("//js.appscentrum.com/s?app_id=" + UserStaticData.flash_vars['api_id'] + "&user_id=" + UserStaticData.flash_vars['viewer_id']));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			var context:LoaderContext = new LoaderContext(false, new ApplicationDomain());
			var adrequest:URLRequest = new URLRequest("https://ad.mail.ru/static/vkcontainer.swf");
			var requestParams : URLVariables = new URLVariables();
			requestParams['preview'] = '8';
			adrequest.data = requestParams;
			loader.load(adrequest, context);
		}
		
		static private function onLoadComplete(e:Event):void {
			Report.addMassage("initAds");
			VKAdds.vkContainer = VKAdds.loader.content;
			VKAdds.vkContainer.mouseEnabled = true;
			Main.THIS.stage.addChild(VKAdds.vkContainer as DisplayObject);
			VKAdds.onResize();
			/*VKAdds.vkContainer.addEventListener("adReady", onEvent);
            VKAdds.vkContainer.addEventListener("adLoadFailed", onEvent);
            VKAdds.vkContainer.addEventListener("adError", onEvent);
            VKAdds.vkContainer.addEventListener("adInitFailed", onEvent);
            VKAdds.vkContainer.addEventListener("adStarted", onEvent);
            VKAdds.vkContainer.addEventListener("adStopped", onEvent);
            VKAdds.vkContainer.addEventListener("adPaused", onEvent);
            VKAdds.vkContainer.addEventListener("adResumed", onEvent);
            VKAdds.vkContainer.addEventListener("adCompleted", onEvent);
            VKAdds.vkContainer.addEventListener("adClicked", onEvent);*/
            VKAdds.vkContainer.addEventListener("adBannerStarted", onStart);
            VKAdds.vkContainer.addEventListener("adBannerStopped", onEnd);
            VKAdds.vkContainer.addEventListener("adBannerCompleted", onEnd);
            //VKAdds.vkContainer.init(String(UserStaticData.flash_vars['api_id']), Main.THIS.stage);
		}
		
		static private function onEnd(e:Event):void {
			App.spr.visible = true;
			Main.THIS.chat.visible = true;
			App.upPanel.visible = true;
		}
		
		static private function onStart(e:Event):void {
			App.spr.visible = false;
			Main.THIS.chat.visible = false;
			App.upPanel.visible = false;
		}
		
		static private function onResize():void 
		{
			Report.addMassage(Main.THIS.stage.stageWidth + "  " + Main.THIS.stage.stageHeight);
			VKAdds.vkContainer.setSize(Main.THIS.stage.stageWidth, Main.THIS.stage.stageHeight);
		}
	}

}