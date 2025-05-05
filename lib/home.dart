import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool gameOver = false;

  void resetGame() {
    setState(() {
      board = List.filled(9, '');
      xTurn = true;
      gameOver = false;
    });
  }

  final List<List<int>> winPatterns = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
    [0, 4, 8], [2, 4, 6], // diagonals
  ];

  String? checkWinner() {
    for (var pattern in winPatterns) {
      String a = board[pattern[0]];
      String b = board[pattern[1]];
      String c = board[pattern[2]];

      if (a != '' && a == b && b == c) {
        return a; // 'X' or 'O'
      }
    }
    return null; // no winner yet
  }

  List<String> board = List.filled(9, '');
  bool xTurn = true;

  void handleTap(int index) {
    if (board[index] == '' && !gameOver) {
      setState(() {
        board[index] = xTurn ? 'X' : 'O';
        xTurn = !xTurn;
      });

      String? winner = checkWinner();
      if (winner != null) {
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: Text('$winner wins!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      resetGame();
                      Navigator.of(context).pop();
                    },
                    child: Text('Play Again'),
                  ),
                ],
              ),
        );
        gameOver = true;
      } else if (!board.contains('')) {
        // it's a draw
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: Text('Draw!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      resetGame();
                      Navigator.of(context).pop();
                    },
                    child: Text('Play Again'),
                  ),
                ],
              ),
        );
        gameOver = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Tic Tac Toe', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => handleTap(index),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: Color.fromARGB(255, 42, 42, 42),
                      borderRadius: BorderRadius.all(Radius.elliptical(15, 15)),
                    ),
                    child: Center(
                      child: Text(
                        board[index],
                        style: TextStyle(fontSize: 48, color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(padding: EdgeInsets.all(20)),
          FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                board = List.filled(9, '');
                xTurn = true;
              });
            },
            label: Text("Reset"),
            icon: Icon(Icons.restore),
          ),
        ],
      ),
    );
  }
}
