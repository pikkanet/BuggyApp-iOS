//
//  SecondViewController.swift
//  BuggyApp
//
//  Created by Teerawat Vanasapdamrong on 28/6/19.
//  Copyright © 2019 scbeasy. All rights reserved.
//

import UIKit

class MusicTracksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tracks: [Track] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        tableView.estimatedRowHeight = CGFloat(140.0)
        
        APIManager.shared.getArtistInfo(artistName: "taylorswift") { [weak self] result in
//            print(result)
            switch result {
            case .success(let tracks):
                self?.tracks = tracks
                self?.tableView.reloadData()
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(dismissAction)
                self?.present(alert, animated: true)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(tableView.indexPathForSelectedRow?.row)
        if segue.identifier == "showDetail",
            let viewController = segue.destination as? MusicTrackDetailViewController,
            let selectedTrack = sender as? Track {
            
            viewController.track = selectedTrack
        }
    }
}

extension MusicTracksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(tracks.count)
        return tracks.isEmpty ? 0 : tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell.CellIdentifier, for: indexPath) as? TrackTableViewCell else {
            return UITableViewCell()
        }
//        print(tracks.count)
        let track: Track = tracks[indexPath.row]
        cell.configCell(track: track)
        return cell
    }
}

extension MusicTracksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let item = self.tracks[indexPath.row]
        self.performSegue(withIdentifier: "showDetail", sender: self)
    }
}
