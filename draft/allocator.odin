package main

import "core:fmt"
import "core:log"
import "core:mem"
import "core:mem/virtual"
import "core:slice"

Sprite :: struct {
  pos: i32,
}

Player :: struct {
  hp:     i32,
  sprite: Sprite,
}

Creature :: struct {
  hp:     i32,
  sprite: Sprite,
}

foo :: proc() {
  fmt.println(context.allocator)
  arr := make([dynamic]int, context.allocator)

  append(&arr, 1)
  append(&arr, 1)
  append(&arr, 1)
  append(&arr, 1)

  fmt.println(arr, cap(arr), len(arr), size_of(arr))
}

main :: proc() {
  arena: virtual.Arena
  arena_buffer: [1024 * 10]byte
  arena_init_error := virtual.arena_init_buffer(&arena, arena_buffer[:])

  if arena_init_error != nil {
    fmt.panicf("error initialzing arena: %v\n", arena_init_error)
  }

  arena_allocator := virtual.arena_allocator(&arena)
  defer virtual.arena_destroy(&arena)

  context.allocator = arena_allocator

  foo()
}
