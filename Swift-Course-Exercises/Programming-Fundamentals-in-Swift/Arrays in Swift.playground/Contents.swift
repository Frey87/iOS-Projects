var levelScores: [Int] = []
if levelScores.count == 0 {
  print("Start playing the game!")
}
if levelScores.count == 0{
    print("There are no levels in the level scores array yet!")
}
let firstLevelScore = 10
levelScores.append(firstLevelScore)
print("The first level’s score is \(levelScores[0])")
let levelBonusScore = 40
levelScores[0] += levelBonusScore
print("The first level’s score with bonus is \(levelScores[0])")
let freeLevelScores = [20, 30]
levelScores += freeLevelScores
print(levelScores)
let freeLevels = 3
if levelScores.count == freeLevels{
    print("All the free levels have been played: You have to buy the game in order to play its full version.")
    levelScores = []
    print("Game restarted!")
}
