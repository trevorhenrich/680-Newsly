//
//  Article.swift
//  Newsington
//
//  Created by Trevor Henrich on 11/29/23.
//

import Foundation

let apiKey = "0600289df6944ba2a9410f1e170ed7c3"

struct articleList: Codable  {
    let articles: [Article]
    let totalResults: Int

}

struct Source: Codable {
    var name: String?
}

struct Article: Codable  {
    let source: Source
    let title: String
    let url: String
    
    let author: String?
    let description: String?
    let urlToImage: String?
}

enum Category: String, CaseIterable {
    case Business
    case Entertainment
    case General
    case Health
    case Science
    case Sports
    case Technology
}



func getArticle(query: String) async throws -> articleList {
    let endpoint = "https://newsapi.org/v2/everything?q=\(query)&pageSize=5&apiKey=\(apiKey)"
    
    
    guard let url = URL(string: endpoint) else {throw articleError.invalidURL}
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
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
    let endpoint = "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)"

    
    guard let url = URL(string: endpoint) else {throw articleError.invalidURL}
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
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


func getCategories(category: String) async throws -> articleList {
    let endpoint = "https://newsapi.org/v2/top-headlines?country=us&category=\(category)&apiKey=\(apiKey)"

    
    guard let url = URL(string: endpoint) else {throw articleError.invalidURL}
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
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
