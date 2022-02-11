//
//  CharacterDetailVC.swift
//  Marvel
//
//  Created by Sahibuddin Ahmed on 11/02/22.
//

import UIKit

import Kingfisher

class CharacterDetailVC: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var imageVw : UIImageView!
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var descriptionLbl : UILabel!
    let indicator: ActivityIndicator = ActivityIndicator()
    var viewModel: CharacterDetailVMP?
    
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configure()
        bindViewModel()
        
        guard let viewModel = viewModel else {
            return
        }
        viewModel.getCharacterDetail()
        
    }
    
    
    //MARK: Method
    
    func configure()
    {
        titleLbl.text = "N/A"
        descriptionLbl.text = "N/A"
        imageVw.contentMode = .scaleAspectFill
    }
    
    func bindViewModel()
    {
        guard let viewModel = viewModel else {
            return
        }
        viewModel.character.bind(to: self)
        { weakSelf,data in
            
            weakSelf.titleLbl.text = data?.name
            weakSelf.descriptionLbl.text = data?.description
            if let path = data?.thumbnail?.path, let extention = data?.thumbnail?.imageExtension, let thumbnailUrl = URL(string: path + "." + extention)
            {
                weakSelf.imageVw.kf.setImage(
                    with: thumbnailUrl,
                    placeholder: nil,
                    options: [
                        .processor(DownsamplingImageProcessor(size:weakSelf.imageVw.frame.size)),
                        .scaleFactor(UIScreen.main.scale),
                        .cacheOriginalImage
                    ])
            }
            
            
        }.dispose(in: viewModel.disposeBag)
        
        viewModel.isLoading.bind(to: self)
        {
            weakSelf,loading  in
            
            if(loading)
            {
                
                weakSelf.indicator.showActivityIndicator(uiView: self.view!)
            }
            else{
                weakSelf.indicator.hideActivityIndicator(uiView: self.view!)
            }
        }
        
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
