import Foundation
import UIKit

open class ScrollViewController : UIViewController {
    
    public var scrollView: UIScrollView!
    public var contentView: UIView!
    public var page1: UIView!
    public var page2: UIView!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        createScrollView()
        setupPages()
    }
    
    override open func loadView() {
        createViews()
    }
    
}

extension ScrollViewController {
    func createViews() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        
    }
    
    func createScrollView() {
        scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        scrollView.pinEdgesToSuperview()
        
        contentView = UIView()
        self.scrollView.addSubview(contentView)
        contentView.pinEdgesToSuperview()
        contentView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 2).isActive = true
        contentView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        
    }
    
    func setupPages() {
        page1 = UIView()
        contentView.addSubview(page1)
        page1.pinLeft()
        page1.pinTop()
        page1.pinBottom()
        page1.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        page2 = UIView()
        contentView.addSubview(page2)
        page2.pinRight()
        page2.pinTop()
        page2.pinBottom()
        page2.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
    }
}
