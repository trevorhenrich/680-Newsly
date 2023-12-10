//
//  Errors.swift
//  Newsly
//
//  Created by Trevor Henrich on 11/20/23.
//

import Foundation

enum articleError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case invalidCategory
}
