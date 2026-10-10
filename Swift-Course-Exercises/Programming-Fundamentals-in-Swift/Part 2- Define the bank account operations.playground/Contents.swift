struct BankAccount{
    var debitBalance: Int = 0
    var creditBalance: Int = 0
    let creditLimit: Int = 100
    
    var debitBalanceInfo: String {
        return "Debit balance: $\(debitBalance)"
    }
    
    var availableCredit: Int {
        return creditLimit + creditBalance
    }
    
    var creditBalanceInfo: String {
        return "Available credit: $\(availableCredit)"
    }
    
    mutating func debitDeposit(_ amount: Int){
        debitBalance += amount
        if debitBalance < 0 {
            print("Deposited $\(amount). \(debitBalanceInfo)")
        }
    }
    
    mutating func creditDeposit(_ amount: Int){
        creditBalance += amount
        if creditBalance < 0 {
            print("Credit deposit: $\(amount). \(creditBalanceInfo)")
        }
        if creditBalance == 0 {
            print("Paid off credit balance.")
        }else if creditBalance > 0{
            print("Overpaid credit balance.")
        }
    }
    
    mutating func debitWithdraw(_ amount: Int) {
        if amount > debitBalance{
            print("Insufficient fund to withdraw $\(amount). \(debitBalanceInfo)")
        }else{
            debitBalance -= amount
            print("Debit withdraw: $\(amount). \(debitBalanceInfo)")
        }
    }
    
    mutating func creditWithdraw(_ amount: Int){
        if amount > availableCredit{
            print("Insufficient credit to withdraw $\(amount). \(creditBalanceInfo)")
        }else{
            creditBalance -= amount
            print("Credit withdraw: $\(amount). \(creditBalanceInfo)")
        }
    }
}
var bankAccount = BankAccount()
print(bankAccount.debitBalanceInfo)
bankAccount.debitDeposit(100)
bankAccount.debitWithdraw(20)
bankAccount.debitWithdraw(81)
print(bankAccount.creditBalanceInfo)
bankAccount.creditWithdraw(101)
bankAccount.creditWithdraw(100)
bankAccount.creditDeposit(50)
bankAccount.creditDeposit(50)
bankAccount.creditDeposit(100)
