package 
{
	import flash.utils.ByteArray	;
	import mx.core.ByteArrayAsset	;
  
	public class GeneratedPack
	{  
		// The main STK file
		//
        [Embed(source="S3DMain.stk", mimeType="application/octet-stream")]
        private static const FileData0:Class ;

		// Additional files
		//  
        
    
		// 'File' access function
		//
		public static function getDataForFilename ( filename:String ) : ByteArray 
		{
			if ( filename == "S3DMain.stk" ) return new FileData0 ( ) as ByteArray ;			
			
			return null ;
		}
    }
}
