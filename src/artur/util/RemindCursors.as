package artur.util 
{
	import artur.display.BaseButton;
	import fl.text.TLFTextField;
	import flash.display.*;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.*;
	import flash.display.SimpleButton;
	import report.Report;
	
	public class RemindCursors extends Sprite 
	{ 
		private var cursorData:MouseCursorData = new MouseCursorData();
		private var cursors: Array = [];
		private var btnCursor: String; 
		public var mainCursor: String;
		private var btnCursorClass: Class;
		private var enableButtonListeners: Boolean = false;
		private var _stage:*;
		public static var is_ult:Boolean = false;
		
		public function RemindCursors() 
		{
			this.addCursor(cursorTarget, "ult");
		}
		
		public function addCursor($cursorClass:Class, $name:String = null, $cursorHotSpot:Point = null, $cursorFPS: Number = NaN):void {
			var cursorAnim: RemindCursorsAnim = new RemindCursorsAnim();
			cursorAnim.addCursorFromClass($cursorClass, $name, $cursorHotSpot, $cursorFPS);
			cursors.push(cursorAnim);
		}
		
		
		/**
		 * Изменяет текущий курсор на заданный
		 * @param	$name	Имя курсора
		 */
		public function changeCursor($name:String):void {
			if ($name != null) {
				var numCursors: int = cursors.length;
				for (var i:int = 0; i < numCursors; i++) {
					if (cursors[i].name == $name) {
						if(Mouse.cursor != $name) {
							Mouse.cursor = $name;
						}
						break;
					}
				}
			}
		}
		/**
		 * Задает курсор при наведении на кнопки
		 * @param	$mainCursorName		Имя основного курсора, который используется вне кнопок
		 * @param	$buttonCursorName	Имя курсора который будет использоваться при наведении на кнопку
		 * @param	$stage				Ссылка на stage 
		 * @param	$buttonCursorClass	Класс кнопок. Если не задан, будет по умолчанию SimpleButton
		 */
		public function setButtonCursor($mainCursorName:String, $buttonCursorName: String, $stage:Stage, $buttonCursorClass: Class = null):void {
			_stage = $stage;
			mainCursor = $mainCursorName;
			btnCursor = $buttonCursorName;
			
			if ($buttonCursorClass == null) {
				btnCursorClass = SimpleButton;
			} else {
				btnCursorClass = $buttonCursorClass;
			}
			
			if (!enableButtonListeners) {
				createButtonListeners();
			}
		}
		/**
		 * Сбрасывает настройки для курсора кнопок
		 */
		public function resetButtonCursor():void {
			if (enableButtonListeners) {
				_stage.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			}
			if (mainCursor != "") {
				changeCursor(mainCursor);
			}
			mainCursor = "";
			btnCursor = "";
			btnCursorClass = null;
			_stage = null;
		}

		/**
		 * Удаляет курсор по имени
		 * @param	$name Имя удаляемого курсора
		 */
		public function removeCursor($name:String):void {
			Mouse.unregisterCursor($name);
			
			var numCursors: int = cursors.length;
			for (var i:int = 0; i < numCursors; i++) 
			{
				if (cursors[i].name == $name) {
					cursors[i] == null;
					cursors.splice(i, 1);
					break;
				}
			}
			if ($name == mainCursor) {
				mainCursor = "";
			}
			if ($name == btnCursor) {
				resetButtonCursor();
			}
		}
		/**
		 * Удаляет курсор по индексу
		 * @param	$id Индекс удаляемого курсора
		 */
		public function removeCursorAt($id:int):void {
			Mouse.unregisterCursor(cursors[$id].name);
			if (cursors[$id].name == mainCursor) {
				mainCursor = "";
			}
			if (cursors[$id].name == btnCursor) {
				resetButtonCursor();
			}
			cursors[$id] = null;
			cursors.splice($id, 1);
		}
		
		/**
		 * Удаляет все курсоры
		 */
		public function removeAllCursors():void {
			var numCursors: int = cursors.length;
			for (var i:int = 0; i < numCursors; i++) 
			{
				Mouse.unregisterCursor(cursors[i].name);
				cursors[i] == null;
			}
			resetButtonCursor();
			MouseCursor.AUTO;
			cursors = null;
			cursors = [];
		}
		
		private function createButtonListeners():void 
		{
			_stage.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			enableButtonListeners = true;
		}
		
		private function mouseOver(e:MouseEvent):void {
			e.updateAfterEvent();
			var mc:Object = e.target;
			if(RemindCursors.is_ult) {
				changeCursor("ult");
				return
			}
			if(e.target is SimpleButton) {
				changeCursor(btnCursor);
				return;
			}
			if (('buttonMode' in mc) && mc.buttonMode == true || mc is BaseButton) {
				changeCursor(btnCursor);
				return;
			}
			changeCursor(mainCursor);
			
		}
		
		
		
		public function get currentCursorName():String { return Mouse.cursor; }
		public function get numCursors():int { return cursors.length; }
		
	}

}