//
//  TableViewController.swift
//  MyFavoritePlaces
//
//  Created by asbul on 22.06.2022.
//

import UIKit

final class TableViewController: UITableViewController {

//    var places = Place.getPlaces()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 85
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        places.count
        5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

//        let place = places[indexPath.row]
//        cell.nameLabel.text = place.name
//        cell.locationLabel.text = place.location
//        cell.typeLabel.text = place.type
//
//        if place.image == nil {
//            cell.imageOfPlace.image = UIImage(named: place.restaurantImage!)
//        } else {
//            cell.imageOfPlace.image = place.image
//        }
//
//        cell.imageOfPlace.clipsToBounds = true
//        cell.imageOfPlace.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        
        return cell
    }

    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let newPlaceVC = segue.source as? NewPlaceTableViewController else { return }
        newPlaceVC.saveNewPlace()
//        places.append(newPlaceVC.newPlace!)
        tableView.reloadData()
    }
}
