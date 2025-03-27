package main

import "core:fmt"

main :: proc() {
  arr1 := make([dynamic]int, 0, 10, context.temp_allocator)
  append(&arr1, 5)
  append(&arr1, 15)

  fmt.println(arr1, len(arr1), cap(arr1))

  defer free_all(context.temp_allocator)
}
