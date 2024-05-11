package main

import "core:fmt"
import "core:os"
import rl "vendor:raylib"

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

texture: rl.Texture2D
shader_dir := cstring("shaders/shader.glsl")
shader: rl.Shader
time: f32

last_mod: os.File_Time

load_shader :: proc() {
  rl.UnloadShader(shader)
  shader = rl.LoadShader(nil, shader_dir)

  resolutionLoc := rl.GetShaderLocation(shader, "resolution")
  resolution := [2]f32{width * 2, height * 2}

  rl.SetShaderValue(shader, resolutionLoc, &resolution, rl.ShaderUniformDataType.VEC2)
}

main :: proc() {
  rl.SetConfigFlags(rl.ConfigFlags{.WINDOW_RESIZABLE, .WINDOW_UNFOCUSED})
  rl.InitWindow(1280, 1412, "game prototype")

  rl.SetWindowPosition(rl.GetMonitorWidth(0), 0)
  rl.SetTargetFPS(rl.GetMonitorRefreshRate(1))

  width = f32(rl.GetScreenWidth())
  height = f32(rl.GetScreenHeight())

  center = {width / 2, height / 2}
  camera = {
    zoom   = 1,
    offset = center,
  }

  offscreen.target = rl.LoadRenderTexture(
    i32(rl.GetScreenWidth()),
    i32(rl.GetScreenHeight()),
  )
  offscreen.source = {0, 0, width, -height}
  offscreen.dest = {0, 0, width, height}

  texture = rl.LoadTexture("resources/ball.png")
  load_shader()

  for !rl.WindowShouldClose() {
    update()
    draw()
  }

  rl.UnloadTexture(texture)
  rl.UnloadShader(shader)
}

update :: proc() {
  mod_time, ok := os.last_write_time_by_name(string(shader_dir))

  if last_mod != mod_time {
    last_mod = mod_time
    load_shader()
  }

  timeLoc := rl.GetShaderLocation(shader, "time")
  time = f32(rl.GetTime())
  rl.SetShaderValue(shader, timeLoc, &time, rl.ShaderUniformDataType.FLOAT)
}

draw :: proc() {
  rl.BeginDrawing()
  rl.ClearBackground(rl.BLACK)

  rl.BeginShaderMode(shader)
  rl.DrawRectangle(0, 0, i32(width), i32(height), rl.WHITE)
  rl.EndShaderMode()

  rl.DrawFPS(10, 10)
  rl.EndDrawing()
}

// draw_offscreen :: proc() {
//   rl.BeginTextureMode(offscreen.target)
//   rl.ClearBackground(rl.BLACK)
//   rl.BeginMode2D(camera)
//   rl.DrawTextureV(texture, {-f32(texture.width / 2), -f32(texture.height / 2)}, rl.WHITE)
//   rl.EndMode2D()
//   rl.EndTextureMode()
//
//   rl.BeginDrawing()
//   rl.ClearBackground(rl.BLACK)
//
//   rl.BeginShaderMode(shader)
//   rl.DrawTexturePro(
//     offscreen.target.texture,
//     offscreen.source,
//     offscreen.dest,
//     offscreen.origin,
//     0,
//     rl.WHITE,
//   )
//   rl.EndShaderMode()
//
//   rl.DrawFPS(10, 10)
//   rl.EndDrawing()
// }
