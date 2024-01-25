//
//  NumberModel.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 17/1/24.
//


import UIKit

struct Number: Codable {
    let contents: Nodo
    
    struct Nodo: Codable {
        let nod: Detail
        
        struct Detail: Codable {
            let numbers: NumberDetail
            
            struct NumberDetail: Codable {
                let number: String
                let bases: BasesDetail
                let numerals: NumeralDetail
                let generalFacts: GeneralFacts
                let primeFacts: PrimeFacts
                let recreational: RecreationalFacts
                
                enum CodingKeys: String, CodingKey {
                    case number, bases, numerals, recreational
                    case generalFacts = "general-facts"
                    case primeFacts = "prime-facts"
                }
                
                struct RecreationalFacts: Codable {
                    let digitssum: Detail
                    
                    struct Detail: Codable {
                        let value: Int
                    }
                }
                
                struct NumeralDetail: Codable {
                    let roman: DetailString
                }
                
                struct GeneralFacts: Codable {
                    let palindrome: DetailBool
                    let triangle: DetailBool
                }
                
                struct PrimeFacts: Codable {
                    let prime: DetailBool
                    let perfect: DetailBool
                    let mersenne: DetailBool
                    let fermat: DetailBool
                    let fibonacci: DetailBool
                }
                
                struct BasesDetail: Codable {
                    let binary: DetailString
                }
                
                struct DetailString: Codable {
                    let value: String
                }
                
                struct DetailBool: Codable {
                    let value: Bool
                }
                
                
            }
        }
    }
    
    var numero: String {
        contents.nod.numbers.number
    }
    var binario: String {
        contents.nod.numbers.bases.binary.value
    }
    
    var romano: NSAttributedString? {
        let cadena = contents.nod.numbers.numerals.roman.value
        do {
            let data = cadena.data(using: .utf8)!
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            
            let attributedString = try NSMutableAttributedString(data: data, options: options, documentAttributes: nil)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .right
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
            let font = UIFont.systemFont(ofSize: 22)
            attributedString.addAttribute(.font, value: font as Any, range: NSRange(location: 0, length: attributedString.length))
            
            return attributedString
        } catch {
            print("Error al convertir HTML a NSAttributedString: \(error)")
            return nil
        }
    }
    
    var palindromo: String {
        contents.nod.numbers.generalFacts.palindrome.value ? "SI" : "NO"
    }
    
    var triangular: String {
        contents.nod.numbers.generalFacts.triangle.value ? "SI" : "NO"
    }
    
    var perfecto: String {
        contents.nod.numbers.primeFacts.perfect.value ? "SI" : "NO"
    }
    var mersenne:String {
        contents.nod.numbers.primeFacts.mersenne.value  ? "SI" : "NO"
    }
    var fermat:String {
        contents.nod.numbers.primeFacts.fermat.value ? "SI" : "NO"
    }
    var fibonacci:String {
        contents.nod.numbers.primeFacts.fibonacci.value ? "SI" : "NO"
    }
    var primo: String {
        contents.nod.numbers.primeFacts.prime.value ? "SI" : "NO"
    }
    var sumDigits:String {
        "\(contents.nod.numbers.recreational.digitssum.value)"
    }
}

extension Number {
    static let empty = Number(contents: Nodo(nod: Nodo.Detail(numbers: Nodo.Detail.NumberDetail(number: "0000", bases: Nodo.Detail.NumberDetail.BasesDetail(binary: Nodo.Detail.NumberDetail.DetailString(value: "")), numerals: Nodo.Detail.NumberDetail.NumeralDetail(roman: Nodo.Detail.NumberDetail.DetailString(value: "")), generalFacts: Nodo.Detail.NumberDetail.GeneralFacts(palindrome: Nodo.Detail.NumberDetail.DetailBool(value: false), triangle: Nodo.Detail.NumberDetail.DetailBool(value: false)), primeFacts: Nodo.Detail.NumberDetail.PrimeFacts(prime: Nodo.Detail.NumberDetail.DetailBool(value: false), perfect: Nodo.Detail.NumberDetail.DetailBool(value: false), mersenne: Nodo.Detail.NumberDetail.DetailBool(value: false), fermat: Nodo.Detail.NumberDetail.DetailBool(value: false), fibonacci: Nodo.Detail.NumberDetail.DetailBool(value: false)), recreational: Nodo.Detail.NumberDetail.RecreationalFacts(digitssum: Nodo.Detail.NumberDetail.RecreationalFacts.Detail(value: 0))))))
}
