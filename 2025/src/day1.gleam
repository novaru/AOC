import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import utils

pub fn solution() {
  let lines = utils.read_lines(1)

  let part1 = solve_part1(lines)
  io.println("Day 1 - Part 1: " <> int.to_string(part1))

  let part2 = solve_part2(lines)
  io.println("Day 1 - Part 2: " <> int.to_string(part2))
}

pub fn solve_part1(lines: List(String)) -> Int {
  lines
  |> list.fold(#(50, 0), fn(state, line) {
    let #(current_dial, count) = state
    case parse_line(line) {
      Ok(value) -> {
        let new_dial = { current_dial + value } % 100
        let new_count = case new_dial == 0 {
          True -> count + 1
          False -> count
        }
        #(new_dial, new_count)
      }
      Error(_) -> state
    }
  })
  |> fn(result) { result.1 }
}

pub fn solve_part2(lines: List(String)) -> Int {
  lines
  |> list.fold(#(50, 0), fn(state, line) {
    let #(current_dial, count) = state
    case parse_line(line) {
      Ok(value) -> {
        let end = current_dial + value
        let new_dial = end % 100
        let crossings = count_zero_crossings(current_dial, end)
        #(new_dial, count + crossings)
      }
      Error(_) -> state
    }
  })
  |> fn(result) { result.1 }
}

fn count_zero_crossings(start: Int, end: Int) -> Int {
  case end > start {
    True -> {
      floor_div(end, 100) - floor_div(start, 100)
    }
    False -> {
      floor_div(start - 1, 100) - floor_div(end - 1, 100)
    }
  }
}

fn floor_div(a: Int, b: Int) -> Int {
  case a >= 0 {
    True -> a / b
    False -> { a - b + 1 } / b
  }
}

fn parse_line(line: String) -> Result(Int, Nil) {
  case string.starts_with(line, "L") {
    True ->
      line
      |> string.drop_start(1)
      |> int.parse()
      |> result.map(fn(n) { -n })
    False ->
      case string.starts_with(line, "R") {
        True ->
          line
          |> string.drop_start(1)
          |> int.parse()
        False -> Error(Nil)
      }
  }
}
