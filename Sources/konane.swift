class KonaneGame {
	private var blackInputSource: KonaneMoveInputSource
	private var whiteInputSource: KonaneMoveInputSource
	private var gameState: KonaneGameState = KonaneGameState()

	init(blackIsHuman: Bool, whiteIsHuman: Bool) {

		if !blackIsHuman {
			blackInputSource = Davanji_KonaneMoveInputSourceAI(isBlack: true)
		} else {
			blackInputSource = KonaneMoveInputSourceHuman(isBlack: true)
		}

		if !whiteIsHuman {
			whiteInputSource = Davanji_KonaneMoveInputSourceAI(isBlack: false)
		} else {
			whiteInputSource = KonaneMoveInputSourceHuman(isBlack: false)
		}
	}



	func play() -> Bool {

		gameState.boardSetUp()

		displayBoard()

		var validRemove = false

		while !validRemove {
			print("Black removes first piece.")
			let firstRemove = blackInputSource.removeFirstPiece(gameState: gameState)
			if gameState.isValid(blackRemove: firstRemove) {
				validRemove = true
				gameState.board[firstRemove.y][firstRemove.x] = KonaneColor.empty
			}
		}

		displayBoard()

		validRemove = false
		while !validRemove {
			print("White removes second piece.")
			let secondRemove = whiteInputSource.removeSecondPiece(gameState: gameState)

			if gameState.isValid(whiteRemove: secondRemove) {
				validRemove = true
				gameState.board[secondRemove.y][secondRemove.x] = KonaneColor.empty
			}
		}

		while true {

			print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")

			if gameState.getIsBlackTurn() {
					print("Black's move.")
				} else {
					print("White's move.")
				}

				displayBoard()

			var giveValidMove = false
			while !giveValidMove {

				//check what type it is, ask for move

				var move = KonaneMove(fromX: 0, fromY: 0, toX: 0, toY: 0)

				if gameState.getIsBlackTurn() {
					move = blackInputSource.nextMove(gameState: gameState)
				} else {
					move = whiteInputSource.nextMove(gameState: gameState)
				}
				if gameState.isValid(move: move) {
					gameState.perform(move: move)
					print("Performed.")
					giveValidMove = true
				} else {
					print("Invalid move. Try again.")
				}
			}

			if gameState.didBlackWin() {
				displayBoard()
				return true
			}

			if gameState.didWhiteWin() {
				displayBoard()
				return false
			}
			if gameState.getIsBlackTurn() {
				gameState.isBlackTurn = false
			} else {
				gameState.isBlackTurn = true
			}
		}
	}

	private func displayBoard() {
		var compStr = ""
		for i in 0 ..< gameState.length {
			compStr += String(gameState.length - i - 1)
			if gameState.length - i < 11 {
				compStr += "  "
			} else {
				compStr += " "
			}
			for n in 0 ..< gameState.width {
				if gameState.board[i][n] == KonaneColor.black {
					compStr += "[X] "
				} else if gameState.board[i][n] == KonaneColor.white {
					compStr += "[O] "
				} else {
					compStr += "[-] "
				}
			}
			compStr += "\n"
		}
		compStr += "    "
		for j in 0 ..< gameState.width {
			compStr += String(j)
			if j < 10 {
				compStr += "   "
			} else {
				compStr += "  "
			}
		}
		print(compStr)
	}
}

enum KonaneColor {
	case black, white, empty
}

class KonaneMove {
	let fromX: Int
	let fromY: Int
	let toX: Int
	let toY: Int
	init(fromX: Int, fromY: Int, toX: Int, toY: Int) {
		self.fromX = fromX
		self.fromY = fromY
		self.toX = toX
		self.toY = toY
	}
}

/*

[
[KC KC KC KC KC KC KC KC KC ...]
[KC KC KC KC KC KC KC KC KC ...]
...
]

[[],[],[],[]...]

*/