//
//  ViewController.swift
//  FoodSlots
//
//  Created by Connor on 2020/11/6.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slotButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    var pickerView:UIPickerView!
    var pickerViewDataSize = 0
    var pickerViewData = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        slotButton.backgroundColor = UIColor.systemTeal
        slotButton.layer.cornerRadius = CGFloat(5)
        slotButton.tintColor = UIColor.white
        titleLabel.text = "請客拉霸機"
        initPickerView(data: ["Peter", "Connor", "Justin", "Cooper", "Karena", "Blues", "GreenTea",  "Sam"])
    }
    
    // 設定pickerView
    func initPickerView(data: [String]) {
        pickerViewData = data
        // 讓我們 picker view 看起像是一直重覆轉的樣子
        // 所以讓 picker view data 重覆
        pickerViewDataSize = 30 * pickerViewData.count
        pickerView = UIPickerView()
        pickerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pickerView.layer.cornerRadius = 10
        pickerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 4)
        pickerView.center = view.center
        pickerView.delegate = self
        pickerView.dataSource = self
        // 讓初始停留位置不要從第一個row開始，這樣比較像拉霸
        pickerView.selectRow(pickerViewData.count + 1, inComponent: 0, animated: false)
        view.addSubview(pickerView)
    }
    
    
    @IBAction func clickButton(_ sender: Any) {
        // 初始化位置
        pickerView.selectRow(pickerViewData.count + 1, inComponent: 0, animated: true)
        var row = 0
        let randomCount = Int.random(in: 1 ... Int(pickerViewDataSize / pickerViewData.count))
        
        // 利用timer來幫我們執行移動picker view row
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            if row < (randomCount + self.pickerViewData.count) {
                self.pickerView.selectRow(row, inComponent: 0, animated: true)
                self.titleLabel.text = self.pickerViewData[row % self.pickerViewData.count]
                row += 1
            } else {
                timer.invalidate()
            }
        }
    }

}


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerViewDataSize
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewData[row % pickerViewData.count]
    }
    
}
