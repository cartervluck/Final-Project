class KonaneGame {
	let blackIsHuman: Bool
	let whiteIsHuman: Bool
	init(blackIsHuman: Bool, whiteIsHuman: Bool) {
		self.blackIsHuman = blackIsHuman
		self.whiteIsHuman = whiteIsHuman
	}

	private var gameState: KonaneGameState

	private var blackInputSource: KonaneMoveInputSource = KonaneMoveInputSourceHuman(isBlack: true)
	private var whiteInputSource: KonaneMoveInputSource = KonaneMoveInputSourceHuman(isBlack: false)

	func play() -> Bool {

		if !blackIsHuman {
			blackInputSource = Davanji_KonaneMoveInputSourceAI(isBlack: true)
		}

		if !whiteIsHuman {
			whiteInputSource = Davanji_KonaneMoveInputSourceAI(isBlack: false)
		}

		gameState.boardSetUp()

		while true {
			//Do the things

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
	}
}

class KonaneGameState {
	let width = 16
	let length = 16
	init(){

	}

	var board = [[KonaneColor]](repeating: [], count: 16) //This created errors, it will make problems if you change width and length

	func boardSetUp() {
		for i in 0 ..< length {
			for n in 0 ..< width/2 {
				board[i].append(KonaneColor.black)
				board[i].append(KonaneColor.white)
			}
		}
	}

	private var isBlackTurn: Bool = true

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

	func perform(move: KonaneMove) {
		//move
	}

	func perform(blackRemove: (x: Int, y: Int)) {
		//remove
	}

	func perform(whiteRemove: (x: Int, y: Int)) {
		//remove
	}

	func didBlackWin() -> Bool {
		//check if black won
		return true
	}

	func didWhiteWin() -> Bool {
		//check if black won
		return true
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