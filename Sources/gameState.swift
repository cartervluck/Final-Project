class KonaneGameState {
	let width = 16
	let length = 16
	init(){

	}

	var board = [[KonaneColor]](repeating: [], count: 16) //This created errors, it will make problems if you change width and length

	func boardSetUp() {
		for i in 0 ..< length {
			for n in 0 ..< width {
				if (i + n) % 2 == 0 {
					board[i].append(KonaneColor.white)
				} else {
					board[i].append(KonaneColor.black)
				}
			}
		}
	}

	var isBlackTurn: Bool = true

	func getIsBlackTurn() -> Bool {
		return isBlackTurn
	}

	func color(atX: Int, atY: Int) -> KonaneColor {
		return board[atY][atX]
	}

	func isValid(move: KonaneMove) -> Bool {
		if move.toX < 0 {
			print("X value too small")
			return false
		}

		if move.toX > length - 1 {
			print("X value too large")
			return false
		}

		if move.toY < 0 {
			print("Y value too small")
			return false
		}

		if move.toY > width - 1 {
			print("Y value too large")
			return false
		}

		if board[move.toY][move.toX] != KonaneColor.empty {
			//move to square not empty
			print("Moved to an occupied square.")
			return false
		}

		if move.fromX - move.toX != 0 && move.fromY - move.toY != 0 {
			print("move non-linear")
			return false
		}

		if (move.fromX - move.toX) % 2 != 0 {
			print("Did not move an even # of squares on X.")
			return false
		}

		if (move.fromY - move.toY) % 2 != 0 {
			print("Did not move an even # of squares on Y")
			return false
		}

		//This part will check if a move is on the X axis or Y axis, then go through checking if each jump is possible.
		if move.fromX - move.toX > 0 {
			var x = move.fromX - 1
			while x != move.toX {

				if (x - move.fromX) % 2 == 0 {
					if board[move.fromY][x] != KonaneColor.empty {
						print("Hit something when testing to left")
						return false
					}
				} else {
					if board[move.fromY][x] == KonaneColor.empty {
						print("tried to jump over an empty square")
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
						print("Hit something when testing to right")
						return false
					}
				} else {
					if board[move.fromY][x] == KonaneColor.empty {
						print("tried to jump over an empty square")
						return false
					}
				}

				x += 1
			}
		}

		if move.fromY - move.toY > 0 {
			var y = move.fromY - 1
			while y != move.toY {

				if (y - move.fromY) % 2 == 0 {
					if board[y][move.fromX] != KonaneColor.empty {
						print("Hit something when testing up")
						return false
					}
				} else {
					if board[y][move.fromX] == KonaneColor.empty {
						print("tried to jump over an empty square")
						return false
					}
				}

				y -= 1
			}
		}

		if move.fromY - move.toY < 0 {
			var y = move.fromY + 1
			while y != move.toY {

				if (y - move.fromY) % 2 == 0 {
					if board[y][move.fromX] != KonaneColor.empty {
						print("Hit something when testing down")
						return false
					}
				} else {
					if board[y][move.fromX] == KonaneColor.empty {
						print("tried to jump over an empty square")
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
			print("move from square not yours")
			return false
		}

		//if everything else is not false, the move is possible
		return true
	}

	func isValid(blackRemove: (x: Int, y: Int)) -> Bool {
		if board[blackRemove.y][blackRemove.x] != KonaneColor.black {
			return false
		}

		if blackRemove.x == 0 && blackRemove.y == length - 1 {
			//true
		} else if blackRemove.x == (width / 2) - 1 && blackRemove.y == length / 2 {
			//true
		} else if blackRemove.x == (width / 2) && blackRemove.y == (length / 2) - 1 {
			//true
		} else if blackRemove.x == width - 1 && blackRemove.y == 0 {
			//true
		} else {
			print("Not (0,15), (7,8), (8, 7), or (15, 0). \(blackRemove.x), \(blackRemove.y)")
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

		if whiteRemove.x > 0 {
			if board[whiteRemove.y][whiteRemove.x - 1] == KonaneColor.empty {
				return true
			}
		}

		if whiteRemove.x < width - 1 {
			if board[whiteRemove.y][whiteRemove.x + 1] == KonaneColor.empty {
				return true
			}
		}

		if whiteRemove.y > 0 {
			if board[whiteRemove.y - 1][whiteRemove.x] == KonaneColor.empty {
				return true
			}
		}

		if whiteRemove.y < length - 1 {
			if board[whiteRemove.y + 1][whiteRemove.x] == KonaneColor.empty {
				return true
			}
		}

		return false
	}

	func perform(move: KonaneMove) {

		if move.fromY - move.toY < 0 {
			var y = move.fromY + 1
			while y != move.toY {

				board[y][move.fromX] = KonaneColor.empty

				y += 1
			}
			if getIsBlackTurn() {
				board[move.toY][move.toX] = KonaneColor.black
			} else {
				board[move.toY][move.toX] = KonaneColor.white
			}
			board[move.fromY][move.fromX] = KonaneColor.empty
		}

		if move.fromY - move.toY > 0 {
			var y = move.fromY - 1
			while y != move.toY {

				board[y][move.fromX] = KonaneColor.empty

				y -= 1
			}
			if getIsBlackTurn() {
				board[move.toY][move.toX] = KonaneColor.black
			} else {
				board[move.toY][move.toX] = KonaneColor.white
			}
			board[move.fromY][move.fromX] = KonaneColor.empty
		}

		if move.fromX - move.toX < 0 {
			var x = move.fromX + 1
			while x != move.toX {

				board[move.fromY][x] = KonaneColor.empty

				x += 1
			}
			if getIsBlackTurn() {
				board[move.toY][move.toX] = KonaneColor.black
			} else {
				board[move.toY][move.toX] = KonaneColor.white
			}
			board[move.fromY][move.fromX] = KonaneColor.empty
		}

		if move.fromX - move.toX > 0 {
			var x = move.fromX - 1
			while x != move.toX {

				board[move.fromY][x] = KonaneColor.empty

				x -= 1
			}
			if getIsBlackTurn() {
				board[move.toY][move.toX] = KonaneColor.black
			} else {
				board[move.toY][move.toX] = KonaneColor.white
			}
			board[move.fromY][move.fromX] = KonaneColor.empty
		}
	}

	func perform(blackRemove: (x: Int, y: Int)) {
		board[blackRemove.y][blackRemove.x] = KonaneColor.empty
	}

	func perform(whiteRemove: (x: Int, y: Int)) {
		board[whiteRemove.y][whiteRemove.x] = KonaneColor.empty
	}

	func didBlackWin() -> Bool {
		for i in board {
			for n in i {
				//Iterated thru all pieces
				if n == KonaneColor.black {
					//Iterates thru all black pieces
				}
			}
		}
		return false
	}

	func didWhiteWin() -> Bool {
		//check if black won
		return false
	}
}