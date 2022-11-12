//
//  HomeViewController.swift
//  Marvel
//
//  Created by Mac on 08/11/2022.
//  Copyright © 2022 Aly Fawzy. All rights reserved.
//

import UIKit

class CharactersListViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var roundedBottomCornersView: BottomSpecificRoundedCornersUIView!
    @IBOutlet weak var charactersTbl: UITableView!
    @IBOutlet weak var viewFooterHightConstraint: NSLayoutConstraint!
    @IBOutlet weak var loadMoreIndicator: UIActivityIndicatorView!
    @IBOutlet weak var viewFooter: UIView!
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var searchContainerViewLeadingConstraint: NSLayoutConstraint!
    
    
    // MARK: - Variables
    private var totalCharactersCount = 0
    private var paginationOffset = 0
    private var arrCharacters: [CharactersDataClassResult] = []
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideFooterView()
        setupTableView()
        getCharactersAPI(loadMore: false, pullToRefresh: false)
        setupNavigationUI()
        setupRefreshControl()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showHideNavigationBar(animated: animated)
    }
}

// MARK: - Functions
extension CharactersListViewController {
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(self.refreshCharatersDetails(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.white
        charactersTbl.addSubview(refreshControl)
    }
    @objc private func refreshCharatersDetails(_ sender: AnyObject) {
        totalCharactersCount =  0
        arrCharacters = []
        paginationOffset = 0
        charactersTbl.reloadData()
        getCharactersAPI(loadMore: false, pullToRefresh: true)
    }
    private func showHideNavigationBar(animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.isNavigationBarHidden = false
    }
    private func setupTableView() {
        charactersTbl.register(CharactersTableViewCell.nib,
                               forCellReuseIdentifier: CharactersTableViewCell.identifier)
        if #available(iOS 15.0, *) {
            charactersTbl.sectionHeaderTopPadding = 0
        }
    }
    private func setupNavigationUI() {
        let x = (SCREEN_WIDTH/2)-(SCREEN_WIDTH/4)
        let y = (navigationController?.navigationBar.frame.height ?? 96) - 50
        let logo : UIImageView = {
            let img = UIImageView(frame: CGRect.init(x: x,
                                                     y: y,
                                                     width: (SCREEN_WIDTH/2),
                                                     height: 50))
            img.image = UIImage(named: "marvel-studios-logo")
            img.contentMode = .scaleToFill
            return img}()
        let searchBtn : UIButton = {
            let btn = UIButton(frame: CGRect.init(x: 10,
                                                  y: y,
                                                  width: 30,
                                                  height: 30))
            let imageIcon = UIImage(systemName: "magnifyingglass")?.withTintColor(.red, renderingMode: .alwaysOriginal)
            btn.setBackgroundImage(imageIcon, for: .normal)
            btn.addTarget(self, action: #selector(showSearchView), for: .touchUpInside)
            return btn}()
        self.navigationController?.navigationBar.addSubview(searchBtn)
        self.navigationController?.navigationBar.addSubview(logo)
    }
    @objc private func showSearchView() {
        let searchVC = CharacterSearchViewController()
        searchVC.arrCharacters = arrCharacters
        searchVC.delegate = self
        searchVC.modalPresentationStyle = .fullScreen
        searchVC.view.frame = self.searchContainerView.bounds
        self.addChild(searchVC)
        self.searchContainerView.addSubview(searchVC.view)
        searchVC.didMove(toParent: self)
        showHideSearchViewWithAnimation()
    }
    private func showHideSearchViewWithAnimation() {
        if self.searchContainerViewLeadingConstraint.constant == 500 {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveLinear], animations: {
                self.searchContainerViewLeadingConstraint.constant = 0
                self.view.layoutIfNeeded()
            }, completion: nil)
        }else{
            self.showHideNavigationBar(animated: true)
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveLinear], animations: {
                self.searchContainerViewLeadingConstraint.constant = 500
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    private func setFooterView() {
        loadMoreIndicator.startAnimating()
        viewFooterHightConstraint.constant = 20
    }
    private func hideFooterView() {
        loadMoreIndicator.stopAnimating()
        viewFooterHightConstraint.constant = 0
    }
}

// MARK: - APIs
extension CharactersListViewController {
    private func getCharactersAPI(loadMore: Bool, pullToRefresh: Bool) {
        
        if loadMore {
            setFooterView()
        } else {
            if !pullToRefresh {
                TopVC.loadingToast()
            }
        }
     BaseAPI.GetCharactersList(offset: paginationOffset) { [weak self] status, response, error in
         guard let self = self else {return}
            defer {
                if loadMore {
                    self.hideFooterView()
                } else {
                    if pullToRefresh{
                        self.refreshControl.endRefreshing()
                    } else {
                        TopVC.dismissToast()
                    }
                }
            }
            switch status {
            case 0:
                print("====>  Model Problem")
            case 1:
                guard let response = response,
                      let data = response.data,
                      let result = data.results else {return}
                self.totalCharactersCount = data.total ?? 0
                self.arrCharacters.append(contentsOf: result)
                DispatchQueue.main.async {
                    self.charactersTbl.reloadData()
                }
            case 2:
                guard let error = error else {return}
                print("====>  error \(String(describing: error.code))")
            default :
                print("====>  internetConnection Problem")
            }
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension CharactersListViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return arrCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharactersTableViewCell.identifier, for: indexPath as IndexPath) as! CharactersTableViewCell
        cell.selectionStyle = .none
        let imageUrl = (arrCharacters[indexPath.row].thumbnail?.path ?? "") + "." + (arrCharacters[indexPath.row].thumbnail?.thumbnailExtension ?? "")
        cell.characterImage.setImageWith(stringUrl: imageUrl,placeholder: UIImage(named: "image_not_available"))
        cell.characterName.text = arrCharacters[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CharaterDetailsViewController()
        vc.arrCharacterDetails = arrCharacters[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == arrCharacters.count{
            if arrCharacters.count != 0 && arrCharacters.count < totalCharactersCount {
                paginationOffset += 1
                getCharactersAPI(loadMore: true, pullToRefresh: false)
            }
        }
    }
}

extension CharactersListViewController: exitSearchViewProtocol {
    func hideSearchView() {
        for v in searchContainerView.subviews {
            v.removeFromSuperview()
        }
        showHideSearchViewWithAnimation()
    }
}
