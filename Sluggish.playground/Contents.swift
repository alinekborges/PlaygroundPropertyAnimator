//: A ScrollView example on UIViewPropertyAnimator

import UIKit
import PlaygroundSupport


class MyViewController : ScrollViewController, UIScrollViewDelegate {
    
    //Constraints for position X for both balls
    var ball1Constraint: NSLayoutConstraint!
    var ball2Constraint: NSLayoutConstraint!
    
    //label for percentage
    var label: UILabel!
    
    //Array of all my animators with different properties
    var animators: [UIViewPropertyAnimator] = []

    //Creates animators for the balls
    func setupAnimation() {
        
        //This custom curve is responsible for the balls that starts fast
        let animator = UIViewPropertyAnimator(duration: 2,
                controlPoint1: CGPoint(x: 0.2, y:0.8),
                controlPoint2: CGPoint(x: 0.2, y:0.8)) {
            self.ball1Constraint.constant = 100
            self.view.layoutIfNeeded()
        }
        
        //This custom curve is responsible for the balls that starts slow
        let animator2 = UIViewPropertyAnimator(duration: 2,
                controlPoint1: CGPoint(x: 0.8, y:0.2),
                controlPoint2: CGPoint(x: 0.8, y:0.2)) {
            self.ball2Constraint.constant = 100
            self.view.layoutIfNeeded()
        }
        
        //if true, it will convert to linear curve when scrubing
        //as we want that even scrubing they obey the curve, it needs to be set to false
        animator.scrubsLinearly = false
        animator2.scrubsLinearly = false
        
        //add animators to array
        animators.append(animator)
        animators.append(animator2)

    }
    
    //called on every change of scroll view
    //Calculates the elapsed percent of the view that was scrolled
    //and applies it to fractionComplete of all animators
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let percent = scrollView.contentOffset.x / (scrollView.contentSize.width - self.view.frame.width)
        
        animators.forEach { $0.fractionComplete = percent }
        
        label.text = "\(Int(percent * 100)) %"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBalls()
        self.scrollView.delegate = self
    }
    
    var ball2TopConstraint: NSLayoutConstraint!
    
    //create 2 views, one for each ball, and position on screen using constraints (check UIView+Constraints helper file to see how these constraints are created)
    func setupBalls() {
        let ball1 = UIView()
        self.view.addSubview(ball1)
        ball1.pinTop(100)
        ball1.constraintWidth(60)
        ball1.constraintHeight(60)
        ball1Constraint = ball1.centerHorizontally(-100)
        ball1.layer.cornerRadius = 30
        ball1.backgroundColor = .red
        
        let ball2 = UIView()
        self.view.addSubview(ball2)
        ball2TopConstraint = ball2.pinTop(200)
        ball2.constraintWidth(60)
        ball2.constraintHeight(60)
        ball2Constraint = ball2.centerHorizontally(-100)
        ball2.layer.cornerRadius = 30
        ball2.backgroundColor = .black
        
        self.view.layoutIfNeeded()
        
        label = UILabel()
        self.view.addSubview(label)
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.centerHorizontally()
        label.pinBottom(130)
        label.text = "0 %"
        
        pinBalls(ball2, ball1)
    }
    
    //creates a third view that is pinned by constraints to the balls created before. This means that it will go from the slow ball to the fast ball, growing in the difference between them
    func pinBalls(_ ball1: UIView, _ ball2: UIView) {
        let pinnedView = UIView()
        self.view.addSubview(pinnedView)
        pinnedView.backgroundColor = .black
        pinnedView.translatesAutoresizingMaskIntoConstraints = false
        pinnedView.leftAnchor.constraint(equalTo: ball1.leftAnchor)
            .isActive = true
        pinnedView.rightAnchor.constraint(equalTo: ball2.rightAnchor)
            .isActive = true
        pinnedView.topAnchor.constraint(equalTo: ball1.topAnchor)
            .isActive = true
        pinnedView.bottomAnchor.constraint(equalTo: ball1.bottomAnchor)
            .isActive = true
        pinnedView.layer.cornerRadius = 30
        ball2TopConstraint.constant = 100
    }
    
    
}


// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
