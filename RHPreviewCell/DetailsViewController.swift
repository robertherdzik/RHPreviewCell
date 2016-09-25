import UIKit

class DetailsViewController: UIViewController {
    
    private let image: UIImage
    
    init(withImage image: UIImage) {
        self.image = image
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = DetailsView()
    }
    
    func castView() -> DetailsView {
        return view as! DetailsView
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        showImage()
    }
    
    func showImage() {
        castView().imageView.alpha = 0
        castView().setImage(image)
      
        UIView.animateWithDuration(0.2) { [weak self] in
            self?.castView().imageView.alpha = 1
        }
    }
}

class DetailsView: UIView {
    
    private let imageView = UIImageView()
    
    init() {
        super.init(frame: CGRectZero)

        backgroundColor = UIColor.whiteColor()
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let edgeSize = CGFloat(300)
        imageView.frame = CGRectMake(0, 0, edgeSize, edgeSize)
        imageView.center = center
    }
    
    func setImage(image: UIImage) {
        imageView.image = image
    }
}