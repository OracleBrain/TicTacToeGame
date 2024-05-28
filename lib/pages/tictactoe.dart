import 'package:flutter/material.dart';

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  State<TicTacToeGame> createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  late List<List<String>> grid;
  bool isPlayerX = true;
  late String winner;
  late bool gameOver;

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void initializeGame() {
    grid = List.generate(3, (_) => List.generate(3, (_) => ""));
    isPlayerX = true;
    winner = '';
    gameOver = false;
  }

  void onGridTapped(int row, int col) {
    if (!gameOver && grid[row][col] == "") {
      setState(() {
        grid[row][col] = isPlayerX ? "X" : "O";
        checkForWinner(row, col);
        isPlayerX = !isPlayerX;
      });
    }
  }

  void checkForWinner(int row, int col) {

    // Check for a winner in the current row

    if (grid[row][0] == grid[row][1] && grid[row][1] == grid[row][2]) {
      winner = grid[row][0];
      gameOver = true;
      return;
    }

    // Check for a winner in the current column

    if (grid[0][col] == grid[1][col] && grid[1][col] == grid[2][col]) {
      winner = grid[0][col];
      gameOver = true;
      return;
    }

    // Check for a winner in the main diagonal

    if (row == col && grid[0][0] == grid[1][1] && grid[1][1] == grid[2][2]) {
      winner = grid[0][0];
      gameOver = true;
      return;
    }

    // Check for a winner in the secondary diagonal

    if (row + col == 2 && grid[0][2] == grid[1][1] && grid[1][1] == grid[2][0]) {
      winner = grid[0][2];
      gameOver = true;
    }

    // Check for a tie (no empty cells left)

    if (!grid.any((row) => row.contains(""))) {
      gameOver = true;
    }
  }

  void resetGame() {
    setState(() {
      initializeGame();
    });
  }

  Widget buildGrid() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (col) {
            return GestureDetector(
              onTap: () => onGridTapped(row, col),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Center(
                  child: Text(
                    grid[row][col],
                    style: const TextStyle(fontSize: 36),
                  ),
                ),
              ),
            );
          }),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tic Tac Toe",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (winner.isNotEmpty)
            Text(
              "$winner Wins!",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )
          else if (gameOver)
            const Text(
              "It's a Tie!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )
          else
            Text(
              "Player ${isPlayerX ? 'X' : 'O'}'s turn",
              style: const TextStyle(fontSize: 21,fontWeight: FontWeight.bold),
            ),
          const SizedBox(height: 50),
          buildGrid(),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: resetGame,
            child: const Text("Reset Game",style: TextStyle(color: Colors.black,fontSize: 15),),
          ),
        ],
      ),
    );
  }

}
