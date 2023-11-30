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
            VStack(alignment: .center){
                    //999 is loading/failure to load
                    let articleCount = articleList?.articles?.count ?? 20
                    let range: Range<Int> = 0..<articleCount
                    //let articles = articleList?.articles
                    
                    ForEach(range) {index in
                        let article = articleList?.articles?[index]
                        
                        let title = (article?.title ?? "titlePlaceholder")
                        let sourceName = (article?.source.name ?? "")
                        let url = URL(string: article?.urlToImage ?? "")
                        let author = (article?.author ?? "")
                        
                        AsyncImage(url: url){image in
                            image.resizable()
                                 } placeholder: {
                                     ProgressView()
                                 }.frame(minHeight: 200, maxHeight: 300)
                        Text(title).lineLimit(2).font(.headline)
                        Text("By " + author + " for " + sourceName).font(.subheadline)
                        
                        
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
        Home().listRowInsets(.init(top:0, leading: 0, bottom: 0,trailing: 0))
    }
}
