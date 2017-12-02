import UIKit
import youtube_ios_player_helper

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    
    @IBOutlet weak var videoCollection : UICollectionView!
    var videos : [Video]?

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeData()
        
    }
    
    func initializeData() {
        self.videos = [Video(key : "xKJmEC5ieOk",
            title : "Official Trailer 1"),
                       Video(key : "FnCdOQsX5kc",
                        title : "Official Teaser Trailer")]
        videoCollection.dataSource = self
        videoCollection.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let videos = self.videos {
            return videos.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let videoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as? VideoCell, let videos = self.videos{
            videoCell.configure(video: videos[indexPath.row])
            return videoCell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width : collectionView.frame.width-2,
                      height : collectionView.frame.height/3-2)
    }
    
    
    
}

