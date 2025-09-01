package main

import "core:fmt"

Item :: enum u8 {
  One,
  Two,
  Three,
}

main :: proc() {
  set1 := bit_set[Item]{.One, .Two}
  set2 := bit_set[Item]{.One, .Three}

  fmt.println(set1)
  fmt.println(set2)

  fmt.println(set1 + set2)
  fmt.println(set1 - set2)
  fmt.println(set1 & set2)
  fmt.println(set1 | set2)
  fmt.println(set1 ~ set2)

  set := bit_set[Item]{.One, .Two}
  sub := bit_set[Item]{.One}
  fmt.println(set > sub)
  fmt.println(set <= sub)
  fmt.println(set == sub)
  fmt.println(set != sub)

  fmt.println(.One in set1)
  fmt.println(.Three not_in set1)
}
