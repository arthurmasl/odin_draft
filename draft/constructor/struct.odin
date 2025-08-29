package main

import "core:fmt"

Entity :: struct {
  id:   u16,
  name: string,
}

entity_create :: proc(name: string) -> ^Entity {
  @(static) id: u16

  entity := new(Entity)
  entity.name = name
  entity.id = id
  id += 1

  return entity
}

main :: proc() {
  bob := entity_create("Bob")
  jacob := entity_create("Jacob")

  fmt.println(bob)
  fmt.println(jacob)
}
