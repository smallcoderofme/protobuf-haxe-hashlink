cmake_minimum_required(VERSION 3.10)

set(DllName protobuf_hl)
project(${DllName} VERSION 1.0.0)

set(CMAKE_CXX_STANDARD 17)

get_filename_component(PARENT_DIR ${CMAKE_CURRENT_SOURCE_DIR} DIRECTORY)

message(STATUS "PARENT_DIR: ${PARENT_DIR}")


#set(PB_SRC ${CMAKE_CURRENT_BINARY_DIR}/proto)
set(PB_SRC ${CMAKE_CURRENT_SOURCE_DIR}/bin/proto)

message(STATUS "PB_SRC: ${PB_SRC}")

set(HL_DIR "D:/HaxeToolkit/hl")

message(STATUS "HL_DIR: ${HL_DIR}")

message(STATUS "src: ${src}")

add_library(${DllName} SHARED protobuf_hl.cpp ${PB_SRC}/HelloWorld.pb.cc)

#add_executable(${DllName} protobuf_hl.cpp ${src})

include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    ${HL_DIR}/include
    ${PB_SRC}
)

target_include_directories(${DllName} PUBLIC
                            INTERFACE ${PB_SRC}
                            INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/include
                            INTERFACE ${HL_DIR}/include
                           )

target_link_libraries(${DllName} PUBLIC
                        ${HL_DIR}/*.lib
                        ${CMAKE_CURRENT_SOURCE_DIR}/lib/libprotoc.lib
                        ${CMAKE_CURRENT_SOURCE_DIR}/lib/libprotobuf-lite.lib
                        ${CMAKE_CURRENT_SOURCE_DIR}/lib/libprotobuf.lib
                        )