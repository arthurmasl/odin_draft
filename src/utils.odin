package main

init_board :: proc() {
  board = [8][8]i32 {
    {7, 7, 7, 7, 7, 7, 7, 7},
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 7, 7, 7, 0, 0},
    {1, 1, 1, 1, 1, 1, 1, 1},
    {2, 3, 4, 5, 6, 4, 3, 2},
  }
}

clear_board :: proc() {
  for cols, row in board {
    for cell, col in cols {
      if cell == AVAILABLE {
        board[row][col] = 0
      }
    }
  }
}

reset :: proc() {
  active_key = 0
  piece_number = -1
  clear(&command)
  clear_board()
}

set_cell_status :: proc(y, x: int, if_status, status: i32) {
  if y < 0 || y >= len(board) do return
  if x < 0 || x >= len(board[y]) do return

  cell := &board[y][x]
  if cell^ == if_status {
    cell^ = status
  }
}
