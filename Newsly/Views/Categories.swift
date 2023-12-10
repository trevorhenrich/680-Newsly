//
//  Categories.swift
//  Newsly
//
//  Created by Trevor Henrich on 11/20/23.
//

import SwiftUI

struct Categories: View {
    @State var category: Category = .Technology
    @Environment(\.openURL) var openURL
    @State private var articleList: articleList?
    @FetchRequest(sortDescriptors: []) var articles: FetchedResults<ArticleEntity>
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        
        NavigationStack {
                Section {
                    Text(category.rawValue + " News").frame(maxWidth: .infinity, alignment: .leading).padding([.leading], 15).font(.system(size: 32))


                    ScrollView{
                        VStack(alignment: .center){
                            ScrollView(.horizontal){
                                HStack{
                                    ForEach(Category.allCases, id:\.self){ categories in
                                        Text(categories.rawValue).onTapGesture{
                                            category = categories
                                            refreshCategory()
                                        }
                                    
                                    }
                                }
                            }

          
                                ForEach(0..<10, id: \.self) {index in
                                    let article = articleList?.articles[index]
                                    if let urlString = article?.url{
                                        if let articleURL: URL = URL(string: urlString) {
                                            let title = (article?.title ?? "Title Placeholder")
                                            let sourceName = (article?.source.name ?? "no source")
                                            let urlToImage = URL(string: article?.urlToImage ?? "")
                                            let author = (article?.author ?? "Author Placeholder")
                                            
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
    
    func refreshCategory() {
        Task {
            articleList = try await getCategories(category: category.rawValue)
        }
    }

    
    func refreshArticles() async {
        do{
            articleList = try await getCategories(category: category.rawValue)
        } catch {
            print("Try Await in Category View Refresh Article func")
        }
    }
    
}

#Preview {
    Categories()
}
