//
//  DetailVC.swift
//  VideoGamesApp
//
//  Created by Zeynep Özcan on 29.04.2024.
//

import UIKit

class DetailVC: UIViewController {

    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet var detailPoster: UIImageView!
    
    @IBOutlet weak var gameName: UILabel!
    
    @IBOutlet weak var releaseDate: UILabel!
    
    @IBOutlet weak var metacritic: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var descScrollView: UIScrollView!
    
    
    var isLikeButtonClicked: Bool = false
    var gameDetail: Detail?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonImage()
        setLiked()
        initDetails()
        
        // Do any additional setup after loading the view.
    }
    
    func initDetails() {
        self.load(url: URL(string: (gameDetail?.backgroundImage!)!)!, complete: { image in
            self.detailPoster.image = image
        })
        gameName.text = gameDetail?.name
        releaseDate.text = "Released: " + (gameDetail?.released ?? "")
        metacritic.text  = "Metacritic: " + "\(gameDetail?.metacritic ?? 0)"
        descriptionLabel.text = gameDetail?.description
        
    }
    func setLiked(){
        
        switch isLikeButtonClicked {
        case true:
            likeButton.imageView?.image = UIImage(systemName: "hand.thumbsup.fill")
        case false:
            likeButton.imageView?.image = UIImage(systemName: "hand.thumbsup")
        }
    }
        
    @IBAction func didTapBack(_ sender: UIButton)
    {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        vc.modalPresentationStyle = .fullScreen
        //vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isLikeButtonClicked {
            likeButton.setImage(UIImage(named: "hand.thumbsup"), for: .normal)
            
        } else {
            likeButton.setImage(UIImage(named: "hand.thumbsup.fill"), for: .normal)
        }
        
    }
    @IBAction func didTapLike(_ sender: Any) {
        
        isLikeButtonClicked = !isLikeButtonClicked
        setButtonImage()
            if isLikeButtonClicked {
                _ = UIImage(systemName: "hand.thumbsup.fill")
                likeButton.setImage(UIImage(named: "hand.thumbsup.fill"), for: .normal)
                
            } else {
                let image = UIImage(named: "hand.thumbsup")
                likeButton.setImage(image, for: .normal)
            }
       
    }
    func setButtonImage(){
        let imgName = isLikeButtonClicked ? "hand.thumbsup.fill" : "hand.thumbsup"
        _ = UIImage(systemName: "\(imgName)")
        likeButton.setImage(UIImage(named: "\(imgName)"), for: .normal)
    }
    


}


extension DetailVC {
    
    // Helper function for download image via http request.
    func load(url: URL, complete: @escaping (UIImage?) -> Void){
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        complete(image)
                    }
                }
            }
        }
    }
}
