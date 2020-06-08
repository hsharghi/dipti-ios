//
//  Int+Extensions.swift
//  Dipti
//
//  Created by Hadi Sharghi on 6/8/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import Foundation

extension Int {
    
    
    var wordifyFa: String {
        
        var number = self
        // convert negative number to positive and get wordify value
        if (number < 0) {
            number = number * -1;
            return "منفی " + number.wordifyFa
        }
        if (number == 0) {
            return "";
        }
        
        var result = "",
            yekan = ["یک", "دو", "سه", "چهار", "پنج", "شش", "هفت", "هشت", "نه"],
            dahgan = ["بیست", "سی", "چهل", "پنجاه", "شصت", "هفتاد", "هشتاد", "نود"],
            sadgan = ["یکصد", "دویست", "سیصد", "چهارصد", "پانصد", "ششصد", "هفتصد", "هشتصد", "نهصد"],
            dah = ["ده", "یازده", "دوازده", "سیزده", "چهارده", "پانزده", "شانزده", "هفده", "هیجده", "نوزده"];
       
        if (number < 10) {
            result += yekan[number - 1];
        } else if (number < 20) {
            result += dah[number - 10];
        } else if (number < 100) {
            result += dahgan[Int(number / 10) - 2] + (number % 10 > 0 ? " و " : "") + (number % 10).wordifyFa
        } else if (number < 1_000) {
            result += sadgan[Int(number / 100) - 1] + (number % 100 > 0 ? " و " : "") + (number % 100).wordifyFa;
        } else if (number < 1_000_000) {
            result += Int(number / 1000).wordifyFa + " هزار " + (number % 1_000 > 0 ? " و " : "") + (number % 1_000).wordifyFa
        } else if (number < 1_000_000_000) {
            result += Int(number / 1_000_000).wordifyFa + " میلیون " + (number % 1_000_000 > 0 ? " و " : "") + (number % 1_000_000).wordifyFa
        } else if (number < 1_000_000_000_000) {
            result += Int(number / 1_000_000_000).wordifyFa + " میلیارد " + (number % 1_000_000_000 > 0 ? " و " : "") + (number % 1_000_000_000).wordifyFa
        } else if (number < 1_000_000_000_000_000) {
            result += Int(number / 1_000_000_000_000).wordifyFa + " تریلیارد " + (number % 1_000_000_000_000 > 0 ? " و " : "") + (number % 1_000_000_000_000).wordifyFa
        }
        return result;

    }
}

    
    
