#+feature dynamic-literals
package main

import "core:fmt"

main :: proc() {
  arr := make([dynamic]int, 8, 9, context.allocator)

  fmt.println(arr, len(arr), cap(arr), raw_data(arr))

  append(&arr, 1)
  append(&arr, 1)

  fmt.println(arr, len(arr), cap(arr), raw_data(arr))
}
