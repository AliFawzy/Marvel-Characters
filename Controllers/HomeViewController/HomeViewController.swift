//
//  HomeViewController.swift
//  Marvel
//
//  Created by Mac on 08/11/2022.
//  Copyright © 2022 Aly Fawzy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var botomRoundedView: BottomSpecificRoundedCornersUIView!
    @IBOutlet weak var charactersTbl: UITableView!
    @IBOutlet weak var viewFooterHightConstraint: NSLayoutConstraint!
    @IBOutlet weak var loadMoreIndicator: UIActivityIndicatorView!
    @IBOutlet weak var viewFooter: UIView!
    
    // MARK: - Variables
    var total = 0
    var offset = 0
    var arrCharacters: [CharactersDataClassResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideFooterView()
        setupTableView()
        getMoviesAPI(loadMore: false)
        setupNavigationUI()
    }
}

// MARK: - Functions
extension HomeViewController{
    
    private func setupTableView() {
        charactersTbl.register(CharactersTableViewCell.nib, forCellReuseIdentifier: CharactersTableViewCell.identifier)
        if #available(iOS 15.0, *) {
            charactersTbl.sectionHeaderTopPadding = 0
        }
    }
    
    func setupNavigationUI(){
        let logo : UIImageView = {
            let x = (SCREEN_WIDTH/2)-(SCREEN_WIDTH/4)
            let y = (navigationController?.navigationBar.frame.height ?? 96) - 50
            let img = UIImageView(frame: CGRect.init(x: x, y: y, width: (SCREEN_WIDTH/2), height: 50))
            img.image = UIImage(named: "marvel-studios-logo")
            img.contentMode = .scaleToFill
            return img}()
        self.navigationController?.navigationBar.addSubview(logo)
    }
    
    func setFooterView() {
        loadMoreIndicator.startAnimating()
        viewFooterHightConstraint.constant = 20
    }
    func hideFooterView() {
        loadMoreIndicator.stopAnimating()
        viewFooterHightConstraint.constant = 0
    }
}

// MARK: - APIs
extension HomeViewController{
    
    func getMoviesAPI(loadMore: Bool) {
        if loadMore{
            setFooterView()
        }else{
            TopVC.loadingToast()
        }
        BaseAPI.GetCharactersList(offset: offset) { status, response, error in
            defer{
                if loadMore{
                    self.hideFooterView()
                }else{
                    TopVC.dismissToast()
                }
            }
            switch status {
            case 0:
                print("====>  Model Problem")
            case 1:
                guard let response = response, let data = response.data, let result = data.results else {return}
                self.total = data.total ?? 0
                
                self.arrCharacters.append(contentsOf: result)
               // self.arrCharacters = result
                DispatchQueue.main.async {
                    self.charactersTbl.reloadData()
                }
            case 2:
                guard let error = error else {return}
                print("====>  error \(String(describing: error.code))")
            default :
                print("====>  internetConnection Problem")
                self.tabBarController?.selectedIndex = 1
            }
        }
    }
}

//MARK:- UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return arrCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell{
            let cell = tableView.dequeueReusableCell(withIdentifier: CharactersTableViewCell.identifier, for: indexPath as IndexPath) as! CharactersTableViewCell
            cell.selectionStyle = .none
            cell.characterImage.setImageWith(stringUrl: (arrCharacters[indexPath.row].thumbnail?.path ?? "") + "." + (arrCharacters[indexPath.row].thumbnail?.thumbnailExtension ?? ""))
            cell.characterName.text = arrCharacters[indexPath.row].name
                return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = MovieDetailsViewController()
//        vc.videoDetails = arrMoviesList[indexPath.row]
//        vc.modalPresentationStyle = .fullScreen
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == arrCharacters.count{
            if arrCharacters.count != 0 && arrCharacters.count < total {
                offset += 1
                getMoviesAPI(loadMore: true)
            }
        }

    }
    
}


