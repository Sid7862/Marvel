//
//  CharacterDetailVC.swift
//  Marvel
//
//  Created by Sahibuddin Ahmed on 11/02/22.
//

import UIKit

import Kingfisher

class CharacterDetailViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak private var imageVw : UIImageView!
    @IBOutlet weak private var titleLbl : UILabel!
    @IBOutlet weak private var descriptionLbl : UILabel!
    private let indicator: ActivityIndicator = ActivityIndicator()
    var viewModel: CharacterDetailViewModelProtocol? = nil
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bindViewModel()
        guard let viewModel = viewModel else {
            return
        }
        viewModel.getCharacterDetail()
    }
    
    //MARK: Method
    private func configure() {
        titleLbl.text = "N/A"
        descriptionLbl.text = "N/A"
        imageVw.contentMode = .scaleAspectFill
    }
    private func bindViewModel() {
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.character.bind(to: self) { weakSelf,data in
            weakSelf.titleLbl.text = data?.name
            weakSelf.descriptionLbl.text = data?.description
            weakSelf.imageVw.kf.setImage(
                with: data?.imageURL,
                placeholder: nil,
                options: [
                    .processor(DownsamplingImageProcessor(size:weakSelf.imageVw.frame.size)),
                    .scaleFactor(UIScreen.main.scale),
                    .cacheOriginalImage
                ])
        }.dispose(in: viewModel.disposeBag)
        
        viewModel.isLoading.bind(to: self) { weakSelf,loading  in
            loading ? weakSelf.indicator.showActivityIndicator(uiView: self.view!) :  weakSelf.indicator.hideActivityIndicator(uiView: self.view!)
        }.dispose(in: viewModel.disposeBag)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
