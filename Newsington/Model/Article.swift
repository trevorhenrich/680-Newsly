//
//  Article.swift
//  Newsington
//
//  Created by Trevor Henrich on 11/29/23.
//

import Foundation

struct articleList: Codable  {
    let articles: [Article]?
    let totalResults: Int
}

struct Article: Codable  {
    let source: Source
    let title: String
    let author: String?
    let description: String?
    let urlToImage: String?
    let url: String
}

struct Source: Codable {
    var name: String
}

func getArticle(query: String) async throws -> articleList {
    let endpoint = "https://newsapi.org/v2/everything?q=\(query)&apiKey=0600289df6944ba2a9410f1e170ed7c3"
    
    
    guard let url = URL(string: endpoint) else {throw articleError.invalidURL}
    
    
    //get data from API
    let (data, response) = try await URLSession.shared.data(from: url)
    
    //check response for status code
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw articleError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(articleList.self, from: data)
    } catch {
        throw articleError.invalidData
    }
}

func getTrending() async throws -> articleList {
    let endpoint = "https://newsapi.org/v2/top-headlines?country=us&apiKey=0600289df6944ba2a9410f1e170ed7c3"

    
    guard let url = URL(string: endpoint) else {throw articleError.invalidURL}
    
    
    //get data from API
    let (data, response) = try await URLSession.shared.data(from: url)
    
    //check response for status code
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw articleError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(articleList.self, from: data)
    } catch {
        throw articleError.invalidData
    }
}





enum articleError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
