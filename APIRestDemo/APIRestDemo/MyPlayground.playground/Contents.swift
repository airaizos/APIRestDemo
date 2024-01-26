import Foundation

let region1 = "Departement de la Loire-Atlantique"
let region2 =  "No uvelle-Aquitaine"


if let first = region2.components(separatedBy: " ").first?.prefix(3) {
    print(first.count < 3 ? "123" : first)
}

