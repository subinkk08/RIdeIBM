//
//  VehicleDetailCollectionViewCell.swift
//  Rides
//
//  Created by Subin Kuriakose on 13/02/23.
// TO DISPLAY VEHICLE DETAILS

import UIKit

class VehicleDetailCollectionViewCell: UICollectionViewCell {
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    // MARK: -  OUTLETS
    @IBOutlet weak var vinKeyLabel: CellKeyLabel!
    @IBOutlet weak var vinValueLabel: CellValueLabel!
    @IBOutlet weak var makeAndModelKeyLabel: CellKeyLabel!
    @IBOutlet weak var makeAndModelValueLabel: CellValueLabel!
    @IBOutlet weak var colorValueLabel: CellValueLabel!
    @IBOutlet weak var colorKeyLabel: CellKeyLabel!
    @IBOutlet weak var carTypeKeyLabel: CellKeyLabel!
    @IBOutlet weak var carTypeValueLabel: CellValueLabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    
    func setCellItem(item:VechicleListPresentModal){
        self.vinKeyLabel.text = item.vinKey
        self.vinValueLabel.text = item.vin
        self.makeAndModelKeyLabel.text = item.makeAndModalKey
        self.makeAndModelValueLabel.text = item.makeAndModal
        self.colorKeyLabel.text = item.colorKey
        self.colorValueLabel.text = item.color
        self.carTypeKeyLabel.text = item.carTypeKey
        self.carTypeValueLabel.text = item.carType
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

enum VehicleDetailPageSection : Int{
    case vehicleDetails = 0
    case emissionDetails = 1
}
