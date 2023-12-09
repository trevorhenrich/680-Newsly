//
//  Trending.swift
//  Newsington
//
//  Created by Trevor Henrich on 11/30/23.
//

import SwiftUI

struct Search: View {
    @Environment(\.openURL) var openURL
    @FetchRequest(sortDescriptors: []) var articles: FetchedResults<ArticleEntity>
    @Environment(\.managedObjectContext) var moc
    @State private var articleList: articleList?
    @State private var query: String = "California"
    var body: some View {
        
        NavigationStack {
                Section {
                    Text("Showing results for '\(query)'").frame(maxWidth: .infinity, alignment: .leading).padding([.leading], 15).font(.system(size: 24))
                    HStack{
                        TextField("Search Here", text: $query){}.padding()
                        Image(systemName: "magnifyingglass").padding().onTapGesture {
                            Task{
                                do{
                                    articleList = try await getArticle(query: query)
                                } catch {
                                    print("oopsies!")
                                }
                            }
                            
                        }
                    }
                    
                                    
                    
                    ScrollView{
                        VStack(alignment: .center){
                                ForEach(0..<5, id: \.self) {index in
                                    
                                    let article = articleList?.articles[index]
                                    
                                    if let articleURL: URL = URL(string: article?.url ?? "www.google.com") {
                                        //guard let url = URL(string: endpoint) else {throw articleError.invalidURL}
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
                                                newArticle.url = article?.url ?? "www.google.com"
                                                try? moc.save()
                                            }
                                        }
                                    }
                                }
                            
                        }.task{
                            do{
                                articleList = try await getArticle(query: query)
                            } catch {
                                print("oopsies!")
                            }
                        }
                    }.refreshable {
                        do{
                            articleList = try await getArticle(query: query)
                        } catch {
                            print("oopsies!")
                        }
                    }
                }
            
                
        }
        
        

        }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
