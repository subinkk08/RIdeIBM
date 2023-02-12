//
//  VehicleeListTableViewCell.swift
//  Rides
//
//  Created by Subin Kuriakose on 11/02/23.
//

import UIKit


class VehicleListTableViewCell: UITableViewCell {
    
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var vinLblValue: CellValueLabel!
    @IBOutlet weak var makeAndModelLblValue: CellValueLabel!
    @IBOutlet weak var makeAndModelLblKey: CellKeyLabel!
    
    @IBOutlet weak var vinLblKey: CellKeyLabel!
    
    
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
      
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    
    func setCellItem(item:vechicleListPresentModal){
        self.vinLblKey.text = item.vinKey
        self.vinLblValue.text = item.vin
        self.makeAndModelLblKey.text = item.makeAndModalKey
        self.makeAndModelLblValue.text = item.makeAndModal

        self.selectionStyle = .none
    }
 
    private func initView() {
        // Cell view customization
        backgroundColor = .clear
        // Line separator full width
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero

       
    }
   
    override func prepareForReuse() {
        super.prepareForReuse()
      
        makeAndModelLblKey.text = nil
        makeAndModelLblValue.text = nil
        vinLblKey.text = nil
        vinLblValue.text = nil
    }
}
