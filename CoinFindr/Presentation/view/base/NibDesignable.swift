import UIKit

/**
 A NibDesignable is a view wrapper tha loads a XIB with the same name of the class and add it to itself.
 You should use mainly in storyboards, to avoid modifying views inside the storyboard
 */
@IBDesignable
open class NibDesignable: UIView {
    
    // MARK: - Initializer
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupNib()
    }
    
    // MARK: - NSCoding
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupNib()
    }
    
    // MARK: - Nib loading
    
    /**
     Called in init(frame:) and init(aDecoder:) to load the nib and add it as a subview.
     */
    internal func setupNib() {
        let view = self.loadNib()
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: bindings))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: bindings))
        viewDidLoad()
    }
    
    open func viewDidLoad() {
        
    }
    
    /**
     Called to load the nib in setupNib().
     
     - returns: UIView instance loaded from a nib file.
     */
    open func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.nibName(), bundle: bundle)
        
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView  else {
            fatalError("You're trying to load a NibDesignable without the respective nib file")
        }
        
        return view
    }
    
    /**
     Called in the default implementation of loadNib(). Default is class name.
     
     - returns: Name of a single view nib file.
     */
    open func nibName() -> String {
        guard let name = type(of: self).description().components(separatedBy: ".").last else {
            fatalError("Invalid module name")
        }
        return name
    }
}
