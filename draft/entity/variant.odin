package main

import "core:fmt"

Entity :: struct {
  id:      u8,
  pos:     [2]f64,
  variant: union {
    Player,
    Monster,
  },
}

Player :: struct {
  hp: u8,
}
Monster :: struct {
  is_agro: bool,
}

main :: proc() {
  player := Entity {
    id = 0,
    variant = Player{hp = 100},
  }

  fmt.println(player)
  update_hp(&player)
  fmt.println(player)
}

update_hp :: proc(entity: ^Entity) {
  #partial switch &e in entity.variant {
  case Player:
    e.hp -= 10
  case Monster:
    e.is_agro = true
  }
}
