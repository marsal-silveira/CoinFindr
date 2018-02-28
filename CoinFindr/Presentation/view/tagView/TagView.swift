//
//  TagView.swift
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import Foundation
import UIKit

open class TagView: NibDesignable {
    
    // ************************************************
    // MARK: - Properties
    // ************************************************
    
    public enum CornerType: Int {
        
        case straight
        case rounded
        case circular
        
        fileprivate func value(_ tagView: TagView) -> CGFloat {
            
            switch self {
            case .straight: return 0.0
            case .rounded: return tagView.frame.size.height/3
            case .circular: return tagView.frame.size.height/2
            }
        }
    }

    // ************************************************
    // MARK: - Properties
    // ************************************************

    private var _corner: CornerType = .straight { // Not available in IB, despite `@IBInspectable`
        didSet { self.layer.cornerRadius = _corner.value(self) }
    }
    
    // ************************************************
    // MARK: - @IBOutlets
    // ************************************************
    
    @IBOutlet weak var titleLabel: UILabel!
    
    // ************************************************
    // MARK: - @IBInspectables
    // ************************************************
    
    @IBInspectable var corner: Int {
        get { return _corner.rawValue }
        set { _corner = CornerType(rawValue: newValue) ?? .straight }
    }
    
    @IBInspectable var title: String? {
        didSet { self.titleLabel.text = self.title }
    }
    
    @IBInspectable var titleColor: UIColor = UIColor.customBlue {
        didSet { self.titleLabel.textColor = self.titleColor }
    }
    
    @IBInspectable var border: CGFloat = 0.0 {
        didSet { self.layer.borderWidth = self.border }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet { self.layer.borderColor = self.borderColor.cgColor }
    }
    
    var titleFont: UIFont = UIFont.systemFont(ofSize: 12, weight: .semibold) {
        didSet { self.titleLabel.font = self.titleFont }
    }
    
    //*************************************************
    // MARK: - UIView Lifecycle
    //*************************************************
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    //*************************************************
    // MARK: - Setup
    //*************************************************
    
    private func setupUI() {
        
        self.setupTitle()
    }
    
    private func setupTitle() {

        self.titleLabel.adjustsFontSizeToFitWidth = true
        self.titleLabel.adjustsFontForContentSizeCategory = true
    }
}
