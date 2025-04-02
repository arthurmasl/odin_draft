package main

import "base:intrinsics"
import "core:fmt"

SomeStruct :: struct {
  id: i32,
}

GenericStruct :: struct($N: int, $T: typeid) {
  data: [N]T,
}

main :: proc() {
  st1 := SomeStruct{55}

  // parameter type
  genericParam("hello")
  genericParam(22)
  genericParam(st1)

  // compile-time parameters
  genericProcParam(10)

  // generic typeid
  genericTypeid(f32)

  // generic struct
  st2 := GenericStruct(10, f32){}
  fmt.println(typeid_of(type_of(st2)), st2)

  // generic arr
  arr1 := make([dynamic]uint)
  append(&arr1, 1, 2, 3)
  newArr := genericArr(&arr1)
  fmt.println(arr1, newArr)

  // generic arr type
  sl1 := genericSlice([]f32, 2)
  fmt.println(sl1)

  // generic specialization
  sp := genericSpecialization(25)
  fmt.println(sp)
}

genericParam :: proc(name: $T) -> T {
  fmt.println(typeid_of(T), name)
  return name
}

genericProcParam :: proc($N: uint) -> [N]f32 {
  arr := [N]f32{}
  fmt.println(typeid_of(type_of(arr)), arr)
  return arr
}

genericTypeid :: proc($T: typeid) -> []T {
  sl := make([]T, 5)
  fmt.println(sl)
  return sl
}

genericArr :: proc(arr: ^$T/[dynamic]$E) -> T {
  fmt.println(typeid_of(T), typeid_of(E))
  fmt.println(typeid_of(type_of(arr)), arr)
  append(arr, 22)
  return arr^
}

genericSlice :: proc($T: typeid/[]$E, len: uint) -> T {
  return make(T, len)
}

genericSpecialization :: proc(id: $T) -> T where intrinsics.type_is_numeric(T) {
  fmt.println(typeid_of(T), id)
  return id
}
