package main

import "core:fmt"

main :: proc() {
  arr1 := make([dynamic]uint)
  writeArr(&arr1)

  readSlice(arr1[:])
}

writeArr :: proc(arr: ^[dynamic]uint) {
  append(arr, 1)
  fmt.println(arr)
}

readSlice :: proc(sl: []uint) {
  fmt.println(sl)
}
