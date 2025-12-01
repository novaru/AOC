import argv
import gleam/int
import gleam/io
import gleam/list
import gleam/string
import simplifile

import day1

const day_template = "import gleam/int
import gleam/io
import utils

pub fn solution() {{
  // Read input file
  let lines = utils.read_lines({0})
  
  // Part 1
  let part1 = solve_part1(lines)
  io.println(\"Day {0} - Part 1: \" <> int.to_string(part1))
  
  // Part 2
  let part2 = solve_part2(lines)
  io.println(\"Day {0} - Part 2: \" <> int.to_string(part2))
}}

pub fn solve_part1(lines: List(String)) -> Int {{
  // [TODO]: Implement part 1
  0
}}

pub fn solve_part2(lines: List(String)) -> Int {{
  // [TODO]: Implement part 2
  0
}}
"

const input_template = ""

const num_days = 1

pub fn main() {
  // Create missing day files
  list.range(1, num_days)
  |> list.each(fn(day) {
    let src_path = "src/day" <> int.to_string(day) <> ".gleam"
    let input_path = "src/input_day" <> int.to_string(day) <> ".txt"

    case simplifile.is_file(src_path), simplifile.is_file(input_path) {
      Error(_), _ | _, Error(_) -> create_day(day)
      Ok(False), _ | _, Ok(False) -> create_day(day)
      _, _ -> Nil
    }
  })

  io.println("Advent of Code 2025")

  case argv.load().arguments {
    [day_str] -> {
      case int.parse(day_str) {
        Ok(day) if day > 0 && day <= num_days -> {
          run_day(day)
        }
        Ok(day) -> {
          io.println(
            "ERROR: day "
            <> int.to_string(day)
            <> " is not valid (must be 1-"
            <> int.to_string(num_days)
            <> ")",
          )
        }
        Error(_) -> {
          io.println("ERROR: invalid day number")
        }
      }
    }
    _ -> {
      io.println("Usage: gleam run <day>")
      io.println(
        "  day: Day number to run (1-" <> int.to_string(num_days) <> ")",
      )
    }
  }
}

fn create_day(day_number: Int) {
  let src_path = "src/day" <> int.to_string(day_number) <> ".gleam"
  let input_path = "src/input_day" <> int.to_string(day_number) <> ".txt"

  case simplifile.is_file(src_path) {
    Ok(True) -> {
      io.println("Source file already exists: " <> src_path)
    }
    _ -> {
      let src_content =
        string.replace(day_template, "{0}", int.to_string(day_number))
      io.println("Creating source file: " <> src_path)
      let _ = simplifile.write(src_path, src_content)
      Nil
    }
  }

  case simplifile.is_file(input_path) {
    Ok(True) -> {
      io.println("Input file already exists: " <> input_path)
    }
    _ -> {
      io.println("Creating input file: " <> input_path)
      let _ = simplifile.write(input_path, input_template)
      Nil
    }
  }
}

fn run_day(day: Int) {
  case day {
    1 -> day1.solution()
    // Add more days here as you implement them
    // 2 -> day2.day2()
    // 3 -> day3.day3()
    _ -> {
      io.println("Day " <> int.to_string(day) <> " not yet implemented")
      io.println(
        "Implement the solution in src/day" <> int.to_string(day) <> ".gleam",
      )
    }
  }
}
