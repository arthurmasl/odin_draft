package main

import "core:fmt"
import "core:mem"

main :: proc() {
  when ODIN_DEBUG {
    track: mem.Tracking_Allocator
    mem.tracking_allocator_init(&track, context.temp_allocator)
    context.temp_allocator = mem.tracking_allocator(&track)

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

  arr1 := make([dynamic]u8, 10, context.temp_allocator)
  fmt.println(arr1)

  free_all(context.allocator)
}
