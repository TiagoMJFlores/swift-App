import Foundation

struct FormInput: Equatable {
    var name: String = ""
    var email: String = ""
    var number: String = ""
    var promoCode: String = ""
    var deliveryDate: Date = .now
    var rating: Rating?
}
