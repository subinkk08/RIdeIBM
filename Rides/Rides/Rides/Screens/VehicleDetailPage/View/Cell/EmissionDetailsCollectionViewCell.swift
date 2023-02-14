//
//  EmissionDetailsCollectionViewCell.swift
//  Rides
//
//  Created by Subin Kuriakose on 14/02/23.
//

import UIKit

class EmissionDetailsCollectionViewCell: UICollectionViewCell {
    
    // MARK: -  OUTLETS
    @IBOutlet weak var emissionKeylabel: UILabel!
    @IBOutlet weak var emissionValueLabel: UILabel!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCellItem(item:VehicleEmissionPresentModal){
        self.emissionKeylabel.text = item.emissionBasedOnKilometerageKey
        self.emissionValueLabel.text = item.emissionBasedOnKilometerageVlaue
      
    }
 
    private func initView() {
        // Cell view customization
        backgroundColor = .clear
        // Line separator full width
        preservesSuperviewLayoutMargins = false
    }
   
    override func prepareForReuse() {
        super.prepareForReuse()
      
    }
}
