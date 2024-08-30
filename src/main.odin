package main

import "core:fmt"
import "core:strings"
import rl "vendor:raylib"
import rlgl "vendor:raylib/rlgl"

DARK :: rl.Color{118, 150, 86, 255}
LIGHT :: rl.Color{238, 238, 210, 255}
WHITE :: rl.Color{248, 248, 248, 255}
BLACK :: rl.Color{86, 83, 82, 255}

GREEN :: rl.Color{187, 203, 68, 200}
GRAY :: rl.Color{0, 0, 0, 100}

SIZE :: 100
GAP :: 200

AVAILABLE :: 9

LETTERS := "abcdefgh"
NUMBERS := "87654321"
PIECES := "PRNBQKP"

board: [8][8]i32
active_key: rune
piece_number := i32(-1)
command: [dynamic]rune

main :: proc() {
  rl.SetConfigFlags(rl.ConfigFlags{.WINDOW_RESIZABLE, .WINDOW_UNFOCUSED})
  rl.InitWindow(1280, 1412, "main")

  rl.SetWindowPosition(rl.GetMonitorWidth(0), 0)
  rl.SetTargetFPS(rl.GetMonitorRefreshRate(0))
  rl.SetExitKey(.KEY_NULL)

  init()

  for !rl.WindowShouldClose() {
    update()
    draw()
  }

  defer rl.CloseWindow()
}

init :: proc() {
  init_board()
}

update :: proc() {
  // escape
  if rl.IsKeyPressed(.ESCAPE) {
    reset()
  }

  key := rl.GetCharPressed()

  if key != 0 {
    clear_board()

    active_key = key
    append(&command, key)

    // set available
    if index := strings.index_rune(PIECES, command[0]); index >= 0 {
      piece_number = i32(index + 1)

      for cols, row in board {
        for cell, col in cols {
          if cell == piece_number {

            if len(command) > 1 {
              if letter_index := strings.index_rune(LETTERS, command[1]); letter_index >= 0 && letter_index != col {
                continue
              }

            }

            set_cell_status(row - 1, col, 0, AVAILABLE)
            set_cell_status(row - 2, col, 0, AVAILABLE)
          }
        }
      }
    }

    // move piece
    if len(command) == 3 {
      row := strings.index_rune(NUMBERS, command[2])
      col := strings.index_rune(LETTERS, command[1])

      set_cell_status(row, col, AVAILABLE, 1)
      set_cell_status(row + 1, col, 1, 0)
      set_cell_status(row + 2, col, 1, 0)

      reset()
    }

  }
}

draw :: proc() {
  rl.BeginDrawing()
  rl.ClearBackground(rl.BLACK)

  rl.DrawText(rl.TextFormat("%c", active_key), (rl.GetScreenWidth() / 2) - 10, 100, 20, WHITE)
  rl.DrawText(rl.TextFormat("%c", command), (rl.GetScreenWidth() / 2) + 10, 100, 20, WHITE)

  for cols, row in board {
    for cell, col in cols {
      // cords
      x := GAP + i32(col) * SIZE
      y := GAP + i32(row) * SIZE

      // values
      number := NUMBERS[row]
      letter := LETTERS[col]
      is_active := piece_number == cell
      // is_available := rune(letter) == active_key || rune(number) == active_key || cell == AVAILABLE
      is_available := cell == AVAILABLE

      // color
      color_even := col % 2 == 0 ? LIGHT : DARK
      color_odd := col % 2 != 0 ? LIGHT : DARK
      color := row % 2 == 0 ? color_even : color_odd

      rl.DrawRectangle(x, y, SIZE, SIZE, color)

      // highlight active cells
      if is_active {
        rl.DrawRectangle(x, y, SIZE, SIZE, GREEN)
      }

      // highlight available cells
      if is_available {
        rl.DrawCircle(x + SIZE / 2, y + SIZE / 2, SIZE / 7, GRAY)
      }

      // pieces
      if cell > 0 && cell <= 7 {
        rl.DrawText(rl.TextFormat("%c", PIECES[cell - 1]), 35 + x, 35 + y, 50, cell == 7 ? BLACK : WHITE)
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
