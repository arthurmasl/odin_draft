package main

import "core:fmt"

ShapeType :: enum u8 {
  Rectangle = 4,
  Triangle  = 3,
  Circle    = 0,
}

Shape :: struct {
  id:      u8,
  area:    u8,
  variant: ShapeType,
}

main :: proc() {
  rect := Shape {
    variant = .Rectangle,
    area    = 1,
  }
  circle := Shape {
    variant = .Circle,
    area    = 2,
  }

  shapes := [?]Shape{rect, circle}

  getAreaSwitch(&rect)
  getAreaSwitch(&circle)

  total := totalArea(shapes[:])
  fmt.println(total)

  fmt.println(circle.variant, u8(circle.variant))
}

getAreaSwitch :: proc(shape: ^Shape) -> u8 {
  return u8(shape.variant) * 2
}

totalArea :: proc(shapes: []Shape) -> (total: u8) {
  for &shape in shapes do total += getAreaSwitch(&shape)
  return total
}
