//-----------------------------------------------------------------------------
package 
//-----------------------------------------------------------------------------
{
    //-------------------------------------------------------------------------
    
	import flash.text.*;
    import flash.utils.*;
	import flash.events.*;
	import flash.display.*;
	import flash.display3D.*;
	import flash.system.Capabilities;
	
	import flash.external.*;

    import com.stonetrip.shiva.engine.*;

    //-------------------------------------------------------------------------
    [SWF(width = "1024", height = "600", backgroundColor="#000000")]
    
    public class AS3JS_Demo_20120727 extends Sprite  
    //-------------------------------------------------------------------------
    {
		//---------------------------------------------------------------------
        private const kTotalStackSizeInBytes : int =    2 * 1024 * 1024 ;
        private const kTotalHeapSizeInBytes  : int =  256 * 1024 * 1024 ;
		
		//---------------------------------------------------------------------
		private var splashScreen : DisplayObject = null ;
        
		//---------------------------------------------------------------------
		public function AS3JS_Demo_20120727 ( ) : void 
		{		    
            addEventListener ( Event.ADDED_TO_STAGE, onAddedToStage ) ;
        }

		//---------------------------------------------------------------------
		public function init ( splash:DisplayObject ) : void 
		{
			splashScreen = splash ;
		}

		//---------------------------------------------------------------------
        private function onAddedToStage ( _e:Event ) : void 
        {
            removeEventListener ( Event.ADDED_TO_STAGE, onAddedToStage ) ;

			// Configure stage initial params
			//
			stage.scaleMode = StageScaleMode.NO_SCALE ;
			stage.align     = StageAlign.TOP_LEFT ;
			stage.frameRate = 30 ;
			
			if ( getFlashPlayerMajorVersion ( ) < 11 )
			{
				displayFlashPlayerVersionError ( ) ;
			}
			else
			{
				// Request 3D context
				//
				stage.stage3Ds[0].addEventListener ( Event.CONTEXT3D_CREATE, onContext3DCreate ) ;
				stage.stage3Ds[0].requestContext3D ( ) ;
			}
		}
		
       //---------------------------------------------------------------------
		private function getFlashPlayerMajorVersion ( ) : int
		{
			var flashPlayerMajorVersion:int = 0;
 
			var versionString:String = Capabilities.version;
			var pattern:RegExp = /^(\w*) (\d*),(\d*),(\d*),(\d*)$/;
			var result:Object = pattern.exec(versionString);
			if (result != null) 
			{
				flashPlayerMajorVersion = int(result[2]);
			} 
			return flashPlayerMajorVersion;
		}
		
       //---------------------------------------------------------------------
		private function displayFlashPlayerVersionError ( ) : void
		{
			// Create a text field (TODO: localize it)
			//
			var fmt:TextFormat 	= new TextFormat ( ) ;
			fmt.font			= "Helvetica" ;
			fmt.size			= 11 ;
			var txt:TextField 	= new TextField ( ) ;
			txt.text 			= "Sorry, Flash Player 11 is required to view this content." ;
			txt.textColor		= 0x808080 ;
			txt.autoSize		= TextFieldAutoSize.CENTER ;
			txt.antiAliasType	= AntiAliasType.ADVANCED ;
			txt.x				= 0 ;
			txt.y				= stage.stageHeight / 2 ;
			txt.width 			= stage.stageWidth  ;
			txt.height			= 11 ;
			txt.setTextFormat	( fmt ) ;
			stage.addChild 		( txt ) ;
		}

        //---------------------------------------------------------------------
		private function onContext3DCreate ( _e:Event ) : void
		{
		    if ( _e != null && _e.target != null )
		    {
        	    Bridge.init ( kTotalStackSizeInBytes, kTotalHeapSizeInBytes, stage, _e.target as Stage3D, onEngineInitialized, onEngineEvent, [  ], 2, 1 ) ;
    		}
    		else
    		{
    		    trace ( "Could not create Context3D!" ) ;
		    }
		}

		//---------------------------------------------------------------------
		private function onEngineInitialized ( ) : void
		{
    		addEventListener ( Event.ENTER_FRAME, onEnterFrame ) ;
			
			//-- insert callback to receive command from js
			ExternalInterface.addCallback( "sentfromjs", sendmetoshiva );
        }
        		
		//---------------------------------------------------------------------
		private function onEngineEvent ( _args:Array, _returns:Array ) : void 
		{
            // This function is called when following script function is called:
            // ... = system.callClientFunction ( "onEngineEvent", ... )
            
            // Values are arranged as follows:
            // type1, value1, type2, value2, type3, value3, ...
            //
            const kVarTypeNil       : int = 0 ;
            const kVarTypeNumber    : int = 1 ;
            const kVarTypeString    : int = 2 ;
            const kVarTypeBoolean	: int = 3 ;

            // How to get call arguments:
            //
            // if ( _args[0] == kVarTypeString ) doSomethingWithAString ( _args[1] ) ;
            // if ( _args[2] == kVarTypenumber ) doSomethingWithANumber ( _args[3] ) ;

            
            // How to return some values:
            //
            // _returns[0] = kVarTypeString  ; _returns[1] = "Hello Flash!" ;
            // _returns[2] = kVarTypeNumber  ; _returns[3] = 123.456 ;
            // _returns[4] = kVarTypeBoolean ; _returns[5] = true ;            
		}
		    
		//---------------------------------------------------------------------
		private function onEnterFrame ( _e:Event ) : void
		{
			// Fade out splash screen if any
			//
			if ( splashScreen != null )
			{
				splashScreen.alpha = Math.max ( 0.0, splashScreen.alpha - 2.0 / stage.frameRate ) ;
				
				if ( splashScreen.alpha == 0 )
				{
					stage.removeChild 	( splashScreen ) ;
					splashScreen 		= null ;
				}
			}
		}

		//--prototype function for sending js/as3 commands to shiva
		//public static function sendEventToDefaultUser ( _aimodel:String, _handler:String, _args:Array ) : void {};
		public function sendmetoshiva () : void
		{
			Bridge.sendEventToDefaultUser ( "SimpleProjector_Main", "onProjectorEvent", null ) //no args to send
//			Bridge.sendEventToDefaultUser ( "SimpleProjector_Main", "onProjectorEvent", [kVarTypeString, "additional_arg_0", kVarTypeString, "additional_arg_1"] )
//			for parameters: it follows the same rules as onEngineEvent:
//          const kVarTypeNil       : int = 0 ;
//          const kVarTypeNumber    : int = 1 ;
//          const kVarTypeString    : int = 2 ;
//          const kVarTypeBoolean	: int = 3 ;
//			parameters come in pairs: first "type", then "value".
		}

    //-------------------------------------------------------------------------
    }
//-----------------------------------------------------------------------------
}
//-----------------------------------------------------------------------------
