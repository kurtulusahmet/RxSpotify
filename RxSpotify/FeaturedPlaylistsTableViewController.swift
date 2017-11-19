//
//  FeaturedPlaylistsTableViewController.swift
//  RxSpotify
//
//  Created by Kurtulus Ahmet on 16.11.2017.
//  Copyright © 2017 Kurtulus Ahmet. All rights reserved.
//

import UIKit
import RxSwift

class FeaturedPlaylistsTableViewController: UITableViewController {

    private var viewModel = FeaturedPlaylistViewModel()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 77
        
        tableView.dataSource = nil
        
        addTableViewObservable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addTableViewObservable() {
        viewModel.featuredPlaylists.asObservable()
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: "FeaturedPlaylistsTableViewCell", cellType: FeaturedPlaylistsTableViewCell.self)) { (_, model: FeaturedPlaylistModel, cell: FeaturedPlaylistsTableViewCell) in
                    cell.populateView(model)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - Table View
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 20.0 { //20 is the limit to bottom
            print("-------Bottom-------")
            viewModel.loadMore()
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */


}
