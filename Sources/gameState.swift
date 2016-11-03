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
		return board[atY][atX]
	}

	func isValid(move: KonaneMove) -> Bool {
		if move.toX < 0 {
			return false
		}

		if move.toX > length - 1 {
			return false
		}

		if move.toY < 0 {
			return false
		}

		if move.toY > width - 1 {
			return false
		}

		if board[move.toY][move.toX] != KonaneColor.empty {
			//move to square not empty
			return false
		}

		if move.fromX - move.toX != 0 && move.fromY - move.toY != 0 {
			//move non-linear
			return false
		}

		if move.fromX - move.toX % 2 != 0 {
			return false
		}

		if move.fromY - move.toY % 2 != 0 {
			return false
		}

		//This part will check if a move is on the X axis or Y axis, then go through checking if each jump is possible.
		if move.fromX - move.toX > 0 {
			var x = move.fromX - 1
			while x != move.toX {

				if (x - move.fromX) % 2 == 0 {
					if board[move.fromY][x] != KonaneColor.empty {
						return false
					}
				} else {
					if board[move.fromY][x] == KonaneColor.empty {
						return false
					}
				}

				x -= 1
			}
		}

		if move.fromX - move.toX < 0 {
			var x = move.fromX + 1
			while x != move.toX {

				if (x - move.fromX) % 2 == 0 {
					if board[move.fromY][x] != KonaneColor.empty {
						return false
					}
				} else {
					if board[move.fromY][x] == KonaneColor.empty {
						return false
					}
				}

				x += 1
			}
		}

		if move.fromY - move.toY > 0 {
			var y = move.fromX - 1
			while y != move.toY {

				if (y - move.fromY) % 2 == 0 {
					if board[y][move.fromX] != KonaneColor.empty {
						return false
					}
				} else {
					if board[y][move.fromX] == KonaneColor.empty {
						return false
					}
				}

				y -= 1
			}
		}

		if move.fromY - move.toY < 0 {
			var y = move.fromX + 1
			while y != move.toY {

				if (y - move.fromY) % 2 == 0 {
					if board[y][move.fromX] != KonaneColor.empty {
						return false
					}
				} else {
					if board[y][move.fromX] == KonaneColor.empty {
						return false
					}
				}

				y += 1
			}
		}

		if board[move.fromY][move.fromX] == KonaneColor.black && getIsBlackTurn() {
			//true
		} else if board[move.fromY][move.fromX] == KonaneColor.white && !getIsBlackTurn() {
			//true
		} else {
			//move from square not yours
			return false
		}

		//if everything else is not false, the move is possible
		return true
	}

	func isValid(blackRemove: (x: Int, y: Int)) -> Bool {
		if board[blackRemove.y][blackRemove.x] != KonaneColor.black {
			return false
		}

		if blackRemove.x != blackRemove.y {
			return false
		}

		if blackRemove.x != 0 || blackRemove.x != (length/2) - 1 || blackRemove.x != (length/2) || blackRemove.x != length {
			return false
		}

		return true
	}

	func isValid(whiteRemove: (x: Int, y: Int)) -> Bool {
		if whiteRemove.x < 0 {
			return false
		}

		if whiteRemove.x > length - 1 {
			return false
		}

		if whiteRemove.y < 0 {
			return false
		}

		if whiteRemove.y > width - 1 {
			return false
		}

		if board[whiteRemove.y][whiteRemove.x] != KonaneColor.white {
			return false
		}

		if board[whiteRemove.y][whiteRemove.x - 1] == KonaneColor.empty || board[whiteRemove.y][whiteRemove.x + 1] == KonaneColor.empty || board[whiteRemove.y - 1][whiteRemove.x] == KonaneColor.empty || board[whiteRemove.y + 1][whiteRemove.x] == KonaneColor.empty {
			return true
		}

		return false
	}

	func perform(move: KonaneMove) {

		if move.fromY - move.toY < 0 {
			var y = move.fromX + 1
			while y != move.toY {

				board[y][move.fromX] = KonaneColor.empty

				y += 1
			}
		}

		if move.fromY - move.toY > 0 {
			var y = move.fromX - 1
			while y != move.toY {

				board[y][move.fromX] = KonaneColor.empty

				y -= 1
			}
		}

		if move.fromX - move.toX < 0 {
			var x = move.fromX + 1
			while x != move.toX {

				board[move.fromY][x] = KonaneColor.empty

				x += 1
			}
		}

		if move.fromX - move.toX > 0 {
			var x = move.fromX - 1
			while x != move.toX {

				board[move.fromY][x] = KonaneColor.empty

				x -= 1
			}
		}
	}

	func perform(blackRemove: (x: Int, y: Int)) {
		board[blackRemove.y]
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