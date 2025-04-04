package main

import "core:fmt"

ShapeType :: enum u8 {
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

  getAreaSwitch(rect.variant)
  getAreaSwitch(circle.variant)

  total := totalArea(shapes[:])
  fmt.println(total)

  fmt.println(circle.variant, u8(circle.variant))
}

shape_edges := [?]u8{4, 3, 0}
getAreaSwitch :: proc(variant: ShapeType) -> u8 {
  return shape_edges[u8(variant)] * 2
}

totalArea :: proc(shapes: []Shape) -> (total: u8) {
  for shape in shapes do total += getAreaSwitch(shape.variant)
  return total
}
