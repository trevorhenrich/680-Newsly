//
//  Bookmarks.swift
//  Newsly
//
//  Created by Trevor Henrich on 12/6/23.
//

import SwiftUI

struct Bookmarks: View {
    @Environment(\.openURL) var openURL
    @FetchRequest(sortDescriptors: []) var articles: FetchedResults<ArticleEntity>
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        VStack {
            Text("Bookmarks").frame(maxWidth: .infinity, alignment: .leading).padding([.leading], 15).font(.system(size: 32))
            
            
            List(articles) {article in
                let articleURL = URL(string: article.url ?? "")!
                let urlToImage = URL(string: article.urlToImage ?? "")
                HStack{
                    AsyncImage(url: urlToImage){image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }.onTapGesture {
                        openURL(articleURL)
                    }.frame(minHeight: 100, maxHeight: 100)
                    Text(article.title ?? "error").onTapGesture {
                        openURL(articleURL)
                    }
                    Image(systemName: "bookmark").onTapGesture {
                        moc.delete(article)
                        try? moc.save()
                    }
                }
                
            }
        }
    }
}

#Preview {
    Bookmarks()
}
