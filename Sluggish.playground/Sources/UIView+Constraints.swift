import Foundation
import UIKit

extension UIView {
    public func pinEdgesToSuperview() {
        guard let superview = self.superview else {
            return
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        self.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
    }
    
    @discardableResult
    public func centerVertically(_ offset: CGFloat = 0.0) -> NSLayoutConstraint? {
        guard let superview = self.superview else {
            return nil
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: offset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func centerHorizontally(_ offset: CGFloat = 0.0) -> NSLayoutConstraint? {
        guard let superview = self.superview else {
            return nil
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: offset)
        constraint.isActive = true
        return constraint
        
    }
    
    @discardableResult
    public func pinLeft(_ offset: CGFloat = 0.0) -> NSLayoutConstraint? {
        guard let superview = self.superview else {
            return nil
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: offset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func pinRight(_ offset: CGFloat = 0.0) -> NSLayoutConstraint? {
        guard let superview = self.superview else {
            return nil
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -offset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func pinTop(_ offset: CGFloat = 0.0, target: UIView? = nil) -> NSLayoutConstraint? {
        guard let superview = self.superview else {
            return nil
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        var constraint: NSLayoutConstraint?
        
        if let target = target {
            constraint = self.topAnchor.constraint(equalTo: target.bottomAnchor, constant: offset)
        } else {
            constraint = self.topAnchor.constraint(equalTo: superview.topAnchor, constant: offset)
        }
        
        constraint?.isActive = true
        return constraint
    }
    
    @discardableResult
    public func pinBottom(_ offset: CGFloat = 0.0) -> NSLayoutConstraint? {
        guard let superview = self.superview else {
            return nil
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -offset)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func constraintHeight(_ toConstant: CGFloat) -> NSLayoutConstraint? {
        let constraint = self.heightAnchor.constraint(equalToConstant: toConstant)
        self.translatesAutoresizingMaskIntoConstraints = false
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public func constraintWidth(_ toConstant: CGFloat) -> NSLayoutConstraint? {
        let constraint = self.widthAnchor.constraint(equalToConstant: toConstant)
        self.translatesAutoresizingMaskIntoConstraints = false
        constraint.isActive = true
        return constraint
    }
}
