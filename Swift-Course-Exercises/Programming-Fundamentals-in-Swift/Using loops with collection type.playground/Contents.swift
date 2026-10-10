let levelScores = [10, 20, 30, 40, 50, 60, 70]
for (level, score) in levelScores.enumerated(){
    print("The score of level \(level+1) is \(score)")
}
var gameScore = 0
for (level, score) in levelScores.enumerated(){
    gameScore += score
}
print("The final game’s score is \(gameScore)")

let weeklyTemperatures = ["Monday": 70, "Tuesday": 75, "Wednesday": 80, "Thursday": 85, "Friday": 90, "Saturday": 95, "Sunday": 100]

for (day, temperature) in weeklyTemperatures {
    print("The current day is \(day) and temperature is \(temperature)")
}

let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
let temperatures = [70, 75, 80, 85, 90, 95, 100]

for i in 0...6{
    print("The current day is \(days[i]) and temperature is \(temperatures[i])")
}

