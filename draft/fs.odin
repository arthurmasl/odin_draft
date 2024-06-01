package main

import "core:fmt"
import "core:os"
import "core:thread"

PATH :: "resources/test.json"

main :: proc() {
  file, file_ok := os.read_entire_file(PATH)

  if (!file_ok) {
    text := transmute([]byte)(string)("hello, world")
    os.write_entire_file(PATH, text)
  }

  if (file_ok) {
    text := string(file)
    fmt.println(text)
  }
}
