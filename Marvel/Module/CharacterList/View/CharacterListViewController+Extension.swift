//
//  CharacterListVC+Extension.swift
//  Marvel
//
//  Created by Sahibuddin Ahmed on 11/02/22.
//

import UIKit

extension CharacterListViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    //MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCVwCell", for: indexPath) as! CharacterCVwCell
        cell.prepareCell(with: characters[indexPath.row])
        return cell
        
    }
    
    //MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-40, height: 250)
    }
    
    //MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = CharacterDetailViewModel()
        viewModel.characterID = characters[indexPath.row].identifier
        let characterDetailVC:CharacterDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CharacterDetailViewController") as! CharacterDetailViewController
        characterDetailVC.viewModel = viewModel
        self.present(characterDetailVC, animated: false, completion: nil)
    }
    
    //MARK: UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)){
            print("reach bottom")
            guard let totalPost = viewModel.pageInfo?.total,let offset = viewModel.pageInfo?.offset else {
                return
            }
            if(totalPost != characters.count) {
                viewModel.getAllCharactersWithPagination(withOffset: offset + Int(FetchLimt.twenty.rawValue)!)
            }
        }
        else if (scrollView.contentOffset.y < 0) { }
        else if (scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y < (scrollView.contentSize.height - scrollView.frame.size.height)) {
            print("not top and not bottom")
        }
    }
}
