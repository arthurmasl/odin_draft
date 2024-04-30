package main

import "core:fmt"
import rl "vendor:raylib"

main :: proc() {
  rl.SetConfigFlags(rl.ConfigFlags{.WINDOW_UNFOCUSED})
  rl.InitWindow(1280, 1390, "game prototype")
  rl.SetWindowPosition(rl.GetMonitorWidth(0), 0)

  center := rl.Vector2{f32(rl.GetScreenWidth()) / 2, f32(rl.GetScreenHeight()) / 2}
  vectorToRotate := rl.Vector2{100, 0}

  for !rl.WindowShouldClose() {
    rotationAngle := 250 * rl.DEG2RAD
    rotatedVector := rl.Vector2Rotate(vectorToRotate, f32(rotationAngle))

    rl.BeginDrawing()
    rl.ClearBackground(rl.BLACK)

    rl.DrawCircleV(center, 5, rl.RED)
    rl.DrawLineV(center, center + vectorToRotate, rl.BLUE)
    rl.DrawLineV(center, center + rotatedVector, rl.GREEN)

    rl.EndDrawing()

  }

}
