package artur 
{
	import artur.display.BtnArena;
	import artur.display.BtnChatDialogExtends;
	import artur.display.bgBlankUnitExtend;
	import artur.display.BtnAddHeroExtend;
	import artur.display.btnClosedShopExtended;
	import artur.display.BtnHeroExtend;
	import artur.display.btnSel1Extend;
	import artur.display.BtnStoneExtend;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import Server.Lang;
	import report.Report;
	
	public class PrepareGr 
	{
		public var cach:Array = [];
		public static var btnsScale:Number = 1;
		//public static var scaleFactor:Number = 2;   //unitItemsScale
		public function PrepareGr() {
			var clips:Array = [
			/*0*/new MovieClip(),//new bg1Root(),
			/*2*/new btnBank,
			/**/new btnTop,//2
			/**/new btnCastle,//3
			/**/new btnArena,//4
			/**/new btnShop, //5
			/**/new btnSend,//6
			/**/new MovieClip,//7
			/**/new BtnAddHeroExtend,//8
			/**/new BtnHeroExtend,//9
			/**/new bgBlankUnitExtend,//10;
			/**/new btnExit(),//11
			/**/new btnBye(),//12
			/**/new mcBgHeroInv(),//13
			/**/new btnTown(),//14
			/**/new btnClosedShopExtended(),//15
			/**/new MovieClip(),//16
			/*17  */new t1(),
			/*18  */new t2(),
			/*19  */new t3(),
			/*20  */new t4(),
			/*21  */new t5(),
			/*22  */new t6(),
			/*23  */new t7(),
			/*24  */new t8(),
			/*25  */new t9(),
			/*26  */new t10(),
			/*27  */new t11(),
			/*28  */new t12(),
			/*29  */new btnMap(),
			/*30  */new btnToBatle(),
			/*31  */new btnCloseList(),
			/*32  */new imgBtnCastle(),
			/*33  */new btnTakes(),
			/*34  */new btnPlus(),
			/*35  */new btnSel1Extend(Lang.getTitle(40, 0)),
			/*36  */new btnSel1Extend(Lang.getTitle(40, 1)),
			/*37  */new btnSel1Extend(Lang.getTitle(40, 2)),
			/*38  */new btnSel1Extend(Lang.getTitle(40, 3)),
		    /*39  */new MovieClip(),//39,
		    /*40  */new BtnArena(),//40
		    /*41  */new btnAddStone(),//41
		    /*42  */new BtnCraft(),//42
		    /*43  */new BtnStoneExtend(),//43//
		    /*44  */new btnByeStone(),//44
		    /*45  */new imgBtnBank(),//45
		    /*46  */new imgBtnMap(),//46
			/*47  */new btnQvest(),//47
		    /*48  */new btnMapNext(),//48
		    /*49  */new btnMapRes(),//49
			/*50  */new imgBtnEnergy(),
		    /*51  */new btnTop1(),
		    /*52  */new btnTop2(),
		    /*53  */new btnTop3(),
		    /*54  */new btnTop4(),
		    /*55  */new btnTop5(),
		    /*56  */new btnArrow(),
			/*57  */new btnVideoAds(),
			/*58  */ new BtnChatDialogExtends(Lang.getTitle(186)),
			/*59  */ new BtnChatDialogExtends(Lang.getTitle(187)),
			/*60  */ new BtnChatDialogExtends(Lang.getTitle(188)), 
			/*61  */ new btnClsoeDialog(),
		    /*62  */ new MovieClip(),
			/*63  */ new btnBack(),
			/*64  */ new btnFortuna(),
			/*65  */ new btnFortunaDonate(),
			/*66  */ new btnFortunaChat(),
		    /*67  */ new btnTopInside(),
			/*68  */ new imgBtnFortuna(),
			/*69  */ new btnPlus2(),
			/*70  */ new btnFriendsStone(),
			/*71  */ new btnArenaGold(),
			/*72  */ new btnArenaPoint(),
			/*73  */ new btnArenaSilver(),
			/*74  */ new btnTake(),
			/*75  */ new btnTakeNextFight(),
			
			/*76  */ new imgKyz(),
			/*77  */ new imgTown(),
			/*78  */ new imgBtnArena(),
			/*79  */ new imgBtnCave(),

		];
			
			
			for (var i:int = 0; i < clips.length; i++) {
				this.cach[i] = RasterClip.getBitmapData(clips[i], 1, -1, -1, null, RasterClip.PrepareGrScale);
			}
			
			
			
		}
	}

}