//
//  HomeViewController.swift
//  Catstagram
//
//  Created by 김유빈 on 2022/04/06.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
     
    @IBOutlet weak var tableView: UITableView!
    var arrayCat : [FeedModel] = []
    
    let imagePickerViewController = UIImagePickerController() // 카메라 또는 앨범의 뷰컨트롤러
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        let feedNib = UINib(nibName: "FeedTableViewCell", bundle: nil)
        tableView.register(feedNib, forCellReuseIdentifier: "FeedTableViewCell")
        let storyNib = UINib(nibName: "StoryTableViewCell", bundle: nil)
        tableView.register(storyNib, forCellReuseIdentifier: "StoryTableViewCell")
        
        let input = FeedAPIInput(limit: 2, page: 0)
        FeedDataManager().feedDataManager(input, self)
        
        imagePickerViewController.delegate = self
    }
    
    @IBAction func buttonGoAlbum(_ sender: Any) {
        self.imagePickerViewController.sourceType = .photoLibrary // 앨범
        self.present(imagePickerViewController, animated: true, completion: nil)
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCat.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryTableViewCell", for: indexPath) as? StoryTableViewCell else {
                return UITableViewCell()
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as? FeedTableViewCell else {
                return UITableViewCell()
            }
            if let urlString = arrayCat[indexPath.row - 1].url {
                let url = URL(string: urlString)
                cell.imageViewFeed.kf.setImage(with: url)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 80
        } else {
            return 600
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? StoryTableViewCell else {
            return
        }
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
        
    }
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = UICollectionViewCell()
//        cell.backgroundColor = .black
//        return cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCollectionViewCell", for: indexPath) as?
                StoryCollectionViewCell else {
                    return UICollectionViewCell()
                }
        return cell
    }
    
    // CollectionViewCell은 반드시 width와 height를 설정해 주어야 함
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 60)
    }
}

extension HomeViewController {
    func successAPI(_ result : [FeedModel]) {
        arrayCat = result
        tableView.reloadData()
    }
}

extension HomeViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let imageString = "gs://catstargram-d7fbf.appspot.com/Cat" // 저장소위치
            let input = FeedUploadInput(content: "저희 상이입니다. 귀엽지 않나요?", postImgsUrl: [imageString])
            FeedUploadDataManager().posts(self, input)
            
            self.dismiss(animated: true, completion: nil)
        }
    }
}

