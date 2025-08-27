#+feature dynamic-literals
package main

import "core:fmt"

STRUCTS_NUM :: 10

Entity_Id :: distinct u16

Pseudo_Struct :: struct {
  name: string,
}

Memory :: struct {
  bindings:  [STRUCTS_NUM]Pseudo_Struct,
  pipelines: [STRUCTS_NUM]Pseudo_Struct,
}

memory: Memory

entity_create :: proc(name: string) -> Entity_Id {
  @(static) stack_id: Entity_Id
  id := stack_id
  stack_id += 1

  memory.bindings[id] = Pseudo_Struct {
    name = name,
  }
  memory.pipelines[id] = Pseudo_Struct {
    name = name,
  }

  return id
}

main :: proc() {
  bob_id := entity_create("Bob")
  jacob_id := entity_create("Jacob")

  fmt.println(memory.bindings[bob_id])
  fmt.println(memory.bindings[jacob_id])
}
