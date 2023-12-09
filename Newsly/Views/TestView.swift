//
//  TestView.swift
//  Newsington
//
//  Created by Trevor Henrich on 11/16/23.
//

import SwiftUI

struct TestView: View {
    @State var category: Category = .Technology
    @Environment(\.openURL) var openURL
    @State private var articleList: articleList?
    @FetchRequest(sortDescriptors: []) var articles: FetchedResults<ArticleEntity>
    @Environment(\.managedObjectContext) var moc
    
    
    var body: some View {
        NavigationStack{
            Section {
                VStack{
                    Text("Category").frame(maxWidth: .infinity, alignment: .leading).padding([.leading], 15).font(.system(size: 32))
                    
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(Category.allCases, id:\.self){ categories in
                                Text(categories.rawValue).onTapGesture{
                                    category = categories
                                    refreshCategory()
                                    print("Debug: " + category.rawValue)
                                }
                            
                            }
                        }
                    }
                }

                
                ScrollView(.vertical){
                    VStack(alignment: .center){
      
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
                        

                    }.task{
                        await refreshArticles()
                       
                    }
                }.refreshable {
                    await refreshArticles()
                }
            }        }
    }
    
    func refreshArticles() async {
        do{
            articleList = try await getTrending()
        } catch {
            print("oopsies!")
        }
    }
    
    func refreshCategory() {
        Task {
            articleList = try await getCategories(category: category.rawValue)
        }
    }

    
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
