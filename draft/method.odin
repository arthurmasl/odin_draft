package main

import "core:fmt"

Entity :: struct {
  name:   string,
  state:  bit_set[EntityState],
  update: type_of(update_player),
}

EntityState :: enum {
  Alive,
  Dead,
}

update_player :: proc(entity: ^Entity, state: EntityState) {
  entity.state = {state}
  fmt.printfln("update entity %s state from %v to %v", entity.name, entity.state, state)
}

main :: proc() {
  player := Entity {
    name   = "Mikey",
    state  = {.Dead},
    update = update_player,
  }

  player->update(.Alive)

  fmt.printfln("%+w", player)
  fmt.println(size_of(player), size_of(player.state))

  assert(card(player.state) == 1)
  assert(size_of(player.state) == 1)
  assert(player.state == {.Alive})
}
