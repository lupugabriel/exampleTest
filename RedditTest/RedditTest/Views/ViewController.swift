//
//  ViewController.swift
//  RedditTest
//
//  Created by Gabriel Lupu on 09.06.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var data: GeneralCharacterInformation?
    var characterResults: [CharacterModel] = []
    var totalPagesNumber: Int = 0
    var currentPageDownloaded: Int = 0
    var nextPage: String?
    let downloadFlag = 4

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if data == nil {
            loadData(page: 0)
        }
    }

    //MARK: - Data
    func loadData(page: Int) {
        if !DataService.isConnectedToInternet {
            let alertController = UIAlertController.init(title: NSLocalizedString("Error", comment:""),
                                                         message: NSLocalizedString("You need an internet connection!", comment:""),
                                                         preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment:""),
                                                    style: UIAlertAction.Style.default,
                                                    handler: nil))
            self.present(alertController, animated:true, completion:nil)

            return
        }

        DataService.shared.getData(page: page) { [weak self] data, error in
            guard let self = self else { return }
            if let data = data {
                self.data = data
                if let infoData = data.info, let characterResults = data.results {
                    self.characterResults.append(contentsOf: characterResults)
                    self.currentPageDownloaded += 1
                    self.totalPagesNumber = infoData.pages ?? 0
                    self.nextPage = infoData.next ?? ""
                    self.collectionView.reloadData()
                }
            } else {
                self.showDownloadAlertWithRetry(page: page)
            }
        }
    }

    func showGenericAlert(_ viewController:UIViewController) {
        let alertController = UIAlertController.init(title: NSLocalizedString("Error", comment:""),
                                                     message: NSLocalizedString("An error occurred!", comment:""),
                                                     preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment:""),
                                                style: UIAlertAction.Style.default,
                                                handler: nil))
        viewController.present(alertController, animated:true, completion:nil)
    }

    func showDownloadAlertWithRetry(page: Int) {
        let alertController = UIAlertController.init(title: NSLocalizedString("Error", comment:""),
                                                     message: NSLocalizedString("Could not download the list of characters", comment:""),
                                                     preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment:""),
                                                style: UIAlertAction.Style.cancel,
                                                handler: nil))
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Retry", comment:""),
                                                style: UIAlertAction.Style.default,
                                                handler:{(alert: UIAlertAction!) in self.loadData(page: page)}))
        self.present(alertController, animated:true, completion:nil)
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int
    {
        return characterResults.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCollectionViewCell
        let model = self.characterResults[indexPath.row]
        cell.data = model

        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView,
                               willDisplay cell: UICollectionViewCell,
                               forItemAt indexPath: IndexPath) {

        if currentPageDownloaded < totalPagesNumber && indexPath.row == (characterResults.count - downloadFlag) {
            loadData(page: currentPageDownloaded + 1)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width / 2, height: self.view.frame.size.width / 2)
    }
}
