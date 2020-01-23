//
//  UIImage+Extensions.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/23/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import Foundation
import CommonCrypto

extension Data {
    var md5: String {
        let hash = self.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes.baseAddress, CC_LONG(self.count), &hash)
            return hash
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
    
}
