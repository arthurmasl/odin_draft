package main

import "core:fmt"
import rl "vendor:raylib"
import rlgl "vendor:raylib/rlgl"

DARK :: rl.Color{118, 150, 86, 255}
LIGHT :: rl.Color{238, 238, 210, 255}
WHITE :: rl.Color{248, 248, 248, 255}
BLACK :: rl.Color{86, 83, 82, 255}
ACTIVE :: rl.Color{187, 203, 68, 200}

SIZE :: 100
GAP :: 200

LETTERS := "abcdefgh"
NUMBERS := "87654321"
PIECES := "PRNBQKP"

board: [8][8]i32
active_key: rune

main :: proc() {
  rl.SetConfigFlags(rl.ConfigFlags{.WINDOW_RESIZABLE, .WINDOW_UNFOCUSED})
  rl.InitWindow(1280, 1412, "main")

  rl.SetWindowPosition(rl.GetMonitorWidth(0), 0)
  rl.SetTargetFPS(rl.GetMonitorRefreshRate(0))

  init()

  for !rl.WindowShouldClose() {
    update()
    draw()
  }

  defer rl.CloseWindow()
}

init :: proc() {
  board = [8][8]i32 {
    {7, 7, 7, 7, 7, 7, 7, 7},
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0},
    {1, 1, 1, 1, 1, 1, 1, 1},
    {2, 3, 4, 5, 6, 4, 3, 2},
  }

  fmt.println(board)
}

update :: proc() {
  key := rl.GetCharPressed()

  if key != 0 {
    active_key = key
  }
}

draw :: proc() {
  rl.BeginDrawing()
  rl.ClearBackground(rl.BLACK)

  for cols, row in board {
    for piece, col in cols {
      // cords
      x := GAP + i32(col) * SIZE
      y := GAP + i32(row) * SIZE

      // values
      number := NUMBERS[row]
      letter := LETTERS[col]
      is_active := rune(letter) == active_key || rune(number) == active_key

      // color
      color_even := col % 2 == 0 ? LIGHT : DARK
      color_odd := col % 2 != 0 ? LIGHT : DARK
      color := row % 2 == 0 ? color_even : color_odd

      rl.DrawRectangle(x, y, SIZE, SIZE, color)

      if is_active {
        rl.DrawRectangle(x, y, SIZE, SIZE, ACTIVE)
      }

      // pieces
      if piece != 0 {
        rl.DrawText(rl.TextFormat("%c", PIECES[piece - 1]), 35 + x, 35 + y, 50, piece == 7 ? BLACK : WHITE)
      }

      // numbers
      if col == 0 {
        rl.DrawText(rl.TextFormat("%c", number), 5 + x, 5 + y, 20, BLACK)
      }

      // letters
      if row == 7 {
        rl.DrawText(rl.TextFormat("%c", letter), 80 + x, 80 + y, 20, BLACK)
      }

    }
  }

  rl.EndDrawing()
}
