//
//  MusicViewController.swift
//  Alarm-ios-swift
//
//  Created by Stefano Brandi on 11/06/21.
//

import UIKit
import MediaPlayer

class MediaViewController: UITableViewController, MPMediaPickerControllerDelegate  {
    
    fileprivate let numberOfRingtones = 6
    var mediaItem: MPMediaItem?
    var mediaLabel: String!
    var mediaID: String!
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        performSegue(withIdentifier: Id.soundUnwindIdentifier, sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor =  UIColor.gray
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = .left
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        
        return numberOfRingtones
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "RINGTONS"
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Id.musicIdentifier)
        if(cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCell.CellStyle.default, reuseIdentifier: Id.musicIdentifier)
        }
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                cell!.textLabel!.text = "Digital"
            }
            else if indexPath.row == 1 {
                cell!.textLabel!.text = "Angry"
                
            } else if indexPath.row == 2 {
                cell!.textLabel!.text = "Birds"
                
            } else if indexPath.row == 3 {
                cell!.textLabel!.text = "Musical"
                
            } else if indexPath.row == 4 {
                cell!.textLabel!.text = "Sequential"
                
            } else if indexPath.row == 5 {
                cell!.textLabel!.text = "Techno"
            }
            
            
            if cell!.textLabel!.text == mediaLabel {
                cell!.accessoryType = UITableViewCell.AccessoryType.checkmark
            }
        }
        
        return cell!
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mediaPicker = MPMediaPickerController(mediaTypes: MPMediaType.anyAudio)
        mediaPicker.delegate = self
        mediaPicker.prompt = "Select any song!"
        mediaPicker.allowsPickingMultipleItems = false
        if indexPath.section == 2 {
            if indexPath.row == 0 {
                self.present(mediaPicker, animated: true, completion: nil)
            }
        }
        else if indexPath.section == 0 {
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = UITableViewCell.AccessoryType.checkmark
            mediaLabel = cell?.textLabel?.text!
            
            switch mediaLabel {
            case "Angry":
                playSound(soundName: "Angry")
                
            case "Birds":
                playSound(soundName: "Birds")
                
            case "Digital":
                playSound(soundName: "Digital")
                
            case "Musical":
                playSound(soundName: "Musical")
                
            case "Sequential":
                playSound(soundName: "Sequential")
                
            case "Techno":
                playSound(soundName: "Techno")
                
            default:
                break
            }
            
            cell?.setSelected(true, animated: true)
            cell?.setSelected(false, animated: true)
            let cells = tableView.visibleCells
            for c in cells {
                let section = tableView.indexPath(for: c)?.section
                if (section == indexPath.section && c != cell) {
                    c.accessoryType = UITableViewCell.AccessoryType.none
                }
            }
        }
    }
    
    func playSound(soundName: String) {
        
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = self.player else { return }
            
            player.prepareToPlay()
            player.play()
            //player.volume = 0.1
            
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    
    //MPMediaPickerControllerDelegate
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems  mediaItemCollection:MPMediaItemCollection) -> Void {
        if !mediaItemCollection.items.isEmpty {
            let aMediaItem = mediaItemCollection.items[0]
            
            self.mediaItem = aMediaItem
            mediaID = (self.mediaItem?.value(forProperty: MPMediaItemPropertyPersistentID)) as? String
            //self.dismiss(animated: true, completion: nil)
        }
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
