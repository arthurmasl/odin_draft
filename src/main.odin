package main

import "core:fmt"
import rl "vendor:raylib"

width: f32
height: f32
camera: rl.Camera2D
center: rl.Vector2

RANGE :: 1200
COUNT :: 3000
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

particles: [dynamic]Particle
retries := 0

genereate_particles :: proc() {
  clear(&particles)
  retries = 0

  for len(particles) != COUNT {
    retries += 1
    if retries == COUNT * 2 do break

    pos := rl.Vector2 {
      f32(rl.GetRandomValue(-RANGE / 2, RANGE / 2)),
      f32(rl.GetRandomValue(-RANGE / 2, RANGE / 2)),
    }

    canFit := true
    for &particle in particles {
      if rl.CheckCollisionCircles(pos, RADIUS, particle.pos, RADIUS * 2) {
        canFit = false
        break
      }
    }

    if canFit {
      append(
        &particles,
        Particle {
          pos = pos,
          color = {
            u8(rl.GetRandomValue(0, 255)),
            u8(rl.GetRandomValue(0, 255)),
            u8(rl.GetRandomValue(0, 255)),
            255,
          },
        },
      )
    }
  }
}

draw_particles :: proc() {
  for &particle in particles {
    rl.DrawCircleV(particle.pos, RADIUS, particle.color)
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
    rl.TextFormat("particles: %d, tries: %d", len(particles), retries),
    10,
    30,
    20,
    rl.LIME,
  )
  rl.EndDrawing()
}
