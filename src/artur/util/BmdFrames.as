package util {
        import flash.display.BitmapData;
        import flash.display.MovieClip;
		import flash.display.Sprite;
		import flash.filters.GlowFilter;
        import flash.geom.Matrix;
        import flash.geom.Point;
        import flash.geom.Rectangle;
        
        public class BmdFrames {
			
                public var frames : Array;
                public var frameXs : Array;
                public var frameYs : Array;
                public var totalFrames : int;
                
			
                protected static const INDENT_FOR_FILTER : int = 4;
                protected static const INDENT_FOR_FILTER_DOUBLED : int = INDENT_FOR_FILTER * 2;
                protected static const DEST_POINT : Point = new Point(0, 0);
				protected static var scratchBitmapData : BitmapData = null;
				protected static var scratchSize : int = 128 + INDENT_FOR_FILTER_DOUBLED;
				
                private  static  var  bmdFrame:BmdFrames
				
                public function BmdFrames() 
				{
                        frames = new Array();
                        frameXs = new Array();
                        frameYs = new Array();
                        totalFrames = 0;
                }
                public static function createBmpFramesFromArray(arr1:Array,arr2:Array = null):BmdFrames
				{
					 bmdFrame = new BmdFrames();
					 var frames : Array  = bmdFrame.frames  ;
                     var frameXs : Array = bmdFrame.frameXs ;
                     var frameYs : Array = bmdFrame.frameYs ;
					 
					 var rect : Rectangle;
                     var flooredX : int;
                     var flooredY : int;
                     var mtx : Matrix = new Matrix();
                     var scratchBitmapData : BitmapData = null;
					 var clip:Sprite = new Sprite();
					clip.filters = [new GlowFilter(0x000000, 1, 2, 2, 2, 1)];
					var part:Sprite
					///////////////////////////
					var objectsPerFrame:int = arr1[0].length;// [{},{},{},{}]
					var objectsPerFrameBlood:int
					var totalFrames:int = arr1.length;
					
					var parts:Array = [];
					if(arr2)
					{
						objectsPerFrameBlood =arr2[0].length 
						 var partsBood:Array = [];
					     for (var l:int = 0; l < objectsPerFrameBlood; l++) 
					     {
						     var partBlood:MovieClip = new PartBlood();
							 partBlood.gotoAndStop(Numbs.RandomInt(1,4))
							 partBlood.scaleX = Numbs.Random(0.3, 1);
							 
							 partBlood.scaleY = partBlood.scaleX;
							 partsBood.push(partBlood);
							  clip.addChild(partBlood);
					     }
					}
					
					for (var i:int = 0; i < objectsPerFrame; i++) 
					{
			             var	p:Sprite = new Part1();
						 clip.addChild(p);
						 parts.push(p);
					}
					
					for (var j:int = 0; j < totalFrames; j++) 
					{
						if (arr2)
						{
							for (var m:int = 0; m < objectsPerFrameBlood; m++) 
							{
								part = partsBood[m];
								part.x = arr2[j][m].x;
								part.y = arr2[j][m].y;
								if (part.scaleX > 0.4)
								{
								    part.scaleX -= 0.02;
								    part.scaleY = part.scaleX; 
								}
								if (part.y > 0)
								part.visible = false;
							}
						}
						for (var k:int = 0; k < objectsPerFrame; k++) 
						{
							part = parts[k]; 
							part.x = arr1[j][k].x;
							part.y = arr1[j][k].y+5;
							part.rotation = arr1[j][k].rot;
							if (part.scaleX > 0.4)
								{
								    part.scaleX -= 0.02;
								    part.scaleY = part.scaleX; 
								}
							if (part.y > -15)
							part.visible = false;
						}
						     rect = clip.getBounds(clip);
                             rect.width = rect.width
                             rect.height = rect.height
							 flooredX = rect.x
                             flooredY = rect.y 
							 mtx.tx = -flooredX;
                             mtx.ty = -flooredY;
							 
							    scratchBitmapData = new BitmapData(rect.width, rect.height, true, 0);
                                scratchBitmapData.draw(clip, mtx);
                                
                                var trimBounds : Rectangle = scratchBitmapData.getColorBoundsRect(0xFF000000, 0x00000000, false);
                                trimBounds.x -= 1;
                                trimBounds.y -= 1;
                                trimBounds.width += 2;
                                trimBounds.height += 2;
                                
                                var bmpData : BitmapData = new BitmapData(trimBounds.width, trimBounds.height, true, 0);
                                bmpData.copyPixels(scratchBitmapData, trimBounds, DEST_POINT);
                                
                                flooredX += trimBounds.x;
                                flooredY += trimBounds.y;

                                frames.push(bmpData);
                                frameXs.push(flooredX);
                                frameYs.push(flooredY);

                                scratchBitmapData.dispose();
					}
					return bmdFrame;
				}
                public static function createBmpFramesFromMC( clipClass : Class,alpha:Number=1,filter:Boolean=false) : BmdFrames 
				{
                        var clip :MovieClip = MovieClip( new clipClass() );
					    var clip2:Sprite = new Sprite();
						clip2.addChild(clip);
						if(filter)
						clip.filters = [new GlowFilter(0x000000, 1, 2, 2, 2, 1)];
                        bmdFrame = new BmdFrames();
                        
                        var totalFrames : int = clip.totalFrames;

                        var frames : Array  = bmdFrame.frames  ;
                        var frameXs : Array = bmdFrame.frameXs ;
                        var frameYs : Array = bmdFrame.frameYs ;
                        
                        var rect : Rectangle;
                        var flooredX : int;
                        var flooredY : int;
                        var mtx : Matrix = new Matrix();
                        var scratchBitmapData : BitmapData = null;

                        for (var i : int = 1; i <= totalFrames; i++) 
						{
                                clip.gotoAndStop(i);
								
                                rect = clip.getBounds(clip);
                                rect.width = rect.width
                                rect.height = rect.height
                                
                                flooredX = rect.x
                                flooredY = rect.y 
                                mtx.tx = -flooredX;
                                mtx.ty = -flooredY;
                                 
                                scratchBitmapData = new BitmapData(rect.width, rect.height, true, 0);
                                scratchBitmapData.draw(clip2, mtx);
                                
                                var trimBounds : Rectangle = scratchBitmapData.getColorBoundsRect(0xFF000000, 0x00000000, false);
                                trimBounds.x -= 1;
                                trimBounds.y -= 1;
                                trimBounds.width += 2;
                                trimBounds.height += 2;
                                
                                var bmpData : BitmapData = new BitmapData(trimBounds.width, trimBounds.height, true, 0);
                                bmpData.copyPixels(scratchBitmapData, trimBounds, DEST_POINT);
                                
                                flooredX += trimBounds.x;
                                flooredY += trimBounds.y;

                                frames.push(bmpData);
                                frameXs.push(flooredX);
                                frameYs.push(flooredY);

                                scratchBitmapData.dispose();
                        }
                        
                        return  bmdFrame;
                }
				
				
				
				 
				public static function creatFrames360(clipClass:Class, wd:int = 0, hg:int = 0, num:int = 1, filter:Boolean = false ):BmdFrames
				{
					   
						 bmdFrame = new BmdFrames();
                         var clip:Sprite = Sprite(new clipClass());
						 if(filter)
						 clip.filters = [new GlowFilter(0x000000, 1, 2, 2, 2, 1)];
						 var box:Sprite = new Sprite();
						
						
                         var frames : Array =   bmdFrame.frames;
                         var frameXs : Array =  bmdFrame.frameXs;
                         var frameYs : Array =  bmdFrame.frameYs;
                        
                         var rect : Rectangle;
                         var flooredX : int;
                         var flooredY : int;
                         var mtx : Matrix = new Matrix();
                         var scratchBitmapData : BitmapData = null;
						
						if (wd) 
						{
							 box.addChild(clip)
							 for (var j:int = 0; j < 360/num; j++) 
						     {
								  clip.rotation = j*num;
								  rect = box.getBounds(box);
								  flooredX = -wd/2
                                  flooredY = -hg/2 
								  mtx.tx = -flooredX;
                                  mtx.ty = -flooredY;
								  scratchBitmapData = new BitmapData(wd, hg,true, 0xBCBCBC);
								  scratchBitmapData.draw(box, mtx);
								  frames.push(scratchBitmapData);
                                  frameXs.push(flooredX);
                                  frameYs.push(flooredY);
								  
							 }
						}
						else
						{
							 var bound:Sprite = Sprite(clip.getChildByName('bound'))
							 
							 for (var i : int = 0; i < 360; i++) 
						     {
                                clip.rotation = i;
								bound.rotation = i;
								box.addChild(bound);
                                rect = box.getBounds(box);
                              
                                
                                flooredX = rect.x
                                flooredY = rect.y 
                                mtx.tx = -flooredX;
                                mtx.ty = -flooredY;

                                scratchBitmapData = new BitmapData(rect.width, rect.height,true, 0xBCBCBC);
								box.removeChild(bound);
								box.addChild(clip);
                                scratchBitmapData.draw(box, mtx);
                           

                                frames.push(scratchBitmapData);
                                frameXs.push(flooredX);
                                frameYs.push(flooredY);

                         
								box.removeChild(clip);
                             }
						}
						return  bmdFrame;
				}
				
				
				
				public static function creatFramesAngles(clipClass:Class,wd:Number,hg:Number):BmdFrames
				{
					 
					  bmdFrame = new BmdFrames();
					  var clip :Sprite    = Sprite( new clipClass() );
					  var box  :Sprite    = new Sprite();
					  var bmd1:BitmapData = new BitmapData(wd, hg, true, 0x000000);
					  var bmd2:BitmapData = new BitmapData(wd, hg, true, 0x000000);
					  var bmd3:BitmapData = new BitmapData(wd, hg, true, 0x000000);
					  var bmd4:BitmapData = new BitmapData(wd, hg, true, 0x000000);
					  
					  
					  box.addChild(clip);
					  bmd1.draw(box); 
					   bmdFrame.frames[0] = bmd1;
					  
					  clip.scaleX = -1;
					 
					  clip.x = wd;
					  bmd2.draw(box);
					  bmdFrame.frames[1] = bmd2;
					  
					  clip.scaleY = -1;
					  clip.y = hg;
					 
					  
					  bmd3.draw(box);
					  bmdFrame.frames[2] = bmd3;
					  clip.scaleX = 1;
					 
					  clip.x = 0;
					  bmd4.draw(box);
					   bmdFrame.frames[3] = bmd4;
					  
					  for (var i:int = 0; i < 4; i++) 
					  {
						  bmdFrame.frameXs[i] = 0;
						  bmdFrame.frameYs[i] = 0;
					  }
					  
					  return  bmdFrame;
				}
				 static public function createBmpFramesFromMC2(clipClass:Class, wd:Number, hg:Number):BmdFrames
				 {
					 var clip:MovieClip = MovieClip(new clipClass());
					 bmdFrame = new BmdFrames();
					 var totalFrame:int = clip.totalFrames;
					 var bmd:BitmapData
					 for (var i:int = 0; i < totalFrame; i++) 
					 {
						 clip.gotoAndStop(i + 1);
						 bmd = new BitmapData(wd, hg, true, 0);
						 bmd.draw(clip);
						  bmdFrame.frames[i] = bmd;
						  bmdFrame.frameXs[i] = 0;
						  bmdFrame.frameYs[i] = 0;
					 }
					 return  bmdFrame;
				 }
				
				public static function getBitMap(clipClass:Class,wd:Number,hg:Number):BmdFrames
				{
					 bmdFrame = new BmdFrames();
					 var clip :Sprite    = Sprite(new clipClass());
					 var bmd1:BitmapData = new BitmapData(wd, hg, true, 0x000000);
					 bmd1.draw(clip);
					 bmdFrame.frames[0]  = bmd1;
					 bmdFrame.frameXs[0] = 0;
					 bmdFrame.frameYs[0] = 0;
					 return  bmdFrame;
				}
				
				
				 public static function disposeScratch() : void
				 {
                     scratchBitmapData.dispose();
                     scratchBitmapData = null;
                 }
				 
				
				
				protected static function prepareScratch(rect : Rectangle) : void 
				  {
                        var sizeIncreased : Boolean = false;
                        while (rect.width >= scratchSize || rect.height >= scratchSize) {
                                scratchSize *= 2;
                                sizeIncreased = true;
                        }
                        if (scratchBitmapData != null && sizeIncreased) {
                                disposeScratch();
                        }
                        if (scratchBitmapData == null) {
                                scratchBitmapData = new BitmapData(scratchSize, scratchSize, true, 0);
                        } else {
                                scratchBitmapData.fillRect(scratchBitmapData.rect, 0);
                        }
                }
				
        }
}