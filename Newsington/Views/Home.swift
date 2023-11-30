//
//  Home.swift
//  Newsington
//
//  Created by Trevor Henrich on 11/20/23.
//

import SwiftUI

struct Home: View {
    
    @State private var articleList: articleList?
    
    
    var body: some View {
        ScrollView{
                VStack{
                    //999 is loading/failure to load
                    let articleCount = articleList?.articles?.count ?? 20
                    let range: Range<Int> = 0..<articleCount
                    let articles = articleList?.articles
                
                
                    ForEach(range) {index in
                        Text((articles?[index].title ?? "Loading"))
                    }
                        }.task{
                            do{
                                articleList = try await getArticle()
                            } catch {
                                print("oopsies!")
                            }
                    }
        }.refreshable {
            do{
                articleList = try await getArticle()
            } catch {
                print("oopsies!")
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


func getArticle() async throws -> articleList {
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


struct articleList: Codable  {
    var articles: [Article]?
}

struct Article: Codable  {
    var title: String
}

enum articleError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
