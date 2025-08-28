#+feature dynamic-literals
package main

import "core:fmt"

STR :: "test"

main :: proc() {
  str := "hello, " + STR + ", abc"
  // str += STR // not allowed

  fmt.println(str)

}
