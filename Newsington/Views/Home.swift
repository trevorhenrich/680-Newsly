//
//  Home.swift
//  Newsington
//
//  Created by Trevor Henrich on 11/20/23.
//

import SwiftUI

struct Home: View {
    @Environment(\.openURL) var openURL
    @State private var articleList: articleList?
    
    
    var body: some View {
        
        NavigationStack {
                Section {
                    Text("Trending News").frame(maxWidth: .infinity, alignment: .leading).padding([.leading], 15).font(.system(size: 32))
                    
                    ScrollView{
                        VStack(alignment: .center){
                            //999 is loading/failure to load
                            let articleCount = articleList?.articles?.count ?? 20
                            let range: Range<Int> = 0..<articleCount
                            //let articles = articleList?.articles
                            
                            ForEach(range) {index in
                                let article = articleList?.articles?[index]
                                
                                let articleURL: URL = URL(string: article?.url ?? "www.google.com")!
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
                                Text("By " + author + " for " + sourceName).font(.subheadline).onTapGesture {
                                    openURL(articleURL)
                                }
                                
                                
                            }
                        }.task{
                            do{
                                articleList = try await getTrending()
                            } catch {
                                print("oopsies!")
                            }
                        }
                    }.refreshable {
                        do{
                            articleList = try await getTrending()
                        } catch {
                            print("oopsies!")
                        }
                    }
                }
            
                
        }
        
        

        }
    }


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            
    }
}
