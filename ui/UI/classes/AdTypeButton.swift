import UIKit

class AdTypeButton: UIButton {
    var alternateButton:Array<AdTypeButton>?
    
    let turquoise = UIColor(red:0.08, green:0.80, blue:0.63, alpha:1.0)
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2.0
        self.layer.masksToBounds = true
    }
    
    func unselectAlternateButtons(){
        if alternateButton != nil {
            self.isSelected = true
            
            for aButton: AdTypeButton in alternateButton! {
                aButton.isSelected = false
            }
        }else{
            toggleButton()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }
    
    func toggleButton(){
        self.isSelected = !isSelected
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderColor = turquoise.cgColor
                self.setTitleColor(turquoise, for: .normal)
             } else {
                self.layer.borderColor = UIColor.gray.cgColor
                self.setTitleColor(UIColor.gray, for: .normal)
            }
        }
    }
}
