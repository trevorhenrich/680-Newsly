//
//  ArticleView.swift
//  Newsington
//
//  Created by Trevor Henrich on 11/29/23.
//

import SwiftUI

struct ArticleView: View {
    
    @State private var articleList: articleList?
    
    var body: some View {
            VStack{
                let articles = articleList?.articles
                let url = URL(string: articles?[1].urlToImage ?? "")
                
                AsyncImage(url: url){image in
                    image.resizable()
                         } placeholder: {
                             ProgressView()
                         }.frame(minHeight: 200, maxHeight: 300)
                
                    Text((articles?[1].title ?? ".")).lineLimit(3)

                
            }.task{
                await refresh()
        }
        
    }

    func refresh() async -> Void {
        do{
            articleList = try await getArticle()
        } catch {
            print("oopsies!")
        }
    }
}

struct ArticleView_Previews: PreviewProvider {
    
    static var previews: some View {
        ArticleView()
    }
}


