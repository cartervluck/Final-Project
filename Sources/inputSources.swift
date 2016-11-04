class KonaneMoveInputSource {
	var isBlack: Bool
	init(isBlack: Bool) {
		self.isBlack = isBlack
	}
	
	func removeFirstPiece(gameState: KonaneGameState) -> (x: Int, y: Int) {
		return (0, 0)
	}

	func removeSecondPiece(gameState: KonaneGameState) -> (x: Int, y: Int) {
		return (0, 0)
	}

	func nextMove(gameState: KonaneGameState) -> KonaneMove {
		return KonaneMove(fromX: 0, fromY: 0, toX: 0, toY: 0)
	}
}

class KonaneMoveInputSourceHuman: KonaneMoveInputSource {
	override func removeFirstPiece(gameState: KonaneGameState) -> (x: Int, y: Int) {
		print("X:")
		let x = Int(readLine()!)!
		print("Y:")
		let y = gameState.length - Int(readLine()!)! - 1

		return (x, y)
	}

	override func removeSecondPiece(gameState: KonaneGameState) -> (x: Int, y: Int) {
		print("X:")
		let x = Int(readLine()!)!
		print("Y:")
		let y = gameState.length - Int(readLine()!)! - 1

		return (x, y)
	}

	override func nextMove(gameState: KonaneGameState) -> KonaneMove {
		print("Input the X of the piece you want to move.")
		let fromX = Int(readLine()!)!
		print("Input the Y of the piece you want to move.")
		let fromY = gameState.length - Int(readLine()!)! - 1
		print("Input the X of the space you want to move to.")
		let toX = Int(readLine()!)!
		print("Input the Y of the space you want to move to.")
		let toY = gameState.length - Int(readLine()!)! - 1

		return KonaneMove(fromX: fromX, fromY: fromY, toX: toX, toY: toY)
	}
}

class Davanji_KonaneMoveInputSourceAI: KonaneMoveInputSource {
	//Copy and paste self aware AI here... HAL
}

/*

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

*/