import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var segCtrl: UISegmentedControl!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var floatImg: UIImageView!
    @IBOutlet weak var statusFloat: UIImageView!
    
    
    let headerArr = ["","Recents","Viewed updates","Muted updates"]
    let nameArr = ["Neha","Deep","Mahesh","Kamal","Farhana","Bhavesh"]
    let pinArr = ["pin","pin","","","",""]
    let timelbl = ["Today, 3:55 PM","Today, 3:02 PM","Today, 1:12 PM","Today, 11:55 AM","Today, 10:45 AM","Today, 9:20 AM"]
    let timelbl1 = ["10:00 PM","9:57 PM","2:44 PM","12:54 PM","12:05 PM","11:45 AM"]
    let callImageArr = ["call","video","call","call","video","call"]
    let messageArr = ["Hey","Whatcha Doin?","gtg","omw","okay","Call me"]
    var sectionOpen = [true,true,true,false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(nameArr.shuffled())
    }
    @IBAction func SegCtrlAction(_ sender: UISegmentedControl) {
        tblView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if segCtrl.selectedSegmentIndex == 1{
            return headerArr.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sectionOpen[section]{
            if segCtrl.selectedSegmentIndex == 0{
                return nameArr.count
            }
            if segCtrl.selectedSegmentIndex == 2{
                return nameArr.count
            }
            if segCtrl.selectedSegmentIndex == 1{
                if section == 0{
                    return 1
                }
                if section == 1{
                    return nameArr.count/2
                }
                if section == 2{
                    return nameArr.count-1
                }
                if section == 3{
                    return nameArr.count-2
                }
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTVC") as! CustomTVC
        cell.dpImg.layer.borderWidth = 0
        cell.pinImg.isHidden = false
        cell.statusImg.isHidden = true
        self.floatImg.isHidden = false
        self.statusFloat.isHidden = true
        cell.timeLbl.isHidden = true
        cell.dpImg.image = UIImage(named: "\(nameArr[indexPath.row])")
        cell.nameLbl.text = nameArr[indexPath.row]
        
        if segCtrl.selectedSegmentIndex == 0{
            cell.pinImg.image = UIImage(named: "\(pinArr[indexPath.row])")
            cell.messageLbl.text = messageArr[indexPath.row]
            cell.timeLbl.isHidden = false
            self.floatImg.image = UIImage(named: "chat")
            cell.timeLbl.text = timelbl1[indexPath.row]
            return cell
        }
        if segCtrl.selectedSegmentIndex == 2{
            self.floatImg.image = UIImage(named: "addCall")
            cell.messageLbl.text = timelbl[indexPath.row]
            cell.pinImg.image = UIImage(named: "\(callImageArr[indexPath.row])")
        }
        
        if segCtrl.selectedSegmentIndex == 1{
            cell.dpImg.layer.borderWidth = 4
            cell.dpImg.layer.borderColor = #colorLiteral(red: 0.002048458206, green: 0.3833605349, blue: 0.34082219, alpha: 1)
            cell.pinImg.isHidden = true
            self.floatImg.isHidden = false
            self.statusFloat.isHidden = false
            self.floatImg.image = UIImage(named: "cam")
            cell.nameLbl.text = nameArr[indexPath.row]
            cell.messageLbl.text = timelbl[indexPath.row]
            cell.dpImg.image = UIImage(named: "\(nameArr[indexPath.row])")
            cell.statusImg.isHidden = true
            
            if indexPath.section == 0{
                cell.nameLbl.text = "My Status"
                cell.messageLbl.text = "Tap to add status"
                cell.statusImg.isHidden = false
                return cell
            }
            
            if indexPath.section == 2{
                cell.dpImg.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "CustomHeader") as! CustomHeader
        if segCtrl.selectedSegmentIndex == 1{
            header.headerLbl.text = headerArr[section]
            header.muteSection.isHidden = true
            header.muteSection.tag = section
            header.muteSection.addTarget(self, action: #selector(mutePress(sender:)), for: .touchUpInside)
            if sectionOpen[section]{
                header.muteSection.setBackgroundImage(UIImage(named: "up"), for: .normal)
            }
            if !sectionOpen[section]{
                header.muteSection.setBackgroundImage(UIImage(named: "down"), for: .normal)
            }
            if section == 3{
                header.muteSection.isHidden = false
            }
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if segCtrl.selectedSegmentIndex == 1{
            if section == 3{
                if !sectionOpen[section] {
                    return 200
                }
                return 0
            }
        }
        return 0
    }
    
    @objc func mutePress(sender:UIButton){
        print("\(sectionOpen)")
        sectionOpen[sender.tag] = !sectionOpen[sender.tag]
        tblView.reloadData()
    }
}
