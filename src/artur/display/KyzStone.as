package artur.display {
	import Server.Lang;
	import Utils.Functions;
	import adobe.utils.CustomActions;
	import artur.App;
	import artur.PrepareGr;
	import artur.RasterClip;
	import artur.win.WinKyz;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.text.engine.Kerning;
	import report.Report;
	
	public class KyzStone extends Sprite {
		private static var vector:MovieClip = new KyzStones();
		private var id:int;
		private var getBtn:BaseButton;
		private var askFriend:BaseButton;
		private var sendToCrafter:BaseButton;
		private var text:TextField;
		private var bg:Sprite;
		
		public function KyzStone(id:int, xx:Number, yy:Number) {
			this.addChild(this.bg = new Sprite())
			var bm:Bitmap = RasterClip.getMovedBitmap(new KyzStones(), id);
			this.bg.addChild(bm);
			this.x = xx;
			this.y = yy;
			this.tabEnabled = false;
			this.tabChildren = false;
			this.id = id-1;
			this.buttonMode = true;
			this.getBtn = new BaseButton(69);
			this.addChild(getBtn);
			this.getBtn.x = -40.5;
			this.getBtn.y = 0;
			this.askFriend = new BaseButton(70);
			this.askFriend.x = -40.5 - getBtn.width - 5;
			this.addChild(this.askFriend);
			this.sendToCrafter = new BaseButton(41);
			this.sendToCrafter.x = 125;
			this.sendToCrafter.y = 2;
			this.addChild(this.sendToCrafter);
			this.text = Functions.getTitledTextfield(20, -10, 85, 25, new Art().fontName, 18, 0xFFFFFF, TextFormatAlign.CENTER, "12", 1, Kerning.ON, 1, true);
			this.text.filters = [new GlowFilter(0x0, 1, 3, 3)];
			this.addChild(text);
			this.addEventListener(Event.ADDED_TO_STAGE, this.onAdded);
			this.bg.buttonMode = true;
		}
		
		private function onAdded(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
			
			this.getBtn.addEventListener(MouseEvent.CLICK, this.onClick);
			this.getBtn.addEventListener(MouseEvent.ROLL_OVER, this.onGetStoneOver);
			this.getBtn.addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
			
			this.askFriend.addEventListener(MouseEvent.ROLL_OVER, this.onAskFriendOver);
			this.askFriend.addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
			this.askFriend.addEventListener(MouseEvent.CLICK, this.onAskClick);
			
			this.sendToCrafter.addEventListener(MouseEvent.CLICK, this.onAddCraftClick);
			this.sendToCrafter.addEventListener(MouseEvent.ROLL_OVER, this.onSendToCraftOver);
			this.sendToCrafter.addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
			
			this.bg.addEventListener(MouseEvent.ROLL_OVER, this.onBgOver);
			this.bg.addEventListener(MouseEvent.ROLL_OUT, this.onBgOut);
			
			this.sendToCrafter.scaleX = 1;
			
		}
		
		private function onBgOut(e:MouseEvent):void 
		{
			this.bg.filters = [];
			App.info.frees();
		}
		
		private function onBgOver(e:MouseEvent):void {
			this.bg.filters = [new GlowFilter(0xFFFFFF, 1, 3, 3)];
			App.info.init(this.x + 120, this.y, { txtInfo_w:280, txtInfo_h:37,title:Lang.getTitle(43, this.id), txtInfo_t:Lang.getTitle(59, this.id), type:0 } );
		}
		
		private function onSendToCraftOver(e:MouseEvent):void {
			App.info.init(this.x + 170, this.y, { txtInfo_w:200, txtInfo_h:37, txtInfo_t:Lang.getTitle(203) + Lang.getTitle(43, this.id), type:0 } );
		}
		
		private function onAskFriendOver(e:MouseEvent):void {
			App.info.init(this.x-40, this.y, { txtInfo_w:200, txtInfo_h:37, txtInfo_t:Lang.getTitle(202) + Lang.getTitle(43, this.id), type:0 } );
		}
		
		private function onRollOut(e:MouseEvent):void {
			App.info.frees();
		}
		
		private function onGetStoneOver(e:MouseEvent):void {
			App.info.init(this.x, this.y, { txtInfo_w:120, txtInfo_h:37, txtInfo_t:Lang.getTitle(52) + Lang.getTitle(43, this.id), type:0 } );
		}
		
		private function onAskClick(e:MouseEvent):void {
			WinKyz.inst.askGiftDialog.init(this.id);
		}
		
		public function onAddCraftClick(e:MouseEvent = null):void {
			if(this.sendToCrafter.scaleX == 1) {
				if(WinKyz.inst.chest.addSoneToCraft(this.id)) {
					this.sendToCrafter.scaleX = -1;
					App.sound.playSound("stone", App.sound.onVoice, 1);
				}
			} else {
				WinKyz.inst.chest.removeStoneFromCraft(this.id);
			}
		}
		
		private function onClick(e:MouseEvent):void {
			if(UserStaticData.hero.gold >= 2) {
				App.byeWin.init(Lang.getTitle(75), Lang.getTitle(43, this.id), 2, 0, 0, 4, this.id);
			} else {
				App.closedDialog.init1(Lang.getTitle(45), false, true, true);
			}
		}
		
		private function onRemoved(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
			this.addEventListener(Event.ADDED_TO_STAGE, this.onAdded);
			
			this.getBtn.removeEventListener(MouseEvent.CLICK, this.onClick);
			this.getBtn.removeEventListener(MouseEvent.ROLL_OVER, this.onGetStoneOver);
			this.getBtn.removeEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
			
			this.askFriend.removeEventListener(MouseEvent.ROLL_OVER, this.onAskFriendOver);
			this.askFriend.removeEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
			this.askFriend.removeEventListener(MouseEvent.CLICK, this.onAskClick);
			
			this.sendToCrafter.removeEventListener(MouseEvent.CLICK, this.onAddCraftClick);
			this.sendToCrafter.removeEventListener(MouseEvent.ROLL_OVER, this.onSendToCraftOver);
			this.sendToCrafter.removeEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
			
			this.bg.removeEventListener(MouseEvent.ROLL_OVER, this.onBgOver);
			this.bg.removeEventListener(MouseEvent.ROLL_OUT, this.onBgOut);
		}
		
		public function showZakazBtn(state:Boolean):void {
			if(state) {
				this.addChild(this.getBtn);
			} else {
				if (this.getBtn.parent) {
					this.getBtn.parent.removeChild(this.getBtn);
				}
			}
		}
		
		public function setSt():void {
			Functions.compareAndSet(this.text, UserStaticData.hero.st[id]);
			if(UserStaticData.hero.st[id] < 10) {
				if (this.sendToCrafter.parent) {
					this.removeChild(this.sendToCrafter);
				} else {
					this.addChild(this.sendToCrafter);
				}
			}
		}
		
		public function turnStoneBtn():void {
			this.sendToCrafter.scaleX = 1;
		}
		
	}
}