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

		/* let firstRemove = blackInputSource.removeFirstPiece(gameState: gameState)

		gameState.board[firstRemove.y][firstRemove.x]

		let secondRemove = whiteInputSource.removeSecondPiece(gameState: gameState)

		gameState.board[secondRemove.y][secondRemove.x] */

		while true {
			if gameState.getIsBlackTurn() {
				print("Black's move.")
			} else {
				print("White's move.")
			}

			displayBoard()

			//check what type it is, ask for move

			var move = KonaneMove(fromX: 0, fromY: 0, toX: 0, toY: 0)

			if gameState.getIsBlackTurn() {
				move = blackInputSource.nextMove(gameState: gameState)
			} else {
				move = whiteInputSource.nextMove(gameState: gameState)
			}

			if gameState.isValid(move: move) {
				gameState.perform(move: move)
			}

			if gameState.didBlackWin() {
				return true
			}

			if gameState.didWhiteWin() {
				return false
			}
		}
	}

	private func displayBoard() {
		var compStr = ""
		for i in 0 ..< gameState.length {
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