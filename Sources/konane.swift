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

	func isValid(move: KonaneMove) -> Bool {
		return false
	}

	func isValid(blackRemove: (x: Int, y: Int)) -> Bool {
		return false
	}

	func isValid(whiteRemove: (x: Int, y: Int)) -> Bool {
		return false
	}

	perform(move: KonaneMove) {
		//move
	}

	perform(blackRemove: (x: Int, y: Int)) {
		//remove
	}

	perform(whiteRemove: (x: Int, y: Int)) {
		//remove
	}

	didBlackWin() -> Bool {
		//check if black won
	}

	didWhiteWin() -> Bool {
		//check if black won
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

class KonaneMoveInputSource {
	isBlack: Bool
	init(isBlack: Bool) {
		self.isBlack = isBlack
	}
	
	func removeFirstPiece(gameState: KonaneGameState) -> (x: Int, y: Int) {
		return ((0, 0))
	}

	func removeSecondPiece(gameState: KonaneGameState) -> (x: Int, y: Int) {
		return ((0, 0))
	}

	func nextMove(gameState: KonaneGameState) -> KonaneMove {
		return KonaneMove(fromX = 0, fromY = 0, toX = 0, toY = 0)
	}
}

class KonaneMoveInputSourceHuman: KonaneMoveInputSource {
	
}

class Davanji_KonaneMoveInputSourceAI: KonaneMoveInputSource {
	
}