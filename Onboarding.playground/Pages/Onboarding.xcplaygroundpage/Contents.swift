//: An example on how to use UIViewPropertyAnimator to create custom cool transitions between two pages of an ScrollView

import UIKit
import PlaygroundSupport


// ScrollViewController holds the code to create an scroll view with two pages. You can access the code using the left menu
class OnboardingViewController : ScrollViewController, UIScrollViewDelegate {
    
    //variables to hold the pins images
    var venicePin: UIImageView!
    var londonPin: UIImageView!
    var reykjavikPin: UIImageView!
    var stockholmPin: UIImageView!
    var worldView: UIImageView!
    
    //holds the animator so it can be changed on scroll
    var animator: UIViewPropertyAnimator!
    
    //create pages programatically and position pins
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
        createPage1()
        createPage2()
        createAndPositionPins()
        setupAnimator()
        self.view.backgroundColor = #colorLiteral(red: 0.1985152662, green: 0.2425128222, blue: 0.284178257, alpha: 1)
    }
    
    //creates the animator that will controll all view animations
    func setupAnimator() {

        //The property animator is awesome!
        //Like a normal animation, you only need to set the end value of the property you want to change
        //In this part, it is set the final frame position for each of the pins
        animator = UIViewPropertyAnimator(duration: 2, curve: .linear, animations: {
            self.venicePin.frame.origin = CGPoint(x: 86, y: 98)
            self.reykjavikPin.frame.origin = CGPoint(x: 36 ,y: 184)
            self.londonPin.frame.origin = CGPoint(x: 130 ,y: 142)
            self.stockholmPin.frame.origin = CGPoint(x: 90 ,y: 230)
        })
        
        //to add a few more animations, this parts takes care of scaling the pins down
        animator.addAnimations {
            self.venicePin.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
            self.reykjavikPin.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
            self.londonPin.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
            self.stockholmPin.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        }
        
        //and this part, to change the background color
        animator.addAnimations {
            self.view.backgroundColor = .black
        }
        
        //and the world view alpha
        animator.addAnimations {
            self.worldView.alpha = 0.2
        }
        
        
    }
    
    //on every scroll change, this will be called
    //it calculates the percentage of how much of it was scrolled and
    //applies it to the fractionComplete of the animator
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let percent = (scrollView.contentOffset.x / (scrollView.contentSize.width - self.view.frame.width))
        animator.fractionComplete = percent
    }
    
}

extension OnboardingViewController {
    
    //Position the city pins
    func createAndPositionPins() {
        
        venicePin = createPin()
        venicePin.frame.origin = CGPoint(x: 187, y: 547)
        self.view.addSubview(venicePin)
        
        reykjavikPin = createPin()
        reykjavikPin.frame.origin = CGPoint(x: 20, y: 410)
        self.view.addSubview(reykjavikPin)
        
        londonPin = createPin()
        londonPin.frame.origin = CGPoint(x: 90, y: 490)
        self.view.addSubview(londonPin)
        
        stockholmPin = createPin()
        stockholmPin.frame.origin = CGPoint(x: 160, y: 400)
        self.view.addSubview(stockholmPin)
    }
    
    func createPin() -> UIImageView {
        let pin = UIImageView(image: UIImage(named: "gps.png"))
        pin.frame.size = CGSize(width: 37, height: 49)
        return pin
    }
    
}

//Setup Static Views
extension OnboardingViewController {
    func createPage1() {
        
        let worldImage = UIImageView(image: UIImage(named: "World.png"))
        page1.addSubview(worldImage)
        worldImage.centerHorizontally()
        worldImage.pinBottom(-290)
        worldImage.constraintHeight(694)
        worldImage.constraintWidth(716)
        self.worldView = worldImage
        
        //Create Top Labels with default positions ^^
        let topLabel = createLabel(text: "animations")
        page1.addSubview(topLabel)
        topLabel.pinLeft(30)
        topLabel.pinTop(60)
        
        let underLabel = createLabel(text: "under")
        page1.addSubview(underLabel)
        underLabel.pinTop(90)
        underLabel.pinLeft(110)
        
        let controlLabel = createLabel(text: "control", weight: .bold)
        page1.addSubview(controlLabel)
        controlLabel.pinTop(90)
        controlLabel.pinLeft(206)
    }
    
    func createPage2() {
        let veniceLabel = createLabel(text: "VENICE")
        page2.addSubview(veniceLabel)
        veniceLabel.pinTop(100)
        veniceLabel.pinLeft(120)
        
        let londonLabel = createLabel(text: "LONDON")
        page2.addSubview(londonLabel)
        londonLabel.pinTop(144)
        londonLabel.pinLeft(164)
        
        let reykjavikLabel = createLabel(text: "REYKJAVIK")
        page2.addSubview(reykjavikLabel)
        reykjavikLabel.pinTop(186)
        reykjavikLabel.pinLeft(70)
        
        let stockholmLabel = createLabel(text: "STOCKHOLM")
        page2.addSubview(stockholmLabel)
        stockholmLabel.pinTop(232)
        stockholmLabel.pinLeft(122)
    }
    
    func createLabel(text: String, weight: UIFont.Weight = .ultraLight) -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.text = text
        label.font = UIFont.systemFont(ofSize: 38, weight: weight)
        return label
    }
}

PlaygroundPage.current.liveView = OnboardingViewController()


