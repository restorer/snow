/**
    Convert a pointer to haxe and back
    Copyright Sven Bergström 2014
    Created for snow https://github.com/underscorediscovery/snow
    License MIT

    usage :
        to haxe (store as Float on haxe side) :

            Thing* thing = new Thing();
            value thing_value = to_hx<Thing>( thing );
            return thing_value;

        from haxe again :

            Thing* thing = from_hx<Thing>( thing_value ;)
            if( thing ) {
                //use thing
            }

    :todo:
        use std::u_intptr_t from cstdint rather,
           but seems even with flags forced for HXCPP_CPP11
           i'm not seeing it found in builds on mac latest etc
*/


#ifndef _SNOW_HX_H_
#define _SNOW_HX_H_

#include <stdint.h>

namespace snow {

    //convert pointer from C++ to intptr and pass to haxe through Float
    //for ensuring bit storage space for the size of the value.

        template <class T>
        inline T* from_hx( value _hx_value ) {
            return (T*) (uintptr_t) val_float( _hx_value );
        }

        template <class T>
        inline value to_hx( T* _instance ) {
            return alloc_float( (uintptr_t) _instance );
        }

    //convert haxe.io.BytesData to and from unsigned char*

        inline const unsigned char* to_bytes( value bytes ) {

            if (val_is_string(bytes)) {
                return (unsigned char *)val_string(bytes);
            }

            buffer buf = val_to_buffer(bytes);

            if (buf == 0) {
                return NULL;
            }

            return (unsigned char*)buffer_data(buf);

        } //const to_bytes

        inline unsigned char* to_bytes_rw( value bytes ) {

            if (val_is_string(bytes)) {
                return (unsigned char *)val_string(bytes);
            }

            buffer buf = val_to_buffer(bytes);

            if (buf == 0) {
                val_throw(alloc_string("to_bytes_rw, invalid byte data! since it's rw version, this is likely to explode on returning NULL"));
            }

            return (unsigned char*)buffer_data(buf);

        } //non-const to_bytes_rw


} //snow namespace

#endif //_SNOW_HX_H_
