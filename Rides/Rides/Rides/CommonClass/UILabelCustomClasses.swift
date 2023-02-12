//
//  UILabelCustomClasses.swift
//  Rides
//
//  Created by Subin Kuriakose on 11/02/23.
//

import Foundation
import UIKit
@IBDesignable class CellKeyLabel: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        config()
    }

    func config() {
        // Setup how you please, e.g. color = UIColor.black
        self.textColor = UIColor(named: "keyUILabel")
        self.font = CommonFontList.tableViewKeyLabelFont
   
    }

}
@IBDesignable class CellValueLabel: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        config()
    }

    func config() {
        // Setup how you please, e.g. color = UIColor.black
        self.textColor = UIColor(named: "valueUILabel")
        self.font = CommonFontList.tableViewValueLabelFont
   
    }

}
@IBDesignable class PageHeaderLabel: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        config()
    }

    func config() {
        // Setup how you please, e.g. color = UIColor.black
        self.textColor = UIColor(named: "PageHeaderLabel")
        self.font = CommonFontList.pageHeaderTitleLabelFont
   
    }

}
