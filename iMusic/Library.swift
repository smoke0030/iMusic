//
//  Library.swift
//  iMusic
//
//  Created by Сергей on 25.07.2024.
//

import SwiftUI
import URLImage

struct Library: View {
    
    var tracks = UserDefaults.standard.savedTracks()
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                GeometryReader { geometry in
                    HStack(spacing: 20) {
                        Button(action: {
                            print("12345")
                        }, label: {
                            Image(systemName: "play.fill")
                                .accentColor(Color.init(#colorLiteral(red: 1, green: 0.1719063818, blue: 0.4505617619, alpha: 1))
                                )
                                .frame(width: (geometry.size.width / 2) - 10, height: 50)
                                .background(Color.init(#colorLiteral(red: 0.9638889432, green: 0.9760232568, blue: 0.9758098722, alpha: 1)))
                                .cornerRadius(10)
                        })
                        
                        
                        Button(action: {
                            print("54321")
                        }, label: {
                            Image(systemName: "arrow.2.circlepath")
                                .accentColor(Color.init(red: 1, green: 0.1719063818, blue: 0.4505617619))
                                .frame(width: (geometry.size.width / 2) - 10, height: 50)
                                .background(Color.init(#colorLiteral(red: 0.9638889432, green: 0.9760232568, blue: 0.9758098722, alpha: 1)))
                                .cornerRadius(10)
                        })
                    }
                }
                .padding()
                .frame(height: 50)
                Divider()
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.top)
                
                List(tracks) { track in
                    LibraryCell(cell: track)
                   
                }
            }
            
            
            
            .navigationBarTitle("Library")
        }
        
    }
}

struct LibraryCell: View {
    
    var cell: SearchViewModel.Cell
    
    var body: some View {
        HStack {
            URLImage(URL(string: cell.iconUrlString ?? "")!) { image in
                image
                    .resizable()
                    .frame(width: 60, height: 60)
                    .cornerRadius(2)
            }
            VStack(alignment: .leading) {
                Text("\(cell.trackName)")
                Text("\(cell.artistName)")
            }
        }
    }
}

#Preview {
    Library()
}
