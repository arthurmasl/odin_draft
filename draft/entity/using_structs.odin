package main

import "core:fmt"

Entity :: struct {
  id: u16,
}

Positioner :: struct {
  pos: [2]f32,
}

Quacker :: struct {
  can_quack: bool,
}

Duck :: struct {
  using entity:     Entity,
  using quacker:    Quacker,
  using positioner: Positioner,
  name:             string,
}

main :: proc() {
  duck := Duck {
    name      = "Bob",
    can_quack = true,
    pos       = {5, 5},
    id        = 114,
  }

  entity_process(duck)
  quacker_process(duck)
  duck_process(duck)
  pos_process(duck)

  ent := Entity {
    id = 15,
  }

  entity_process(ent)
}

entity_process :: proc(entity: Entity) {
  fmt.println(entity.id)
}

quacker_process :: proc(quacker: Quacker) {
  fmt.println(quacker.can_quack)
}

pos_process :: proc(positioner: Positioner) {
  fmt.println(positioner.pos)
}

duck_process :: proc(duck: Duck) {
  fmt.println(duck.name, duck.can_quack, duck.pos, duck.id)
}
