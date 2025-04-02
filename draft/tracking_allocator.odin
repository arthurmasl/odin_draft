package main

import "core:fmt"
import "core:mem"

main :: proc() {
  when ODIN_DEBUG {
    track: mem.Tracking_Allocator
    mem.tracking_allocator_init(&track, context.allocator)
    context.allocator = mem.tracking_allocator(&track)

    defer {
      if len(track.allocation_map) > 0 {
        fmt.eprintf("=== %v allocations not freed: ===\n", len(track.allocation_map))
        for _, entry in track.allocation_map {
          fmt.eprintf("- %v bytes @ %v\n", entry.size, entry.location)
        }
      }
      mem.tracking_allocator_destroy(&track)
    }
  }

  arr1 := make([dynamic]u8, 10, context.allocator)
  append(&arr1, 222)
  defer delete(arr1)

  set1 := make(map[string]int)
  set1["apples"] = 1
  defer delete(set1)

  fmt.println(set1)

  apples := set1["apples"] or_else 2
  grapes := set1["grapes"] or_else 1

  fmt.println(apples)
  fmt.println(grapes)

  assert(grapes == 1)
  ensure(grapes == 1)

  sl1 := []int{1, 2, 3}

  fmt.println(sl1)
  fmt.println(typeid_of(type_of(sl1)))

  fmt.println("allocator index", context.user_index)

  {
    fmt.println("allocator index", context.user_index)
    some()
  }

  free_all(context.allocator)
}

some :: proc() {
  fmt.println("allocator index", context.user_index)
  fmt.println(context.allocator)
}
