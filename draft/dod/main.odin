package main

import rl "vendor:raylib"

DD :: false

ZOOM :: 1
RANGE :: 1000
COUNT :: 100000
SIZE :: 3
SPEED :: 10

texture: rl.Texture2D

width: f32
height: f32
camera: rl.Camera2D
center: rl.Vector2
offscreen: struct {
  target: rl.RenderTexture2D,
  source: rl.Rectangle,
  dest:   rl.Rectangle,
  origin: rl.Vector2,
}

main :: proc() {
  rl.SetConfigFlags(rl.ConfigFlags{.WINDOW_RESIZABLE, .WINDOW_UNFOCUSED})
  rl.InitWindow(1280, 1412, "game prototype")

  rl.SetWindowPosition(rl.GetMonitorWidth(0), 0)
  rl.SetTargetFPS(rl.GetMonitorRefreshRate(0) * 3)

  width = f32(rl.GetScreenWidth())
  height = f32(rl.GetScreenHeight())

  center = {width / 2, height / 2}
  camera = {
    zoom   = ZOOM,
    offset = center,
  }

  texture = rl.LoadTexture("resources/ball.png")

  offscreen.target = rl.LoadRenderTexture(
    i32(rl.GetScreenWidth()),
    i32(rl.GetScreenHeight()),
  )
  offscreen.source = {0, 0, width, -height}
  offscreen.dest = {0, 0, width, height}

  if DD == true {
    dd_init_entities()
  } else {
    oo_init_entities()
  }

  for !rl.WindowShouldClose() {
    if DD == true {
      dd_update()
      dd_draw()
    } else {
      oo_update()
      oo_draw()
    }
  }
}
