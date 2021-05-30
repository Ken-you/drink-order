//
//  OrderFormTableViewController.swift
//  drink-order
//
//  Created by yousun on 2021/5/27.
//

import UIKit

// 飲料總訂購單
class OrderFormTableViewController: UITableViewController {
    
    @IBOutlet weak var capTotalLabel: UILabel!
    
    @IBOutlet weak var sumTotalLabel: UILabel!
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    struct PropertyKeys {
            static let orderFormCell = "orderFormCell"
        }
    
    var orderData :OrderResponse?
    var orderInfo = [Records]()
    
    
    // 抓取總訂購單資料
    func fetchOrderData() {
        
        let url = URL(string: "https://api.airtable.com/v0/app9Nzd9guD7njQwk/order")!
        var request = URLRequest(url: url)
        
        request.setValue("Bearer keyNyE8FKMNaCFsU7", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            let decoder = JSONDecoder()
            
            if let data = data{
                do {
                    self.orderData = try decoder.decode(OrderResponse.self, from: data)
                    DispatchQueue.main.async {
                        
                        self.orderInfo = self.orderData!.records
                        
                        self.loadingView.stopAnimating()
                        
                        self.loadingView.isHidden = true
                        
                        self.tableView.reloadData()
                    }
                } catch  {
                    print(error)
                }
            }
        }.resume()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingView.startAnimating()
        
        setupGradientBackground()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        fetchOrderData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orderInfo.count
    }

    
    // 訂購單資料放入自訂 Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.orderFormCell, for: indexPath) as! OrderFormTableViewCell
        
        let order = orderData?.records[indexPath.row]

        cell.nameLabel.text = order?.fields.name
        cell.drinkLabel.text = order?.fields.drink
        cell.sizeLabel.text = order?.fields.size
        cell.sugarLabel.text = order?.fields.sugar
        cell.iceLabel.text = order?.fields.ice
        cell.addLabel.text = order?.fields.add
        cell.remarkLabel.text = order?.fields.remark ?? ""
        cell.priceLabel.text = "\((order?.fields.price)!)"
        
        // 設定初始杯數、總金額
        capTotalLabel.text = "\(orderInfo.count)"
        
        var total = 0
        
        for i in orderInfo {

            total += i.fields.price
        }

        sumTotalLabel.text = "\(total)"
        
        // 設定下方 TabBarItem 的 badgeValue 初始值
        if let items = self.tabBarController?.tabBar.items as NSArray? {
            let tabItem = items.object(at: 1) as! UITabBarItem
            tabItem.badgeValue = "\(orderInfo.count)"
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // 刪除訂單
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        // 點選刪除
        if editingStyle == .delete{
            
            // 跳出 Alert
            let controller = UIAlertController(title: "\((orderData?.records[indexPath.row].fields.name)!) 的 " + "\((orderData?.records[indexPath.row].fields.drink)!)", message: "確定要刪除這筆訂單嗎？", preferredStyle: .alert)
            
            // 設定 Alert 的 OK 選項、點選
            let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                
                self.loadingView.isHidden = false
                
                self.loadingView.startAnimating()
                
                // 抓取欲刪除資料的 ID
                let url = URL(string: "https://api.airtable.com/v0/app9Nzd9guD7njQwk/order" + "/" + (self.orderData?.records[indexPath.row].id)!)!

                var request = URLRequest(url: url)

                request.httpMethod = "DELETE"

                request.setValue("Bearer keyNyE8FKMNaCFsU7", forHTTPHeaderField: "Authorization")

                URLSession.shared.dataTask(with: request) { (data, response, error) in

                    if let response = response as? HTTPURLResponse,
                           response.statusCode == 200,
                           error == nil{

                            print("success")

                        // 執行 tableView 的刪除列、更新杯數、總金額、訂單數
                        DispatchQueue.main.async {

                            self.tableView.deleteRows(at: [indexPath], with: .fade)
                            
                            self.capTotalLabel.text = "\(self.orderInfo.count)"
                            
                            var total = 0
                            
                            for i in self.orderInfo {

                                total += i.fields.price
                            }

                            self.sumTotalLabel.text = "\(total)"
                            
                            if let items = self.tabBarController?.tabBar.items as NSArray? {
                                let tabItem = items.object(at: 1) as! UITabBarItem
                                tabItem.badgeValue = "\(self.orderInfo.count)"
                            }
                    
                            self.fetchOrderData()
                        }
                        }else {
                            print(error!)
                        }
                }.resume()
                
                // 刪除後台訂購單的資料列
                self.orderInfo.remove(at: indexPath.row)
            }
            
            // 加入 Alert 選項（ok 、 cancel）
            controller.addAction(okAction)
            controller.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            
            present(controller, animated: true, completion: nil)
        }
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
    
    
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "刪除") { (action, view, completionHandler) in}
//
//        let modifyAction = UIContextualAction(style: .normal, title: "修改") { (action, view, completionHandler) in}
//
//        return UISwipeActionsConfiguration(actions: [deleteAction, modifyAction])
//    }
    
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
