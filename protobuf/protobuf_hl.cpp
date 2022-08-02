#include "HelloWorld.pb.h"

#define HL_NAME(n) protobuf_hl_##n

#include <hl.h>


const int MAX_LENGTH = 1024;


HL_PRIM vbyte* HL_NAME(helloworld_en)(vstring* str, int id)
{

    lm::HelloWorld helloworld;

    helloworld.set_id(id);

    char* yess = hl_to_utf8(str->bytes);

    helloworld.set_str(yess);//strs


    //vbyte* bytes = hl_alloc_bytes(MAX_LENGTH);
    vbyte chars[MAX_LENGTH] = {};


    helloworld.SerializeToArray(chars, MAX_LENGTH);


    return chars;
}

HL_PRIM vdynamic* HL_NAME(helloworld_de)(vbyte* bytes)
{
    vdynamic* obj = (vdynamic*)hl_alloc_dynobj();
    lm::HelloWorld helloworld;

    helloworld.ParseFromArray(bytes, MAX_LENGTH);

    uchar* rets = hl_to_utf16((char*)helloworld.str().data());

    hl_buffer* bf = hl_alloc_buffer();

    hl_buffer_str(bf, rets);

    vbyte* strs = (vbyte*)hl_buffer_content(bf, NULL);

    hl_dyn_setp(obj, hl_hash_utf8("str"), &hlt_bytes, strs);
    hl_dyn_seti(obj, hl_hash_utf8("id"), &hlt_i32, helloworld.id());


    return obj;
}


DEFINE_PRIM(_BYTES, helloworld_en, _STRING _I32);
DEFINE_PRIM(_DYN, helloworld_de, _BYTES);
