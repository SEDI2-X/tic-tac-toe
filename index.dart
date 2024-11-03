import 'dart:io';
import 'dart:math';

String? input;

int turns = 0;

int currentMode = 0;

int currentPlayer = 0;

int currentSymbol = 0;

List<String> players = [];

List<String> symbols = ["X", "O"];

List<List<String>> grid = [
  ['1', '2', '3'],
  ['4', '5', '6'],
  ['7', '8', '9']
];

List<bool> positionCheaker = [
  true, // 0
  true, // 1
  true, // 2
  true, // 3
  true, // 4
  true, // 5
  true, // 6
  true, // 7
  true // 8
];

String easyMode() {
  while (true) {
    input = (Random().nextInt(8) + 1).toString();
    if (positionCheaker[int.parse(input!) - 1]) {
      positionCheaker[int.parse(input!) - 1] = false;
      return input!;
    }
  }
}

void showGrid() {
  print("===========================");
  print("||   ${grid[0][0]}   |   ${grid[0][1]}   |   ${grid[0][2]}   ||");
  print("||-----------------------||");
  print("||   ${grid[1][0]}   |   ${grid[1][1]}   |   ${grid[1][2]}   ||");
  print("||-----------------------||");
  print("||   ${grid[2][0]}   |   ${grid[2][1]}   |   ${grid[2][2]}   ||");
  print("===========================");
}

void chooseMode() {
  print("Choose Mode: ");
  print("1) P1 Vs P2");
  print("2) P1 Vs Com [Easy]");
  while (true) {
    input = stdin.readLineSync();
    if (input == '1' || input == '2') break;
    print("Invalid Number!!");
  }
  currentMode = int.parse(input!);
  players.addAll(currentMode == 1 ? ["P1", "P2"] : ["P1", "Com"]);
}

void isValid() {
  while (true) {
    if (input != '1' &&
        input != '2' &&
        input != '3' &&
        input != '4' &&
        input != '5' &&
        input != '6' &&
        input != '7' &&
        input != '8' &&
        input != '9') {
      print("Invalid Position!!");
      whoesTurn();
      continue;
    }
    if (!(positionCheaker[int.parse(input!) - 1])) {
      print("No Cheat");
      whoesTurn();
      continue;
    }
    positionCheaker[int.parse(input!) - 1] = false;
    turns++;
    break;
  }
}

void whoesTurn() {
  stdout.write("${players[currentPlayer]} Turn's: ");

  if (players[currentPlayer] == "P1" || players[currentPlayer] == "P2") {
    input = stdin.readLineSync();
    isValid();
  } else if (currentMode == 2)
    stdout.write(easyMode() + '\n');
  else
    print("Hard");
}

void playIn() {
  switch (input) {
    case '1':
      grid[0][0] = symbols[currentSymbol];
      break;
    case '2':
      grid[0][1] = symbols[currentSymbol];
      break;
    case '3':
      grid[0][2] = symbols[currentSymbol];
      break;
    case '4':
      grid[1][0] = symbols[currentSymbol];
      break;
    case '5':
      grid[1][1] = symbols[currentSymbol];
      break;
    case '6':
      grid[1][2] = symbols[currentSymbol];
      break;
    case '7':
      grid[2][0] = symbols[currentSymbol];
      break;
    case '8':
      grid[2][1] = symbols[currentSymbol];
      break;
    case '9':
      grid[2][2] = symbols[currentSymbol];
      break;
  }

  if (!(isWinner())) {
    currentPlayer = (currentPlayer + 1) % 2;
    currentSymbol = (currentSymbol + 1) % 2;
  }
}

bool isWinner() {
  if (grid[0][0] == grid[0][1] && grid[0][0] == grid[0][2] ||
      grid[1][0] == grid[1][1] && grid[1][0] == grid[1][2] ||
      grid[2][0] == grid[2][1] && grid[2][0] == grid[2][2] ||
      grid[0][0] == grid[1][0] && grid[0][0] == grid[2][0] ||
      grid[0][1] == grid[1][1] && grid[0][1] == grid[2][1] ||
      grid[0][2] == grid[1][2] && grid[0][2] == grid[2][2] ||
      grid[0][0] == grid[1][1] && grid[0][0] == grid[2][2] ||
      grid[0][2] == grid[1][1] && grid[0][2] == grid[2][0])
    return true;
  else
    return false;
}

bool isDraw() {
  return turns == 9;
}

void draw() {
  print("==================");
  print("|      Draw      |");
  print("==================");
}

void cup() {
  print("            _________");
  print("          .-\\       /-.");
  print("         |  |       |  |");
  print("          '-|       |-'");
  print("            |       |");
  print("             \\     /");
  print("              \\   /");
  print("              /   \\");
  print("           ===========");
  print("           |    ${players[currentPlayer]}   |");
  print("           ===========");
}

void play() {
  chooseMode();
  while (true) {
    showGrid();
    if (isWinner() || isDraw()) break;
    whoesTurn();
    playIn();
  }
  isWinner() ? cup() : draw();
}

void main() {
  play();
}
