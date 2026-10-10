let freeApp = true
if freeApp == true {print("You are using the free version of the app. Buy the full version of the app to get access to all of its features.")}
let morningTemperature  = 70
let eveningTemperature = 80
if morningTemperature < eveningTemperature {print("The morning temperature is lower than evening temperature")}
else {print("The morning temperature is higher than evening temperature")}
let temperatureDegree = "Farenheit"
if temperatureDegree == "Farenheit" {print("The app uses Farenheit degrees")}
else {print("The app uses Celsius degrees")}
if temperatureDegree == "Farenheit" || temperatureDegree == "Celsius" {print("The app is configured properly.")}
else {print("The app isn’t configured properly.")}
switch temperatureDegree {
    case "Farenheit": print("The app is configured for the US .")
    case "Celsius": print("The app is configured for Europe.")
    default: print("The app has an unknown configuration.")
}
