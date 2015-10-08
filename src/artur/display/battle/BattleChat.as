package artur.display.battle 
{
	import adobe.utils.CustomActions;
	import artur.win.WinBattle;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import Server.COMMANDS;
	import Server.DataExchange;
	import Utils.json.JSON2;
	
	public class BattleChat extends chatBg2
	{
		private var input_text:TextField = new TextField();
		private var send_btn:Sprite = new Sprite();
		
		private var massages:Array = new Array();
		
		public function BattleChat() 
		{
			this.scaleX = 
			this.tabEnabled = false;
			this.mouseEnabled = false;
			this.x = 0;
			this.y = 0;
			this.graphics.beginFill(0x0);
			this.graphics.drawRect(0, 0, 800, 30);
			this.graphics.endFill();
			this.input_text.tabEnabled = true;
			this.input_text.y = 571;
			this.input_text.x = 178.5;
			this.input_text.width = 433;
			this.input_text.height = 18.5;
			this.input_text.textColor = 0xFFFFFF;
			this.input_text.type = "input";
			this.input_text.border = true;
			this.input_text.borderColor = 0xFFFFFF;
			this.addChild(input_text);
			
			
			this.send_btn.graphics.beginFill(0xF00FF0F);
			this.send_btn.graphics.drawRect(605, 3, 50, 24);
			this.send_btn.graphics.endFill();
			this.send_btn.buttonMode = true;
			this.addChild(this.send_btn);

			
			
			this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
		}	
		
		private function onRemoved(e:Event):void 
		{
			this.input_text.removeEventListener(FocusEvent.FOCUS_IN, this.onEnterMassFocusIn);
			this.input_text.removeEventListener(FocusEvent.FOCUS_OUT, this.onEnterMassFocusOut);
			this.send_btn.removeEventListener(MouseEvent.ROLL_OVER, this.onSendOver);
			this.send_btn.removeEventListener(MouseEvent.ROLL_OUT, this.onSendOut);
		}
		
		private function onSendOut(e:MouseEvent):void 
		{
			//this.send_btn.backgroundColor = 0x0080FF;
		}
		
		private function onSendOver(e:MouseEvent):void 
		{
			//this.send_btn.backgroundColor = 0xFFFF00;
		}
		
		private function onAddedToStage(e:Event):void 
		{
			Main.THIS.stage.focus = this.input_text;
			this.input_text.addEventListener(FocusEvent.FOCUS_IN, this.onEnterMassFocusIn);
			this.input_text.addEventListener(FocusEvent.FOCUS_OUT, this.onEnterMassFocusOut);
			this.send_btn.addEventListener(MouseEvent.MOUSE_OVER, this.onSendOver);
			this.send_btn.addEventListener(MouseEvent.MOUSE_OVER, this.onSendOut);
			this.send_btn.addEventListener(MouseEvent.CLICK, this.onClick);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			if (this.input_text.text != "Введите текст сообщения" && this.input_text.length > 0)
			{
				if (String(WinBattle.bat.t2_id).substr(0,3)!="bot")
				{
					var send_obj:Object = new Object();
					send_obj.mass = this.input_text.text;
					send_obj.bat_id = WinBattle.bat.id;
					send_obj.uid = UserStaticData.from + UserStaticData.id;
					new DataExchange().sendData(COMMANDS.SEND_BATTLE_MASSEGE, JSON2.encode(send_obj));
					this.input_text.text = "";
					Main.THIS.stage.focus = this.input_text;
				}
				else
				{
					this.input_text.text = "";
					Main.THIS.stage.focus = this.input_text;
				}
			}
		}
		
		private function onEnterMassFocusOut(e:FocusEvent):void 
		{
			this.input_text.text = "Введите текст сообщения";
			this.input_text.textColor = 0x9D9D9D;
			this.input_text.alpha = 0.8;
		}
		
		private function onEnterMassFocusIn(e:FocusEvent):void 
		{
			this.input_text.text = "";
			this.input_text.textColor = 0xFFFFFF;
			this.input_text.alpha = 1;
		}
		
		public function addMassage(obj:Object):void
		{
			var mass:TextField = new TextField();
			mass.x = 200; mass.y = -20;
			mass.text = obj.mass;
			this.addChild(mass);
			TweenLite.to(mass, 0.5, { alpha:0, delay: 1, onComplete: onMass } );
			this.massages.push(mass);
			for (var i:int = massages.length-1; i >=0 ; i--) {
				if (TextField(this.massages[i]).stage) {
					TextField(this.massages[i]).y -= 15;
				} else {
					break;
				}
			}
			function onMass():void 
			{
				removeChild(mass);
			}
			var count:int = 0;
			for (var j:int = 0; j < massages.length; j++) 
			{
				if (TextField(this.massages[j]).stage)
					count++;
			}
		}
		
	}

}