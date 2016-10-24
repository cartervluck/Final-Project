class KonaneGame {
	blackIsHuman: Bool
	whiteIsHuman: Bool
	init(blackHuman: Bool, whiteHuman: Bool) {
		blackIsHuman = blackHuman
		whiteIsHuman = whiteHuman
	}
	private gameState: KonaneGameState
}

class KonaneGameState {
	let width = 16
	let length = 16
	init(w: Int, l: Int) {
		width = w
		length = l
	}

	private var board = [[KonaneColor]](repeating: [], count: length)
	for i in 0 ..< length {
		for n in 0 ..< width {
			if n + i % 2 == 0 {
				board[i][n].append(KonaneColor.black)
			} else {
				board[i][n].append(KonaneColor.white)
			}
		}
	}

	private isBlackTurn = true

	func getIsBlackTurn() -> Bool {
		return isBlackTurn
	}

	func color(atX: Int, atY: Int) -> KonaneColor {
		return board[atX][atY]
	}

	func isValid
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

class KonaneMoveInputSource {
	isBlack: Bool
	init(isBlack: Bool) {
		self.isBlack = isBlack
	}
	func removeFirstPiece(gameState: KonaneGameState) -> (x: Int, y: Int)
}