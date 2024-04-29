//
//  HomeVC.swift
//  VideoGamesApp
//
//  Created by Zeynep Özcan on 24.04.2024.
//

import UIKit

class HomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var scrollImagesCV: UICollectionView!
    
    @IBOutlet weak var gamesListVC: UICollectionView!
    @IBOutlet weak var homeSearchBar: UISearchBar!
    
    @IBOutlet weak var controlPages: UIPageControl!
    
    
    var selectedIndex:IndexPath?
    var rowCount: Int = 0
    var downLoadedImageList = [Int:UIImage]()
    
    var filteredGames = [Game?]()
    // Will be true when 3 word entered to searchbar
    var isFiltering: Bool = false
    
   // var gamesToList = [GameResponse]()
    
    var gameRequest = GameRequest()
    var gameDetail: Detail?
    
    var currentPage : Int = 0  {
        didSet {
            controlPages.currentPage = currentPage
        }
    }
    
    var gamesResponse = GameResponse(){
        didSet{
            DispatchQueue.main.async {
                
                // http request for bacground images.
                for result in self.gamesResponse.results{
                    let urlString = result?.backgroundImage
                    
                    self.load(url: URL(string: (urlString)!)! , complete: { image in
                       
                        self.downLoadedImageList[(result?.id)!] = image
                        self.scrollImagesCV.reloadData()
                        self.gamesListVC.reloadData()
                        
                    })
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadGameResult()
        
        scrollImagesCV.delegate = self
        scrollImagesCV.dataSource = self
        

        gamesListVC.delegate = self
        gamesListVC.dataSource = self
      
    }
    
    
    
    func loadGameResult() -> Void {
        
        gameRequest.getGameResponse { gameResult in
    
            switch gameResult {
            case .success(let games):
                self.gamesResponse = games
            case .failure(let err):
                print(err.localizedDescription)
                
            }
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == scrollImagesCV){
            
            if downLoadedImageList.count > 3{
                rowCount = 3
            } else {
                rowCount = downLoadedImageList.count
            }
            return rowCount
        } else {
            
            if isFiltering {
                if filteredGames.count == 0{
                    return 1
                } else {
                    return filteredGames.count
                }
            } else{
                return gamesResponse.results.count
            }
        }
        
    }
    

    
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let game : Game!
        
        if collectionView == scrollImagesCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImagesCollectionViewCell
            
            
            game = gamesResponse.results[indexPath.row]
            
            
            cell.bannerImage.image = downLoadedImageList[(game?.id)!]
            return cell
            
        } else if (collectionView == gamesListVC) {  // gamesListVC
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameListCell", for: indexPath) as! GameListCollectionViewCell
            
            if isFiltering == true {
                scrollImagesCV.isHidden = true
                controlPages.isHidden = true
                if filteredGames.isEmpty == false {
                    game = filteredGames[indexPath.row]
                } else {
                    game = Game(id: 0, name: "No Games Found", released: "", backgroundImage: "", rating: 0, isFavorite: false, description: "")
                    
                    
                }
            } else{
                scrollImagesCV.isHidden = false
                controlPages.isHidden = false
                game = gamesResponse.results[indexPath.row]
            }
            
            cell.gameListImage.image = downLoadedImageList[(game?.id)!]
            cell.gameNameLabel.text = game.name
            cell.ratingLabel.text = String(game.rating!)
            cell.releaseDataLabel.text = game.released
            
            if game.rating! == 0 {
                cell.ratingLabel.text = ""
            }
            if indexPath == selectedIndex {

                loadGameDetail(game.id!)
                
            }
            
            return cell
            
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImagesCollectionViewCell
        
        return cell
        
    }
    
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath
        collectionView.reloadData()
        
        
        
    }
    
    func loadGameDetail(_ gameId: Int) {
        let detailGameRequest = GameDetailRequest(gameid: gameId)
        detailGameRequest.getDetailResponse { result in
            switch result {
            case .success(let gameDetail):
                self.gameDetail = gameDetail
                DispatchQueue.main.async {
                    guard let detailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else { return }
                    detailsVC.gameDetail = gameDetail  // argument passing
                    
                    /*
                    let backItem = UIBarButtonItem()
                    backItem.title = "Back"
                    self.navigationItem.backBarButtonItem = backItem
                    backItem.tintColor = UIColor.white
                     */
                    self.navigationController?.pushViewController(detailsVC, animated: true)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty == false && searchText.count >= 3 {
            
            filteredGames = gamesResponse.results.filter({ (game: Game?) -> Bool in
                return game?.name?.lowercased().contains(searchText.lowercased()) ?? false
            })
            isFiltering = true
            gamesListVC.reloadData()
        }else {
            isFiltering = false
            gamesListVC.reloadData()
        }
    }
    

}
extension HomeVC {
    
    // Helper function for gameResponse to http request.
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


