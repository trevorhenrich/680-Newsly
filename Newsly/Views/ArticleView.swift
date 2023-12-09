//
//  ArticleView.swift
//  Newsly
//
//  Created by Trevor Henrich on 12/7/23.
//

import SwiftUI

struct ArticleView: View {
    @Environment(\.openURL) var openURL
    
    var body: some View {
        ForEach(0..<10, id: \.self) {index in
            let article = articleList?.articles[index]
            if let urlString = article?.url{
                if let articleURL: URL = URL(string: urlString) {
                    //guard let url = URL(string: endpoint) else {throw articleError.invalidURL}
                    let title = (article?.title ?? "Title Placeholder")
                    let sourceName = (article?.source.name ?? "no source")
                    let urlToImage = URL(string: article?.urlToImage ?? "")
                    let author = (article?.author ?? "no author")
                    
                    AsyncImage(url: urlToImage){image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }.onTapGesture {
                        openURL(articleURL)
                    }.frame(minHeight: 200, maxHeight: 300)
                    Text(title).lineLimit(2).font(.headline).onTapGesture {
                        openURL(articleURL)
                    }
                    
                    HStack{
                        
                        Text("By " + author + " for " + sourceName).font(.subheadline).onTapGesture {
                            openURL(articleURL)
                        }
                        
                        Image(systemName: "bookmark").onTapGesture {
                            let newArticle = ArticleEntity(context: moc)
                            newArticle.title = title
                            newArticle.urlToImage = article?.urlToImage ?? ""
                            newArticle.url = article?.url ?? "www.google.com"
                            try? moc.save()
                        }
                    }
                }
            }
            
        }
    }
}

#Preview {
    ArticleView()
}
