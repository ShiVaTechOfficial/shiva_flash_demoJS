F:\flex_sdk_4.6\bin\compc.exe -optimize -strict -include-sources AS3JS_Demo_20120727_Assets.as -output AS3JS_Demo_20120727_Assets.swc
F:\flex_sdk_4.6\bin\mxmlc.exe -optimize -strict -static-link-runtime-shared-libraries=true -debug=false AS3JS_Demo_20120727_Loader.as -output AS3JS_Demo_20120727_Loader.swf
F:\flex_sdk_4.6\bin\mxmlc.exe -optimize -strict -default-script-limits 2000 120 -static-link-runtime-shared-libraries=true -include-libraries=AS3JS_Demo_20120727.swc,AS3JS_Demo_20120727_Runtime.swc,AS3JS_Demo_20120727_Bridge.swc,AS3JS_Demo_20120727_Assets.swc,AS3JS_Demo_20120727_Vorbis.swc -debug=false AS3JS_Demo_20120727.as -output AS3JS_Demo_20120727.swf
