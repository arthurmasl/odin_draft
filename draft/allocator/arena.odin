package main

import "core:fmt"
import vmem "core:mem/virtual"

Pseudo_Object :: struct {
  id: uint,
}

Mesh :: struct {
  name:      string,
  bindings:  []Pseudo_Object,
  pipelines: []Pseudo_Object,
  arena:     vmem.Arena,
}

main :: proc() {
  // generate arena
  mesh_arena: vmem.Arena
  arena_allocator := vmem.arena_allocator(&mesh_arena)

  // generate mesh
  bindings := make([]Pseudo_Object, 1024, arena_allocator)
  pipelines := make([]Pseudo_Object, 1024, arena_allocator)
  mesh := Mesh {
    name      = "Player",
    bindings  = bindings,
    pipelines = pipelines,
    arena     = mesh_arena,
  }

  fmt.println(mesh.bindings[0])

  // free arena
  vmem.arena_destroy(&mesh.arena)
}
