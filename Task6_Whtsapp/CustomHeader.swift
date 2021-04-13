import UIKit

class CustomHeader: UITableViewCell {

    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var muteSection: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
