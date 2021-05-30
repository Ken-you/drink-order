//
//  OrderViewController.swift
//  drink-order
//
//  Created by yousun on 2021/5/26.
//

import UIKit

// 訂飲料選擇各式條件 Controller
class DrinkOrderViewController: UIViewController {

    
    @IBOutlet weak var drinkLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var sizeSegement: UISegmentedControl!
    
    @IBOutlet weak var sugarSegment: UISegmentedControl!
    
    @IBOutlet weak var iceSegment: UISegmentedControl!
    
    @IBOutlet weak var addSegment: UISegmentedControl!
    
    @IBOutlet weak var remarkTextField: UITextField!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var checkButton: UIButton!
    
    
    
    
    // 接收 Segue 傳的資料
    let drinkName :String
    let MPrice :Int
    let LPrice :Int
    let indexPath : Int
    
    init?(coder:NSCoder, menuinfo :MenuResponse, indexPath :Int){
        
        self.drinkName = menuinfo.records[indexPath].fields.name
        self.MPrice = menuinfo.records[indexPath].fields.mediumPrice
        self.LPrice = menuinfo.records[indexPath].fields.largePrice
        self.indexPath = indexPath
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // 額外設定變數儲存 中杯、大杯價格
    var money = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupAllSegment()
        setupGradientBackground()
    }
    
    
    // 收鍵盤 TextField 拉在一起
    @IBAction func dismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    // 中杯、大杯價格
    @IBAction func sizeChange(_ sender: UISegmentedControl) {
       
        if sizeSegement.selectedSegmentIndex == 0{
            totalPriceLabel.text = "\(MPrice)"
            money = MPrice
        }else {
            totalPriceLabel.text = "\(LPrice)"
            money = LPrice
            
        }
    }
    
    
    // 甜度顏色點選
    @IBAction func sugarColorChange(_ sender: UISegmentedControl) {
        
        if sugarSegment.selectedSegmentIndex == 0{
            sugarSegment.selectedSegmentTintColor = UIColor(red: 247/255, green: 152/255, blue: 54/255, alpha: 1)
            
        }else if sugarSegment.selectedSegmentIndex == 1 {
            sugarSegment.selectedSegmentTintColor = UIColor(red: 253/255, green: 201/255, blue: 89/255, alpha: 1)
            
        }else if sugarSegment.selectedSegmentIndex == 2{
            sugarSegment.selectedSegmentTintColor = UIColor(red: 237/255, green: 223/255, blue: 116/255, alpha: 1)
            
        }else if sugarSegment.selectedSegmentIndex == 3{
            sugarSegment.selectedSegmentTintColor = UIColor(red: 191/255, green: 222/255, blue: 119/255, alpha: 1)
            
        }else if sugarSegment.selectedSegmentIndex == 4{
            sugarSegment.selectedSegmentTintColor = UIColor(red: 101/255, green: 191/255, blue: 112/255, alpha: 1)
        }
    }
    
    
    // 冰塊顏色點選
    @IBAction func iceColorChange(_ sender: UISegmentedControl) {
        
        if iceSegment.selectedSegmentIndex == 0{
            iceSegment.selectedSegmentTintColor = UIColor(red: 18/255, green: 133/255, blue: 186/255, alpha: 1)
            
        }else if iceSegment.selectedSegmentIndex == 1{
            iceSegment.selectedSegmentTintColor = UIColor(red: 99/255, green: 169/255, blue: 211/255, alpha: 1)
            
        }else if iceSegment.selectedSegmentIndex == 2{
            iceSegment.selectedSegmentTintColor = UIColor(red: 129/255, green: 203/255, blue: 224/255, alpha: 1)
        
        }else if iceSegment.selectedSegmentIndex == 3{
            iceSegment.selectedSegmentTintColor = UIColor(red: 157/255, green: 215/255, blue: 246/255, alpha: 1)
            
        }else if iceSegment.selectedSegmentIndex == 4{
            iceSegment.selectedSegmentTintColor = UIColor(red: 203/255, green: 71/255, blue: 51/255, alpha: 1)
            
        }
    }
    
    
    // 加料計算
    @IBAction func addChange(_ sender: UISegmentedControl) {
        
        var add :Int
        
        if  addSegment.selectedSegmentIndex == 0 {
            
            add = 0
            totalPriceLabel.text = "\(money + add)"
            
        }else if addSegment.selectedSegmentIndex == 1{
        
            add = 5
            totalPriceLabel.text = "\(money + add)"
            
        }else if addSegment.selectedSegmentIndex == 2{
       
            add = 10
            totalPriceLabel.text = "\(money + add)"
          
        }else if addSegment.selectedSegmentIndex == 3{
    
            add = 15
            totalPriceLabel.text = "\(money + add)"
           
        }
    }
    
    
    // 點餐確認
    @IBAction func orderCheckBtn(_ sender: Any) {
        
        // 如果沒有寫姓名跳出 Alert 提醒
        if nameTextField.text?.isEmpty == true {
            
            let controller = UIAlertController(title: "哈囉！", message: "請問大名？", preferredStyle: .alert)
            
            controller.addAction(UIAlertAction(title: "呵呵，我忘了", style: .default, handler: nil))
            
            present(controller, animated: true, completion: nil)
            
        }else{
            
            // 抓取飲料設定的條件
            let ordername = nameTextField.text
            
            let drinkname = drinkName
            
            let size = sizeSegement.titleForSegment(at: sizeSegement.selectedSegmentIndex)
            
            let sugar = sugarSegment.titleForSegment(at: sugarSegment.selectedSegmentIndex)
            
            let ice = iceSegment.titleForSegment(at: iceSegment.selectedSegmentIndex)
            
            let add = addSegment.titleForSegment(at: addSegment.selectedSegmentIndex)
            
            let remark = remarkTextField.text ?? " "
            
            let price = Int(totalPriceLabel.text!)
            
            
            // 上傳飲料資料
            let url = URL(string: "https://api.airtable.com/v0/app9Nzd9guD7njQwk/order")!

            var request = URLRequest(url: url)

            request.httpMethod = "POST"

            request.setValue("Bearer keyNyE8FKMNaCFsU7", forHTTPHeaderField: "Authorization")

            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let encoder = JSONEncoder()
            
            // 帶入自訂的 struct orderData()
            let orderData = OrderItem(name: ordername!, drink: drinkname, size: size!, sugar: sugar!, ice: ice!, add: add!, remark: remark, price: price!)

            let drinkOrder = Postrecord(fields: orderData)

            let data = try? encoder.encode(drinkOrder)
                
                URLSession.shared.uploadTask(with: request,from: data) { (data, response, error) in

                    if let response = response as? HTTPURLResponse,
                           response.statusCode == 200,
                           error == nil{
                        
                            print("success")
                        
                        }else{
                            print(error!)
                        }
                }.resume()
            
            // 顯示訂購成功的 Alert
            let controller = UIAlertController(title: nil, message: "訂購成功！", preferredStyle: .alert)
        
            controller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(controller, animated: true ,completion: nil)
            
            // 訂購結束 Button 不能點選
            self.checkButton.isEnabled = false
            self.checkButton.backgroundColor = .darkGray
        }
    }
    
    
    // 設定各個 Segment 上的名稱
    func setupAllSegment(){
        
        // 帶入初始畫面 飲料名及中杯價格
        drinkLabel.text = drinkName
        totalPriceLabel.text = "\(MPrice)"
        money = MPrice
        
        sizeSegement.setTitle("\(sizeList.中杯)", forSegmentAt: 0)
        sizeSegement.setTitle("\(sizeList.大杯)", forSegmentAt: 1)
        
        sugarSegment.setTitle("\(sugarList.全糖)", forSegmentAt: 0)
        sugarSegment.setTitle("\(sugarList.半糖)", forSegmentAt: 1)
        sugarSegment.setTitle("\(sugarList.少糖)", forSegmentAt: 2)
        sugarSegment.setTitle("\(sugarList.微糖)", forSegmentAt: 3)
        sugarSegment.setTitle("\(sugarList.無糖)", forSegmentAt: 4)
        
        iceSegment.setTitle("\(iceList.正常)", forSegmentAt: 0)
        iceSegment.setTitle("\(iceList.少冰)", forSegmentAt: 1)
        iceSegment.setTitle("\(iceList.微冰)", forSegmentAt: 2)
        iceSegment.setTitle("\(iceList.去冰)", forSegmentAt: 3)
        iceSegment.setTitle("\(iceList.溫熱)", forSegmentAt: 4)
        
        addSegment.setTitle("\(addList.無)", forSegmentAt: 0)
        addSegment.setTitle("\(addList.珍珠)", forSegmentAt: 1)
        addSegment.setTitle("\(addList.波霸)", forSegmentAt: 2)
        addSegment.setTitle("\(addList.椰果)", forSegmentAt: 3)
    }
    
    
    // 設定背景漸層
    func setupGradientBackground() {
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = view.bounds
        
        gradientLayer.colors = [CGColor(srgbRed: 132/255, green: 250/255, blue: 176/255, alpha: 1),CGColor(srgbRed: 143/255, green: 211/255, blue: 244/255, alpha: 1)]
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
