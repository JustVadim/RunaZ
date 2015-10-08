package Server 
{
	import artur.App;
	import artur.win.WinBattle;
	import datacalsses.Hero;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.Socket;
	import flash.utils.Timer;
	import report.Report;
	import Utils.json.JSON2;
	
	public class DataExchange extends EventDispatcher 
	{
		public static var socket:Socket = new Socket();
		public static var recconect_timer:Timer = new Timer(500);
		public static var temp_str:String = "";
		public static var loged:Boolean = false;
		
		
		public static var data_evnt:DataExchangeEvent = null;
		public static var data_disp:EventDispatcher = new EventDispatcher();
		public static var query_num:int = 1;
		
		public var this_query_num:int = 0;
		public var command:String = "";
		public var command_data:String = "";
		public var this_event:DataExchangeEvent = null;
		public var need_res:Boolean = false;
		public var answer:Boolean = false;
		
		
		
		public static function setConnection():void
		{
			DataExchange.recconect_timer.addEventListener(TimerEvent.TIMER, onRecconectTimerHandler);
			socket.addEventListener(Event.CONNECT, onConnectHandler);
			socket.addEventListener(IOErrorEvent.IO_ERROR, onSocketIOError);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			socket.connect(UserStaticData.server_ip, UserStaticData.server_port);
		}
		
		static private function onRecconectTimerHandler(e:TimerEvent):void 
		{
			recconect_timer.stop();
			if (!socket.hasEventListener(Event.CONNECT))
			{
				socket.addEventListener(Event.CONNECT, onConnectHandler);
			}
			socket.connect(UserStaticData.server_ip, UserStaticData.server_port);
		}
		
		static private function onConnectHandler(e:Event):void 
		{
			try
			{
				Report.addMassage("Connect to server complete ... try to login in ... ");
				socket.removeEventListener(Event.CONNECT, onConnectHandler);
				socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
				socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketDataHandler);
				socket.addEventListener(Event.CLOSE, onSocketClose);
				socket.addEventListener(IOErrorEvent.IO_ERROR, onSocketError);
				var temp:Object = new Object();
				temp.id = UserStaticData.from + UserStaticData.id;//id
				temp.n = int(0);//num
				temp.c = COMMANDS.LOGIN_IN;//comm..and login
				temp.sig = UserStaticData.sig;//sig
				temp.fn = UserStaticData.fname;//name
				temp.sn = UserStaticData.sname;//sname
				temp.pl = UserStaticData.plink;//plink
				temp.fi = UserStaticData.friend_invited; // friend_invited to application//fid
				socket.writeUTFBytes(JSON2.encode(temp));
				socket.flush();
			}
			catch (err:Error)
			{
				Report.addMassage("Error in event-function onConnectHandler in class DataExchange: " + err);
			}
		}
		
		static private function onSocketError(e:IOErrorEvent):void 
		{
			Report.addMassage("sock error");
			//recconect_timer.start();
		}
		
		static private function onSocketIOError(e:IOErrorEvent):void 
		{
			Report.addMassage("onSocketIOError");
			socket.dispatchEvent(new DataExchangeEvent(DataExchangeEvent.DISCONECTED));
			if (socket.hasEventListener(ProgressEvent.SOCKET_DATA))
			{
				socket.removeEventListener(ProgressEvent.SOCKET_DATA, onSocketDataHandler);
			}
			recconect_timer.start();
		}
		
		static private function onSecurityError(e:SecurityErrorEvent):void 
		{
			Report.addMassage("Security Error" + e.toString);
			recconect_timer.start();
		}
		
		static private function onSocketClose(e:Event):void 
		{
			loged = false;
			temp_str = "";
			socket.dispatchEvent(new DataExchangeEvent(DataExchangeEvent.DISCONECTED));
			socket.removeEventListener(Event.CLOSE, onSocketClose);
			if(socket.hasEventListener(ProgressEvent.SOCKET_DATA))
			{
				socket.removeEventListener(ProgressEvent.SOCKET_DATA, onSocketDataHandler);
			}
			//socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			//socket.addEventListener(Event.CONNECT, onConnectHandler);
			//recconect_timer.start();
		}
		
		static private function onSocketDataHandler(e:ProgressEvent=null):void 
		{
			try
			{
				temp_str += socket.readUTFBytes(socket.bytesAvailable);
				var temp_array:Array = temp_str.split("#end#");
				var temp_obj:Object = new Object();
				for (var count:int = 0; count < temp_array.length - 1; count++ )
				{
					
					temp_obj = JSON2.decode(String(temp_array[count]));
					if (loged)
					{
						if (int(temp_obj.n == 0))
						{
							switch(int(temp_obj.c))
							{
								case COMMANDS.new_window:
									socket.removeEventListener(Event.CLOSE, onSocketClose);
									socket.removeEventListener(ProgressEvent.SOCKET_DATA, onSocketDataHandler);
									socket.close();
								break;
								case COMMANDS.new_user_comes:
									temp_obj = JSON2.decode(temp_obj.m);
									UserStaticData.users_info[temp_obj["id"]] = temp_obj;
									{
										UserStaticData.users_info[temp_obj["id"]][6] = 1; 
									}
									if (!Main.THIS.chat.find_user.text == "Поиск игрока")
									{
										Main.THIS.chat.updateUserList(Main.THIS.chat.find_user.text);
									}
									else
									{
										Main.THIS.chat.updateUserList();
									}
									break;
								case COMMANDS.user_gone:
									if (UserStaticData.users_info[temp_obj.m] != null)
									{
										UserStaticData.users_info[temp_obj.m][6] = 0;
										if (Main.THIS.chat != null)
										{
											if (!Main.THIS.chat.find_user.text == "Поиск игрока")
											{
												Main.THIS.chat.updateUserList(Main.THIS.chat.find_user.text);
											}
											else
											{
												Main.THIS.chat.updateUserList();
											}
										}
										
									}
								break;
							case COMMANDS.massage_come:
									if (Main.THIS.contains(Main.THIS.chat))
									{
										Main.THIS.chat.addNewMass(temp_obj.m);
									}
									break;
							case int(COMMANDS.SEND_MISS_STEP):
								data_evnt = new DataExchangeEvent(DataExchangeEvent.BATTLE_MASSAGE);
								data_evnt.result = String(temp_obj.m);
								socket.dispatchEvent(data_evnt);
								break;
							case int(COMMANDS.FIND_BATTLE):
								UserStaticData.hero.mbat = JSON2.decode(temp_obj.m);
								UserStaticData.hero.bat = UserStaticData.hero.mbat.id;
								App.lock.frees();
								App.winManajer.swapWin(3);
								break;
							case int(COMMANDS.SEND_BATTLE_MASSEGE):
								if (WinBattle.battleChat.stage)
								{
									WinBattle.battleChat.addMassage(JSON2.decode(temp_obj.m));
								}
								break;
							}
						}
						else
						{
							data_evnt = new DataExchangeEvent(DataExchangeEvent.DATA_RECIEVED);
							data_evnt.c = String(temp_obj.c);
							data_evnt.m = String(temp_obj.m);
							data_evnt.n = int(temp_obj.n);
							data_evnt.sig = String(temp_obj.sig);
							socket.dispatchEvent(data_evnt);
						}
					}
					else
					{
						if ( int(temp_obj.c) == 0 && temp_obj.n == 0 )
						{
							var obj:Object = JSON2.decode(temp_obj.m);
							if (obj.error == null)
							{
								UserStaticData.hero.setHero(obj.h);
								UserStaticData.hero.mbat = obj.bat;
								UserStaticData.my_info = obj.ui;
								UserStaticData.levels = JSON2.decode(obj.nl);
								UserStaticData.magaz_units = JSON2.decode(obj.m_u);
								UserStaticData.magazin_items = JSON2.decode(obj.items);
								UserStaticData.buffs_chances = JSON2.decode(obj.bm);
								for (var key:Object in obj.uis)
								{
									UserStaticData.users_info[key] = JSON2.decode(obj.uis[key]);
									UserStaticData.users_info[key][6] = 1;
								}
								if (Main.THIS.chat != null)
								{
									Main.THIS.chat.updateUserList();
								}
								loged = true;
								socket.dispatchEvent(new DataExchangeEvent(DataExchangeEvent.ON_LOGIN_COMPLETE));
							}
							else
							{
								Report.addMassage("Error while logining on")
							}
							
						}
						else
						{
							Report.addMassage("Data comes but user are not logged: " + temp_array[count]);
						}
					}
				}
				temp_str = temp_array[count];
			}
			catch (err:Error)
			{
				Report.addMassage("Error in event-function onSocketDataHandler in class DataExchange: " + err);
			}
		}
		
		public function sendData(command:String, command_data:String = "", answer:Boolean = false , is_recconected:Boolean = false):void
		{
			if (answer)
			{
				socket.addEventListener(DataExchangeEvent.DISCONECTED, onDisconect);
				socket.addEventListener(DataExchangeEvent.DATA_RECIEVED, onDataRecievHandler);
			}
			if (!is_recconected)
			{
				this.this_query_num = query_num++;
				this.command = command;
				this.command_data = command_data;
				this.answer = answer;
			}
			
			var temp:Object = new Object();
			temp.m = command_data;
			temp.n = String(this.this_query_num);
			temp.c = this.command;
			
			if (socket.connected)
			{
				socket.writeUTFBytes(JSON2.encode(temp) + "#end#");
				socket.flush();
			}
		}
		
		private function onDisconect(e:DataExchangeEvent):void 
		{
			socket.removeEventListener(DataExchangeEvent.DISCONECTED, onDisconect);
			socket.removeEventListener(DataExchangeEvent.DATA_RECIEVED, onDataRecievHandler);
		}
		private function onDataRecievHandler(e:DataExchangeEvent):void 
		{
			if (int(e.n) == this.this_query_num && String(e.c) == this.command)
			{
				socket.removeEventListener(DataExchangeEvent.DISCONECTED, onDisconect);
				socket.removeEventListener(DataExchangeEvent.DATA_RECIEVED, onDataRecievHandler);
				this.this_event = new DataExchangeEvent(DataExchangeEvent.ON_RESULT);
				this.this_event.result = e.m;
				dispatchEvent(this_event);
			}
		}
		
		
	}

}