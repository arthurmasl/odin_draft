package main

import "core:fmt"

Handle :: struct {
  idx: u32,
  gen: u32,
}

Handle_Map :: struct($T: typeid, $HT: typeid, $N: int) {
  items:        [N]T,
  num_items:    u32,
  next_unused:  u32,
  unused_items: [N]u32,
  num_unused:   u32,
}

add :: proc(m: ^Handle_Map($T, $HT, $N), v: T) -> (HT, bool) #optional_ok {
  v := v

  if m.next_unused != 0 {
    idx := m.next_unused
    item := &m.items[idx]
    m.next_unused = m.unused_items[idx]
    m.unused_items[idx] = 0
    gen := item.handle.gen
    item^ = v
    item.handle.idx = u32(idx)
    item.handle.gen = gen + 1
    m.num_unused -= 1
  }

  if m.num_items == 0 {
    m.items[0] = {}
    m.num_items += 1
  }

  if m.num_items == len(m.items) {
    return {}, false
  }

  item := &m.items[m.num_items]
  item^ = v
  item.handle.idx = u32(m.num_items)
  item.handle.gen = 1
  m.num_items += 1

  return item.handle, true
}

get :: proc(m: ^Handle_Map($T, $HT, $N), h: HT) -> ^T {
  if h.idx <= 0 || h.idx >= m.num_items {
    return nil
  }

  if item := &m.items[h.idx]; item.handle == h {
    return item
  }

  return nil
}

Position :: struct {
  handle: Handle,
  pos:    [2]f32,
}

Velocity :: struct {
  handle: Handle,
  vel:    [2]f32,
}

main :: proc() {
  positions: Handle_Map(Position, Handle, 2)
  velocities: Handle_Map(Velocity, Handle, 1)

  h1 := add(&positions, Position{pos = {10, 5}})
  h2 := add(&positions, Position{pos = {50, 55}})

  add(&velocities, Velocity{vel = {1, 1}})

  if e := get(&positions, h1); e != nil {
    fmt.println(e)
  }

  if e := get(&positions, h2); e != nil {
    fmt.println(e)
  }

  fmt.printfln("%#w", velocities)
}
