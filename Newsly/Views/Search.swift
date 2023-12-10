//
//  Trending.swift
//  Newsington
//
//  Created by Trevor Henrich on 11/20/23.
//

import SwiftUI

struct Search: View {
    @Environment(\.openURL) var openURL
    @FetchRequest(sortDescriptors: []) var articles: FetchedResults<ArticleEntity>
    @Environment(\.managedObjectContext) var moc
    @State private var articleList: articleList?
    @State private var query: String = "San Francisco"
    var body: some View {
        
        NavigationStack {
                Section {
                    Text("Showing results for '\(query)'").frame(maxWidth: .infinity, alignment: .leading).padding([.leading], 15).font(.system(size: 24))
                    HStack{
                        TextField("Search Here", text: $query){}.padding()
                        Image(systemName: "magnifyingglass").padding().onTapGesture {
                            Task{
                                await refreshArticles()
                            }
                            
                        }
                    }
                    
                                    
                    
                    ScrollView{
                        VStack(alignment: .center){
                            ForEach(0..<5, id: \.self) {index in
                                
                                let article = articleList?.articles[index]
                                if let urlString = article?.url{
                                    if let articleURL: URL = URL(string: article?.url ?? "www.google.com") {
                                        let title = (article?.title ?? "titlePlaceholder")
                                        let sourceName = (article?.source.name ?? "")
                                        let urlToImage = URL(string: article?.urlToImage ?? "")
                                        let author = (article?.author ?? "")
                                        
                                        AsyncImage(url: urlToImage){image in
                                            image.resizable()
                                        } placeholder: {
                                            ProgressView()
                                        }.onTapGesture {
                                            openURL(articleURL)
                                        }.frame(minHeight: 200, maxHeight: 250)
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
                                                newArticle.url = urlString
                                                try? moc.save()
                                            }
                                        }
                                    }
                                }
                            }
                            
                        }.task{
                            await refreshArticles()
                        }
                    }.refreshable {
                        await refreshArticles()
                    }
                }
            
                
        }
        
        

        }
    func refreshArticles() async {
        do{
            articleList = try await getArticle(query: query)
        } catch {
            print("Try Await in Search View Refresh Article func")
        }
    }
    
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
