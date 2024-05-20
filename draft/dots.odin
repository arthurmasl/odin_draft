package main

import "core:fmt"
import rl "vendor:raylib"

width: f32
height: f32
camera: rl.Camera2D
center: rl.Vector2

RANGE :: 1200
COUNT :: 4000
RADIUS :: 2

Particle :: struct {
  pos:   rl.Vector2,
  color: rl.Color,
}

main :: proc() {
  rl.SetConfigFlags(rl.ConfigFlags{.WINDOW_RESIZABLE, .WINDOW_UNFOCUSED})
  rl.InitWindow(1280, 1412, "game prototype")

  rl.SetWindowPosition(rl.GetMonitorWidth(0), 0)
  rl.SetTargetFPS(rl.GetMonitorRefreshRate(0))

  width = f32(rl.GetScreenWidth())
  height = f32(rl.GetScreenHeight())

  center = {width / 2, height / 2}
  camera = {
    zoom   = 1,
    offset = center,
  }

  for !rl.WindowShouldClose() {
    update()
    draw()
  }

  defer rl.CloseWindow()
}

cursor: rl.Vector2
dot: f32
angle: f32
line_angle: f32

anchor := rl.Vector2{500, 500}

update :: proc() {
  cursor = rl.GetMousePosition()
  dot = rl.Vector2DotProduct(rl.Vector2Normalize(center), rl.Vector2Normalize(cursor))
  angle = rl.Vector2Angle(rl.Vector2Normalize(center), rl.Vector2Normalize(cursor))
  line_angle = rl.Vector2LineAngle(
    rl.Vector2Normalize(center),
    rl.Vector2Normalize(cursor),
  )
}

draw_dot :: proc() {
  rl.DrawLineV(center, cursor, rl.RED)
  rl.DrawLineV(cursor, anchor, rl.PURPLE)

  rl.DrawCircleV(center, 5, rl.BLUE)
  rl.DrawCircleV(cursor, 5, rl.DARKGREEN)
  rl.DrawCircleV(anchor, 5, rl.GREEN)

}

draw :: proc() {
  rl.BeginDrawing()
  rl.ClearBackground(rl.BLACK)
  // rl.BeginMode2D(camera)
  draw_dot()
  // rl.EndMode2D()
  rl.DrawFPS(10, 10)
  rl.DrawText(rl.TextFormat("dot: %f", dot), 10, 30, 20, rl.LIME)
  rl.DrawText(rl.TextFormat("angle: %f", angle), 10, 50, 20, rl.LIME)
  rl.DrawText(rl.TextFormat("line angle: %f", line_angle), 10, 70, 20, rl.LIME)
  rl.EndDrawing()
}
