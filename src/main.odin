package main

import "core:fmt"
import rl "vendor:raylib"

width: f32
height: f32
camera: rl.Camera2D
center: rl.Vector2

RANGE :: 1200
COUNT :: 6000
RADIUS :: 2

particles: [COUNT]rl.Vector2

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

  genereate_particles()

  rl.EnableEventWaiting()

  for !rl.WindowShouldClose() {
    update()
    draw()
  }

  defer rl.CloseWindow()
}

update :: proc() {
  if rl.IsMouseButtonPressed(.LEFT) {
    genereate_particles()
  }
}

placedParticles := 0
retries := 0

genereate_particles :: proc() {
  placedParticles = 0
  retries = 0

  for placedParticles != COUNT {
    retries += 1
    if retries == COUNT * 2 do break

    pos := rl.Vector2 {
      f32(rl.GetRandomValue(-RANGE / 2, RANGE / 2)),
      f32(rl.GetRandomValue(-RANGE / 2, RANGE / 2)),
    }

    canFit := true
    for &other_particle in particles {
      if rl.CheckCollisionCircles(pos, RADIUS, other_particle, RADIUS * 2) {
        canFit = false
        break
      }
    }

    if canFit {
      particles[placedParticles] = pos
      placedParticles += 1
    }
  }
}

draw_particles :: proc() {
  for &particle in particles {
    rl.DrawCircleV(particle, RADIUS, rl.GRAY)
  }
}

draw :: proc() {
  rl.BeginDrawing()
  rl.ClearBackground(rl.BLACK)
  rl.BeginMode2D(camera)
  draw_particles()
  rl.EndMode2D()
  rl.DrawFPS(10, 10)
  rl.DrawText(
    rl.TextFormat("particles: %d, tries: %d", placedParticles, retries),
    10,
    30,
    20,
    rl.LIME,
  )
  rl.EndDrawing()
}
