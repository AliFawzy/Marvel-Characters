//
//  CharacterSearchViewController.swift
//  Marvel
//
//  Created by Mac on 11/11/2022.
//  Copyright © 2022 Aly Fawzy. All rights reserved.
//

import UIKit

protocol exitSearchViewProtocol {
    func hideSearchView()
}

class CharacterSearchViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchContainerView: UIView! {
        didSet {
            searchContainerView.layer.cornerRadius = 20
            searchContainerView.clipsToBounds = true
        }
    }
    @IBOutlet weak var charactersTbl: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK: - Variables
    let searchView = UISearchController()
    var arrCharacters: [CharactersDataClassResult] = []
    private var arrFilterCharacters: [CharactersDataClassResult] = []
    var delegate: exitSearchViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showHideNavigationBar(animated: animated)
    }
    
    // MARK: - IBAction
    @IBAction func cancelBtnPressed(_ sender: UIButton) {
        delegate?.hideSearchView()
    }
}

// MARK: - Functions
extension CharacterSearchViewController{
    
    private func showHideNavigationBar(animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupTableView() {
        charactersTbl.register(SearchCharacterTableViewCell.nib,
                               forCellReuseIdentifier: SearchCharacterTableViewCell.identifier)
        if #available(iOS 15.0, *) {
            charactersTbl.sectionHeaderTopPadding = 0
        }
    }
}

// MARK: - UITextFieldDelegate
extension CharacterSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = searchTextField.text, !text.isEmpty {
            arrFilterCharacters = arrCharacters.filter{$0.name!.lowercased().contains(text)}
            charactersTbl.reloadData()
            print(text)
        } else {
            arrFilterCharacters = []
            charactersTbl.reloadData()
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension CharacterSearchViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFilterCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCharacterTableViewCell.identifier,
                                                 for: indexPath as IndexPath) as! SearchCharacterTableViewCell
        cell.selectionStyle = .none
        let character = arrFilterCharacters[indexPath.row]
        let imageUrl = (character.thumbnail?.path ?? "") + "." + (character.thumbnail?.thumbnailExtension ?? "")
        cell.characterImage.setImageWith(stringUrl: imageUrl,placeholder: UIImage(named: "image_not_available"))
        
        // get all ranges of searched substring in character name, then set all ranges with red color
        let ranges = (character.name?.lowercased() ?? "").ranges(of: searchTextField.text?.lowercased() ?? "")
        let mutableAttributedString = NSMutableAttributedString.init(string: character.name ?? "")
        ranges.forEach {
            let startIndex = $0.lowerBound.utf16Offset(in: character.name?.lowercased() ?? "")
            let lenth = $0.upperBound.utf16Offset(in: character.name?.lowercased() ?? "") - $0.lowerBound.utf16Offset(in: character.name?.lowercased() ?? "")
            let range = NSRange(location: startIndex, length: lenth)
            mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: range)
            cell.characterName.attributedText = mutableAttributedString
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CharaterDetailsViewController()
        vc.arrCharacterDetails = arrFilterCharacters[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

