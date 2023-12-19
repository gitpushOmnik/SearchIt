//
//  SearchForm.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 11/20/23.
//

import Foundation

struct SearchForm {
    var keywords: String = ""
    var categoryType: String = "All"
    var newCondition: Bool = false
    var usedCondition: Bool = false
    var unspecifiedCondition: Bool = false
    var localShipping: Bool = false
    var freeShipping: Bool = false
    var distance: String = ""
    var enterCustomLocation: Bool = false
    var isFormValid: Bool = false
    var currentLocationZipcode: String = "90007"
    var userInputZipcode: String = ""
    var fetchedZipcodes: [String] = []
    var zipcodeFetched: Bool = false
}
