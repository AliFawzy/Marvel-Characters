//
//  CharaterDetailsViewController.swift
//  Marvel
//
//  Created by Mac on 10/11/2022.
//  Copyright © 2022 Aly Fawzy. All rights reserved.
//

import UIKit

class CharaterDetailsViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var characterDetailstblView: UITableView!
    @IBOutlet weak var navigateionSubView: UIView! {
        didSet {
            navigateionSubView.layer.roundCorners([.bottomLeft, .bottomRight], radius: 20)
        }
    }
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton! {
        didSet {
            backBtn.layer.roundCorners([.topRight, .bottomRight], radius: 18)
        }
    }
    
    // MARK: - Variables
    var arrCharacterDetails: CharactersDataClassResult?
    var array_ComicsSeriesStoriesEvents:[tempCharacterResources] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCharacterData()
        showTitle()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar(animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateTableViewInsets()
    }
    
    // MARK: - IBActions
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Functions
extension CharaterDetailsViewController {
    
    private func showTitle() {
        if let character = arrCharacterDetails, let name = character.name{
            titleLbl.text = name
        }
    }
    
    private func setupCharacterData() {
        if let character = arrCharacterDetails {
            if let comics = character.comics, let url = comics.collectionURI {
                getCharactersResources(url: url, name: "Comics")
            }
            if let events = character.events, let url = events.collectionURI {
                getCharactersResources(url: url, name: "Events")
            }
            if let stories = character.stories, let url = stories.collectionURI {
                getCharactersResources(url: url, name: "Stories")
            }
            if let series = character.series, let url = series.collectionURI {
                getCharactersResources(url: url, name: "Series")
            }
        }
    }
    
    private func setupTableView() {
        characterDetailstblView.register(CharacterDetailsTableViewCell.nib, forCellReuseIdentifier: CharacterDetailsTableViewCell.identifier)
        characterDetailstblView.register(ComicsSeriesStoriesEventsTblCell.nib, forCellReuseIdentifier: ComicsSeriesStoriesEventsTblCell.identifier)
        if #available(iOS 15.0, *) {
            characterDetailstblView.sectionHeaderTopPadding = 0
        }
    }
    
    private func hideNavigationBar(animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func updateTableViewInsets() {
        characterDetailstblView.contentInset = UIEdgeInsets(top: -50, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - APIs
extension CharaterDetailsViewController {
    
    private func getCharactersResources(url: String, name: String) {
        TopVC.loadingToast()
        BaseAPI.GetCharactersResources(url: url) { status, response, error in
            defer{
                TopVC.dismissToast()
            }
            switch status {
            case 0:
                print("====>  Model Problem")
            case 1:
                guard let response = response, let data = response.data, let result = data.results else {return}
                if result.count > 0{
                    self.array_ComicsSeriesStoriesEvents.append(tempCharacterResources(name: name, items: result))
                }
                DispatchQueue.main.async {
                    self.characterDetailstblView.reloadData()
                }
            case 2:
                guard let error = error else { return }
                print("====>  error \(String(describing: error.code))")
            default :
                print("====>  internetConnection Problem")
            }
        }
    }
}

//MARK:- UITableViewDelegate, UITableViewDataSource
extension CharaterDetailsViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return array_ComicsSeriesStoriesEvents.count + 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
        
        let section = indexPath.section
        if section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: CharacterDetailsTableViewCell.identifier, for: indexPath as IndexPath) as! CharacterDetailsTableViewCell
            cell.selectionStyle = .none
            let imageUrl = (arrCharacterDetails?.thumbnail?.path ?? "") + "." + (arrCharacterDetails?.thumbnail?.thumbnailExtension ?? "")
            cell.characterPosterImage.setImageWith(stringUrl: imageUrl,placeholder: UIImage(named: "image_not_available"))
            cell.characterNameLbl.text = arrCharacterDetails?.name
            if arrCharacterDetails?.resultDescription == "" {
                cell.descView.isHidden = true
            } else {
                cell.descView.isHidden = false
                cell.characterDescValueLbl.text = arrCharacterDetails?.resultDescription
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ComicsSeriesStoriesEventsTblCell.identifier, for: indexPath as IndexPath) as! ComicsSeriesStoriesEventsTblCell
            print("count \(array_ComicsSeriesStoriesEvents.count)")
            cell.titleLbl.text = array_ComicsSeriesStoriesEvents[section-1].name
            cell.arrItems = array_ComicsSeriesStoriesEvents[section-1].items
            cell.ComicsSeriesStoriesEventsCollection.reloadData()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        if section == 0 {
            return UITableView.automaticDimension
        } else {
            return 300
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var y = (characterDetailstblView?.contentOffset.y)!
        if y <= 30 {
            y = 0
        }
        let maxOffsetY = scrollView.contentSize.height - scrollView.frame.size.height
        backBtn.backgroundColor = #colorLiteral(red: 0.07450980392, green: 0.07843137255, blue: 0.07843137255, alpha: 1).withAlphaComponent(y/maxOffsetY)
        navigateionSubView.backgroundColor =  #colorLiteral(red: 0.1058823529, green: 0.1058823529, blue: 0.1098039216, alpha: 1).withAlphaComponent(y/maxOffsetY)
        titleLbl.textColor = UIColor.white.withAlphaComponent(y/maxOffsetY)
    }
}
