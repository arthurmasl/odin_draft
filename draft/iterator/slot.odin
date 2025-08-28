#+feature dynamic-literals
package main

import "core:fmt"

Slot :: struct {
  id:   uint,
  used: bool,
}

Slot_Iterator :: struct {
  index: uint,
  data:  []Slot,
}

make_slot_iterator :: proc(data: []Slot) -> Slot_Iterator {
  return {data = data}
}

slot_iterator :: proc(it: ^Slot_Iterator) -> (val: Slot, idx: uint, cond: bool) {
  for cond = it.index < len(it.data); cond; cond = it.index < len(it.data) {
    if !it.data[it.index].used {
      it.index += 1
      continue
    }

    val = it.data[it.index]
    idx = it.index
    it.index += 1
    break
  }

  return
}

slot_iterator_ptr :: proc(it: ^Slot_Iterator) -> (val: ^Slot, idx: uint, cond: bool) {
  for cond = it.index < len(it.data); cond; cond = it.index < len(it.data) {
    if !it.data[it.index].used {
      it.index += 1
      continue
    }

    val = &it.data[it.index]
    idx = it.index
    it.index += 1
    break
  }

  return
}

main :: proc() {
  slots := make([]Slot, 128)
  slots[10] = {
    id   = 111,
    used = true,
  }
  slots[2] = {
    id   = 222,
    used = true,
  }

  it := make_slot_iterator(slots[:])

  for val in slot_iterator(&it) {
    fmt.println(val)
  }
}
