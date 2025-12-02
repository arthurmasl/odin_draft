package main

import "core:fmt"

Window_Iterator :: struct($T: typeid) {
  slice: []T,
  size:  int,
  index: int,
}

window_iterator :: proc($T: typeid, it: ^Window_Iterator(T)) -> (window: []T, ok: bool) {
  if it.index + it.size > len(it.slice) do return nil, false

  window = it.slice[it.index:it.index + it.size]
  it.index += 1

  return window, true
}

main :: proc() {
  {
    data := []int{1, 2, 3, 4, 5, 6, 7}

    it := Window_Iterator(int) {
      slice = data,
      size  = 2,
    }

    for val in window_iterator(int, &it) {
      fmt.println(val)
    }
  }

  {
    data := "123456"

    it := Window_Iterator(string) {
      slice = data,
      size  = 2,
    }

    for val in window_iterator(string, &it) {
      fmt.println(val)
    }
  }
}
