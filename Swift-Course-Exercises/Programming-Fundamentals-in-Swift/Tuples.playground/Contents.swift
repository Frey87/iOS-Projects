let credentials = ("", -1111)
if credentials.0 == "" || credentials.1 < 0 {
    print("Invalid credentials!")
}else{
    print("The username is \(credentials.0) and the passcode is \(credentials.1)")
}
let fullCredentials = (password: "pass", passcode: 1111)
if fullCredentials.0 == " " || fullCredentials.passcode < 0 {
    print("Invalid credentials! You can’t log in to the banking app!")
}else{
    print("Valid credentials! You can log in to the banking app!")
    //print("The username is \(fullCredentials.0) and the passcode is \(fullCredentials.1)")
}
