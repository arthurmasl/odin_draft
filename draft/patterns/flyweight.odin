package main

import "core:fmt"
import rl "vendor:raylib"

Tile :: struct {
  using variant: ^Variant,
  pos:           i32,
}

Variant :: struct {
  texture: string,
  color:   string,
}

grass := Variant {
  color   = "green",
  texture = "grass.png",
}

water := Variant {
  color   = "blue",
  texture = "water.png",
}

main :: proc() {
  tiles: [10]Tile

  for &tile, i in tiles {
    tile = {
      pos     = i32(i),
      variant = rl.GetRandomValue(0, 1) == 1 ? &grass : &water,
    }
  }

  fmt.println(tiles[0].variant)
}
