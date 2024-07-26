//
//  TrackCell.swift
//  iMusic
//
//  Created by Сергей on 16.07.2024.
//

import UIKit
import SDWebImage

// протокол для отображения в ячейке. доступны будут только свойства из протокола
protocol TrackCellViewModel {
    var iconUrlString: String? { get }
    var trackName: String { get }
    var artistName: String { get }
    var collectionName: String { get }
}

final class TrackCell: UITableViewCell {
    
    static let identifier = "TrackCell"
    
    var cell: SearchViewModel.Cell?
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var addTrackOutlet: UIButton!
    
    //awakeFromNib вызывается только когда ячейка конфигурируется через XiB
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // переиспользование ячеек
    override func prepareForReuse() {
        super.prepareForReuse()
        
        trackImageView.image = nil
    }
    
    func set(viewModel: SearchViewModel.Cell) {
        
        self.cell = viewModel
        let savedTracks = UserDefaults.standard.savedTracks()
        let hasFavourite = savedTracks.firstIndex {
            $0.trackName == self.cell?.trackName && $0.artistName == self.cell?.artistName
        } != nil
        if  hasFavourite {
            addTrackOutlet.isHidden = true
        } else {
            addTrackOutlet.isHidden = false
        }
        
        trackName.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        collectionNameLabel.text = viewModel.collectionName
        
        guard let url = URL(string: viewModel.iconUrlString ?? "") else { return }
        trackImageView.sd_setImage(with: url, completed: nil)
    }
    
    @IBAction func addTrackAction(_ sender: Any) {
        
        addTrackOutlet.isHidden = true
        let defaults = UserDefaults.standard
        var listOfTracks = defaults.savedTracks()
        guard let cell = cell else { return }
        listOfTracks.append(cell)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: listOfTracks, requiringSecureCoding: false
        ) {
            defaults.set(savedData, forKey: UserDefaults.favouriteTrackKey)
            print("Success")
        }
        
    }
    
    
}
                
