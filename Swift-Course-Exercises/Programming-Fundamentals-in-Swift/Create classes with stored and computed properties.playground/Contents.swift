class LocalFile{
    let name: String
    let fileExtension: String

    init(name: String, fileExtension: String) {
        self.name = name
        self.fileExtension = fileExtension
    }
    var fullFileName: String {
      return name + fileExtension
    }
}

let file = LocalFile(name: "image", fileExtension: ".png")
print(file.fullFileName)

struct Employee {
  var salary: Double
  var tax = 0.2
  mutating func deductTax() {
    salary = salary - (tax * salary)
  }
}
var emp = Employee(salary: 100)
emp.deductTax()
print(emp.salary)
