//
//  Errors.swift
//  Newsly
//
//  Created by Trevor Henrich on 12/7/23.
//

import Foundation

enum articleError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case invalidCategory
}
