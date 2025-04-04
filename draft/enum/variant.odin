package main

import "core:fmt"

ShapeType :: enum {
  Rectangle,
  Triangle,
  Circle,
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

  getAreaSwitch(rect)
  getAreaSwitch(circle)

  total := totalArea(shapes[:])
  fmt.println(total)
}

getAreaSwitch :: proc(shape: Shape) -> u8 {
  result: u8

  #partial switch shape.variant {
  case .Rectangle:
    result += shape.area + 1
  case .Circle:
    result += shape.area * 2
  }

  return result
}

totalArea :: proc(shapes: []Shape) -> u8 {
  total: u8

  for shape in shapes {
    total += getAreaSwitch(shape)
  }

  return total
}
