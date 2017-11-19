//
//  Extensions.swift
//  RxSpotify
//
//  Created by Kurtulus Ahmet on 16.11.2017.
//  Copyright © 2017 Kurtulus Ahmet. All rights reserved.
//

import Foundation

public enum CustomError: Error {
    case notFoundUserDefaultError
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notFoundUserDefaultError:
            return NSLocalizedString("User Default value not found", comment: "")
        }
    }
}
