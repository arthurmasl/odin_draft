package main

import "core:container/intrusive/list"
import "core:fmt"

Item :: struct {
  node:  list.Node,
  value: int,
}

main :: proc() {
  l: list.List

  one := Item {
    value = 10,
  }
  two := Item {
    value = 22,
  }

  list.push_back(&l, &one.node)
  list.push_back(&l, &two.node)

  iter := list.iterator_head(l, Item, "node")
  for s in list.iterate_next(&iter) {
    fmt.println(s.value)
  }
}
