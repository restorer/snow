package snow.assets;

import snow.io.IO;
import snow.types.Types;
import snow.utils.Libs;
import snow.assets.AssetSystem;
import snow.io.typedarray.Uint8Array;


/**  An asset that contains byte `bytes` as a `Uint8Array`. Get assets from the `Assets` class, via `app.assets` */
class AssetBytes extends Asset {


        /** The `Uint8Array` this asset contains */
    public var bytes : Uint8Array;
        /** Whether or not this bytes data will load syncronously. Used in `load` only. */
    public var async : Bool = false;


        /** Called from `app.assets` */
    public function new( _assets:Assets, _info:AssetInfo, ?_async:Bool=false ) {

        super( _assets, _info );
        type = AssetType.bytes;
        async = _async;

    } //new

        /** Called from `app.assets.bytes`, or manually, if reloading the asset data at a later point.
            Note this function calls the onload handler in the next frame, so sync code can return. */
    public function load( ?onload:AssetBytes->Void ) {

        loaded = false;
            //clear any old data in case
        bytes = null;
            //load the new data
        snow.utils.ByteArray.readFile( info.path, { async:async }, function( result:snow.utils.ByteArray ) {

            var b : haxe.io.Bytes = result;

            bytes = new Uint8Array( b );

            loaded = true;

            if(onload != null) {
                // Snow.next(function(){
                    onload( this );
                // });
            }

        }); //readFile

    } //load

        /** This function is a synchronous call. */
    public function load_from_bytes( _bytes:Uint8Array, ?onload:AssetBytes->Void ) {

        loaded = false;

            bytes = _bytes;

        loaded = true;

        if(onload != null) {
            onload( this );
        }

    } //load_from_bytes


} //AssetBytes
