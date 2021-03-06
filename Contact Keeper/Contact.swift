//
//  Contact.swift
//  Contact Keeper
//
//  Created by LeThiVan.Anh on 30/1/17.
//  Copyright © 2017 Friench. All rights reserved.
//

import UIKit
import Contacts

struct Contact {
    
    var firstName: String?
    var lastName: String?
    var phoneNumber: String?
    var emailAddress: String?
    var homeAddress: Address?
    var image: UIImage?
    
    var fullName: String {
        var name = ""
        if let first = firstName {
            name = first
        }
        if let last = lastName {
            if name == "" {
                name = last
            } else {
                name += " \(last)"
            }
        }
        return name
    }
    
    static func generateContacts() -> [Contact] {
        var firstNames = ["Steve", "Amanda", "Adam", "Jacob", "Violet", "Ivy"]
        var lastNames = ["Beyers", "Dyson", "Jones", "Smith", "Johnson", "Gallagher"]
        var numbers = ["(123) 456-7890", "(098) 765-4321", "(123) 450-9876", "(098) 761-2345", "(543) 216-7890", "(678) 905-4321"]
        var emailAddresses = ["sbeyers", "adyson", "ajones", "jsmith", "vjohnson", "igallagher"].map { "\($0)@gmail.com" }
        var images = [#imageLiteral(resourceName: "steve"), #imageLiteral(resourceName: "amanda"), #imageLiteral(resourceName: "adam"), #imageLiteral(resourceName: "jacob"), #imageLiteral(resourceName: "violet"), #imageLiteral(resourceName: "ivy")]
        let addresses = Address.generateAddresses()
        
        var contacts: [Contact] = []
        for i in 0...5 {
            let contact = Contact(firstName: firstNames[i], lastName: lastNames[i], phoneNumber: numbers[i], emailAddress: emailAddresses[i], homeAddress: addresses[i], image: images[i])
            contacts.append(contact)
        }
        
        return contacts
    }
    
    init(firstName: String?, lastName: String?, phoneNumber: String?, emailAddress: String?, homeAddress: Address?, image: UIImage?) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.emailAddress = emailAddress
        self.homeAddress = homeAddress
        self.image = image
    }
    
    init(contact: CNContact) {
        let first = contact.givenName
        let last = contact.familyName
        let phoneNumber = contact.phoneNumbers.first?.value.stringValue
        let email = contact.emailAddresses.first?.value as String?
        
        var contactAddress: Address?
        if let address = contact.postalAddresses.first?.value {
            let street = address.street
            let city = address.city
            let state = address.state
            let zip = address.postalCode
            
            contactAddress = Address(streetAddress: street, city: city, state: state, zip: zip)
        }
        
        var image: UIImage?
        if let imageData = contact.imageData {
            image = UIImage(data: imageData)
        }
        
        self.init(firstName: first, lastName: last, phoneNumber: phoneNumber, emailAddress: email, homeAddress: contactAddress, image: image)
    }
    
    func cnContact() -> CNMutableContact {
        let contact = CNMutableContact()
        contact.contactType = .person
        contact.givenName = firstName ?? ""
        contact.familyName = lastName ?? ""
        contact.phoneNumbers = [CNLabeledValue(label:CNLabelPhoneNumberiPhone, value:CNPhoneNumber(stringValue:phoneNumber ?? ""))]
        contact.emailAddresses = [CNLabeledValue(label:CNLabelHome, value:(emailAddress ?? "") as NSString)]
        
        return contact
    }
    
}

struct Address {
    
    var streetAddress: String
    var city: String
    var state: String
    var zip: String
    
    static func generateAddresses() -> [Address] {
        var streets = ["123 Front St", "456 Back St", "789 Left St", "987 Right St", "654 High St", "321 Low St"]
        var cities = ["Springfield", "Folsom", "Media", "Philadelphia", "Vienna", "Columbus"]
        var states = ["PA", "NJ", "NY", "OH", "FL", "VA"]
        var zipCodes = ["12345", "23456", "34567", "45678", "56789", "67890"]
        
        var addresses: [Address] = []
        for i in 0...5 {
            let address = Address(streetAddress: streets[i], city: cities[i], state: states[i], zip: zipCodes[i])
            addresses.append(address)
        }
        
        return addresses
    }
    
}
