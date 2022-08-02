#include "HelloWorld.pb.h"
#include <iostream>
#define HL_NAME(n) protobuf_hl_##n

#include <hl.h>
//#include "Example1.pb.h"

typedef char encode_char;

const int MAX_LENGTH = 1024;

char* uchar2char(unsigned char* source) {
    char* ret;
    int p = 8;
    int f = 0;
    while (f!=p)
    {
        strcat(ret, (char*)source);
        source++;
        f++;
    }
    return ret;
}

HL_PRIM vbyte* HL_NAME(helloworld_en)(vstring* str, int id)
{
 
    lm::HelloWorld helloworld;
   
  
    hl_buffer* b = hl_alloc_buffer();
    hl_buffer_str(b, (uchar*)str);

    vbyte* strs = (vbyte*)hl_buffer_content(b, NULL);

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

    bool b = helloworld.ParseFromArray(bytes, MAX_LENGTH);
    if (!b)
    {
        hl_dyn_setp(obj, hl_hash_utf8("str"), &hlt_bytes, "error");
        hl_dyn_seti(obj, hl_hash_utf8("id"), &hlt_i32, -1);
    }

    uchar* rets = hl_to_utf16((char*)helloworld.str().data());

    hl_buffer* bf = hl_alloc_buffer();

    hl_buffer_str(bf, rets);

    vbyte* strs = (vbyte*)hl_buffer_content(bf, NULL);

    hl_dyn_setp(obj, hl_hash_utf8("str"), &hlt_bytes, strs);
    hl_dyn_seti(obj, hl_hash_utf8("id"), &hlt_i32, helloworld.id());
    

    return obj;
}

//HL_PRIM vbyte* HL_NAME(helloworld_de_get_str)(vdynamic* dyn)
//{
//    vbyte* bytes = hl_dyn_getp(dyn, hl_hash_utf8("str"), &hlt_bytes);
//}

#define _ENCODE_CHAR _ABSTRACT( encode_char )

DEFINE_PRIM(_BYTES, helloworld_en, _STRING _I32);
DEFINE_PRIM(_DYN, helloworld_de, _BYTES);


#include<iostream>


int main()
{
    std::cout << "hello" << std::endl;
    system("pause");
}


/**
using namesapce std;
string str = "hello world";
const char *p = str.data();
printf(p);
//==>
//  hello world

string str = "hello world";
const char *p = str.c_str();
printf(p);
//==>
//  hello world

*/