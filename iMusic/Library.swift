//
//  Library.swift
//  iMusic
//
//  Created by Сергей on 25.07.2024.
//

import SwiftUI
import URLImage

struct Library: View {
    
    @State var tracks = UserDefaults.standard.savedTracks()
    @State var showingAlert = false
    @State private var track: SearchViewModel.Cell!
    
    var tabBarDelegate: MainTabBarControllerDelegate?
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                GeometryReader { geometry in
                    HStack(spacing: 20) {
                        Button(action: {
                            self.track = self.tracks[0]
                            self.tabBarDelegate?.maximizeTrackDetailView(view: self.track)
                        }, label: {
                            Image(systemName: "play.fill")
                                .accentColor(Color.init(#colorLiteral(red: 1, green: 0.1719063818, blue: 0.4505617619, alpha: 1))
                                )
                                .frame(width: (geometry.size.width / 2) - 10, height: 50)
                                .background(Color.init(#colorLiteral(red: 0.9638889432, green: 0.9760232568, blue: 0.9758098722, alpha: 1)))
                                .cornerRadius(10)
                        })
                        
                        Button(action: {
                            self.tracks = UserDefaults.standard.savedTracks()
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
                
                List {
                    ForEach(tracks) { track in
                        LibraryCell(cell: track)
                            .gesture(LongPressGesture()
                                .onEnded{ _ in
                                    print("Pressed")
                                    self.track = track
                                    self.showingAlert = true
                                }
                                .simultaneously(with: TapGesture()
                                    .onEnded{ _ in
                                        let keyWindow = UIApplication.shared.connectedScenes
                                            .filter { $0.activationState == .foregroundActive }
                                            .map({ $0 as? UIWindowScene })
                                            .compactMap{ $0 }.first?.windows
                                            .filter({ $0.isKeyWindow }).first
                                        
                                        let tabBarVC = keyWindow?.rootViewController as? MainTabBarController
                                        tabBarVC?.trackDetailView.delegate = self
                                        self.track = track
                                        self.tabBarDelegate?.maximizeTrackDetailView(view: self.track)
                                    }))
                    }.onDelete(perform: delete)
                }
                
            }.actionSheet(isPresented: $showingAlert, content: {
                ActionSheet(title: Text("Are you sure want delete this track?"), buttons: [
                    .destructive(Text("Delete"), action: {
                        print("Deleting:", self.track.trackName)
                        self.delete(track: self.track)
                    }), .cancel()
                ])
            })
            
            .navigationBarTitle("Library")
        }
        
    }
    
    func delete(at offsets: IndexSet) {
        tracks.remove(atOffsets: offsets)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.setValue(savedData, forKey: UserDefaults.favouriteTrackKey)
        }
    }
    
    func delete(track: SearchViewModel.Cell ) {
        let index = self.tracks.firstIndex(of: track)
        guard let myIndex = index else { return }
        tracks.remove(at: myIndex)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.setValue(savedData, forKey: UserDefaults.favouriteTrackKey)
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


extension Library: TrackMovingDelegate {
    func moveBackForTrack() -> SearchViewModel.Cell? {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return nil }
        var nextTrack: SearchViewModel.Cell
        if myIndex - 1 == -1  {
            nextTrack = tracks[tracks.count - 1]
        } else {
            nextTrack = tracks[myIndex - 1]
        }
        
        self.track = nextTrack
        return nextTrack
    }
    
    func moveForwardForTrack() -> SearchViewModel.Cell? {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return nil }
        var nextTrack: SearchViewModel.Cell
        if myIndex + 1 == tracks.count {
            nextTrack = tracks[0]
        } else {
            nextTrack = tracks[myIndex + 1]
        }
        
        self.track = nextTrack
        return nextTrack
    }
    
    
}
