import Foundation

let reservationsInPerson: Set = ["000-345-3441", "000-325-3443"]
let reservationsOverPhone: Set = ["000-345-3443", "000-345-5223"]
let reservationsOverInternet: Set = ["000-345-6223", "000-345-7223"]

let inPersonAndOverPhone = reservationsInPerson.union(reservationsOverPhone)
print(inPersonAndOverPhone)

var allPhoneNumbers = inPersonAndOverPhone.union(reservationsOverInternet)
print(allPhoneNumbers)

var confirmationCodes: Set = ["LL3450", "LL3451", "LL3452", "LL3453", "LL3454"]
print("\(allPhoneNumbers.count) \(confirmationCodes.count)")

confirmationCodes.insert("LL3455")
print(confirmationCodes)

confirmationCodes.remove("LL3451")
allPhoneNumbers.remove("000-345-3443")

print("\(allPhoneNumbers.count) \(confirmationCodes.count)")
