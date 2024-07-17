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
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    
    
    //awakeFromNib вызывается только когда ячейка конфигурируется через XiB
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // переиспользование ячеек
    override func prepareForReuse() {
        super.prepareForReuse()
        
        trackImageView.image = nil
    }
    
    func set(viewModel: TrackCellViewModel) {
        trackName.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        collectionNameLabel.text = viewModel.collectionName
        
        guard let url = URL(string: viewModel.iconUrlString ?? "") else { return }
        trackImageView.sd_setImage(with: url, completed: nil)
    }
}
