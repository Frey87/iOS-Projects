let levelScore = 10
var gameScore = 0
gameScore += levelScore
print("The game score is \(gameScore)")
var levelBonusScore = 10.0
levelBonusScore = 20
print("The level's bonus score is \(levelBonusScore).")
gameScore += Int(levelBonusScore)
print("The game final score is \(30)")
let levelLowerScore = 50
let levelHighestScore = 99
let levels = 10
let levelScoreDifference = levelHighestScore - levelLowerScore
let levelAverageScore = levelScoreDifference / levels
print("The level's average score is \(levelAverageScore).")
let averageLevelScore = Float(levelScoreDifference) / Float(levels)
print("The level's average score is \(averageLevelScore).")
print("The correct level's average score is \(averageLevelScore).")
