import UIKit

class DetailsViewController: UIViewController {
    
    fileprivate let image: UIImage
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showImage()
    }
    
    func showImage() {
        castView().imageView.alpha = 0
        castView().setImage(image)
      
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.castView().imageView.alpha = 1
        }) 
    }
}

class DetailsView: UIView {
    
    fileprivate let imageView = UIImageView()
    
    init() {
        super.init(frame: CGRect.zero)

        backgroundColor = UIColor.white
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let edgeSize = CGFloat(300)
        imageView.frame = CGRect(x: 0, y: 0, width: edgeSize, height: edgeSize)
        imageView.center = center
    }
    
    func setImage(_ image: UIImage) {
        imageView.image = image
    }
}
