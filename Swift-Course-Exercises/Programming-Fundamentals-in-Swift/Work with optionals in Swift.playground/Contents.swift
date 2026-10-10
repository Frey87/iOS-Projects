var password:String! = "1234"
let passcode:Int! = Int(password)
print("The passcode of the app is \(passcode!).")
password = "hello world"
if let code = Int(password) {
    print("The passcode is valid!")
    }else{
        print("Invalid passcode!")
    }
let accessCode:Int?
if let code = Int(password){
    accessCode = code
}else{
    accessCode = 1111
}
print(accessCode!)

let firstPassword = "hello"
let secondPassword = "world"
if let firstCode = Int(firstPassword), let secondCode = Int(secondPassword){
    print(firstCode, secondCode)
}else{
    print("Error: passcode isn’t valid!")
}

let firstAccessCode: Int
let secondAccessCode: Int
if let firstPasscode = Int(firstPassword),
  let secondPasscode =
    Int(secondPassword)
{
  firstAccessCode = firstPasscode
  secondAccessCode = secondPasscode
} else {
  firstAccessCode = 1111
  secondAccessCode = 2222
}
print(
  "The first passcode of the app is \(firstAccessCode) and the second passcode of the app is \(secondAccessCode)."
)

let baby:Float?

