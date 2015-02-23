package snow.io.typedarray;


    import haxe.io.Bytes;

    @:forward()
    abstract ArrayBuffer(Bytes) from Bytes to Bytes {
        public inline function new( byteLength:Int ) {
            this = Bytes.alloc( byteLength );
        }

        #if js
            @:to function toJSArrayBuffer() : js.html.ArrayBuffer {
                return untyped new js.html.Uint8Array(this.getData()).buffer;
            }

            @:from static function fromJSArrayBuffer(buf:js.html.ArrayBuffer) {
                return Bytes.ofData(cast buf);
            }
        #end
    }
