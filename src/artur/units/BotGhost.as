package artur.units 
{
	import artur.App;
	import artur.PrepareGr;
	import com.greensock.TweenLite;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Som911
	 */
	public class BotGhost extends GhostDoll
	{
		public  var normScale:Number = 1.5;
		 private var bodys       :Array;
		 private var hendsL     :Array;
		 private var hendsR     :Array;
		 public var type:String = 'Bot1';
		 public var free:Boolean = true;
		 
		 private var isOver:Boolean = false;
		 private var parts:Array ;
		 private var parts_of_parts:Array;
		 private var sh:Sprite = PrepareGr.creatBms(new mcShawdow(), true)[0];
		 private static var sounds:Array = [  ];
		 public var _head:Sprite 
		public function BotGhost() 
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.shawdow.addChild(sh);
			bodys = PrepareGr.creatBms(new Item_BodysGhost());
			hendsR = PrepareGr.creatBms(new Item_HandsGhost());
			hendsL = PrepareGr.creatBms(new Item_HandsGhost());
			
			parts = [this.body, this.h1, this.h2];
			parts_of_parts = [bodys, hendsL , hendsR ];
			
			this.body.addChild(bodys[0]);
			this.h1.addChild(hendsL[0]);
		    this.h2.addChild(hendsR[0]);
		//	 itemUpdate([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
			 this.scaleX = 1.5;
			 this.scaleY = 1.5;
			 _head = this.body;
		}
		public function onWalk():void
		 {
			 //App.sound.playSound('bot1_init', App.sound.onVoice, 1);
		 }
		public function out(e:MouseEvent=null):void 
		 {
			isOver = false;
		 }
		public function over(e:MouseEvent=null):void 
		{
			isOver = true;
			TweenLite.to(this, 0.25, { scaleX:1.3, scaleY:1.3} );
			App.btnOverFilter.color = 0xFFFFFF;
			this.filters = [App.btnOverFilter];
		}
		public function init(parr:DisplayObjectContainer=null):void
		{
			scaleX = normScale;
			scaleY = normScale;
			filters = [];
			free = false;
			this.gotoAndPlay('idle');
			if (parr) 
			{
				parr.addChild(this);
			}
		}
		public function update():void
		{
			if (!isOver && this.scaleX == 1.3)
			{
				TweenLite.to(this, 0.25, { scaleX:1, scaleY:1 } );
				this.filters = [];
			}
			for (var i:int = 0; i < sounds.length; i++) 
			{
				if (sounds[i].frame == currentFrame) 
				{
					App.sound.playSound(sounds[i].id, App.sound.onVoice, 1);
				}
			}
		}
		public function frees():void
		{
			free = true;
			gotoAndStop(1);
			if (this.stage) 
			{
				parent.removeChild(this);
			}
			
			 this.removeEventListener(MouseEvent.MOUSE_OVER, over);
		     this.removeEventListener(MouseEvent.MOUSE_OUT, out);
		}
		public function itemUpdate(obj:Object):void
		{
			for (var i:int = 0; i < parts.length; i++) 
			{
			   Sprite(parts[i]).removeChildAt(1);
			   switch(true)
			   {
				   case i == 0:
					   Sprite(parts[i]).addChild(this.parts_of_parts[i][int(obj[0])]);
					   break;
					case i == 1:
						Sprite(parts[i]).addChild(this.parts_of_parts[i][int(obj[1])]);
						break;
					case i == 2:
						Sprite(parts[i]).addChild(this.parts_of_parts[i][int(obj[5])]);
						break;
			   }
			}
			
		}
	
		
	}

}