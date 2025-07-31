package main

import "core:fmt"

EntityType :: enum u8 {
  Terrain,
  Grass,
  Display,
}

Binding :: struct {
  id: uint,
}

Pipeline :: struct {
  id:     uint,
  shader: rawptr,
}

Pass :: struct {
  id:    uint,
  color: string,
}

GlobalState :: struct {
  binding:  Binding,
  pipleine: Pipeline,
  pass:     Pass,
}

global := #soa[len(EntityType)]GlobalState{}

main :: proc() {
  // fmt.printfln("%#w", global)
  // fmt.printfln("%#w", global.binding)
  fmt.printfln("%#w", global.pipleine[EntityType.Grass])
  fmt.printfln("%w", global[EntityType.Grass].binding)

}
