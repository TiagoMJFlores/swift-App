import Foundation

struct FormErrors: Equatable {
    var name: ValidationError?
    var email: ValidationError?
    var number: ValidationError?
    var promoCode: ValidationError?
    var deliveryDate: ValidationError?
    var rating: ValidationError?

    var isEmpty: Bool {
        name == nil
            && email == nil
            && number == nil
            && promoCode == nil
            && deliveryDate == nil
            && rating == nil
    }
}
