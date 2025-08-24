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
  monster := Entity {
    id = 1,
    variant = Monster{is_agro = false},
  }

  fmt.println(player)
  update_hp(&player.variant.(Player))
  update_pos(&player)
  fmt.println(player)

  fmt.println(monster)
  update_agro(&monster.variant.(Monster))
  update_pos(&monster)
  fmt.println(monster)

  update_entity(&player)
  update_entity(&monster)
  fmt.println(player)
  fmt.println(monster)
}

update_pos :: proc(entity: ^Entity) {
  entity.pos += 1
}

update_hp :: proc(player: ^Player) {
  player.hp -= 10
}

update_agro :: proc(monster: ^Monster) {
  monster.is_agro = !monster.is_agro
}

update_entity :: proc(entity: ^Entity) {
  switch &e in entity.variant {
  case Player:
    e.hp -= 10
  case Monster:
    e.is_agro = true
  }
}
