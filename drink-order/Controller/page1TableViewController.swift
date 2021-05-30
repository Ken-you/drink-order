//
//  page1TableViewController.swift
//  drink-order
//
//  Created by yousun on 2021/5/25.
//

import UIKit

class page1TableViewController: UITableViewController {
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    
    struct PropertyKeys {
            static let page1Cell = "page1Cell"
        }
    
    
    var drinkData :MenuResponse?
    var drinkinfo = [MenuResponse.Records]()
    
    
    // 抓 MenuPage1 資料
    func fetchDrinkData() {
        
        let url = URL(string: "https://api.airtable.com/v0/appyTZHcqWGTXNruP/Page1")!
        
        var request = URLRequest(url: url)
        
        request.setValue("Bearer keyNyE8FKMNaCFsU7", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
                
           let decoder = JSONDecoder()
            
            if let data = data {
                
                do {
                    self.drinkData = try decoder.decode(MenuResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        
                        self.drinkinfo = self.drinkData!.records
                        
                        // 抓到資料後 loading 停止並隱藏
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
    
    
    // 點選資料傳遞給下一頁
    @IBSegueAction func showDetail(_ coder: NSCoder) -> DrinkOrderViewController? {
        
        guard let row = tableView.indexPathsForSelectedRows?.first?.row else { return nil }
        
        return DrinkOrderViewController.init(coder: coder, menuinfo: drinkData!, indexPath: row)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchDrinkData()
        
        loadingView.startAnimating()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return drinkinfo.count
    }

  
    // 資料放入自訂的 Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.page1Cell, for: indexPath) as! page1TableViewCell
        
        let drink = drinkData?.records[indexPath.row]
        
        cell.drinkNameLabel.text = drink?.fields.name
        cell.describeLabel.text = drink?.fields.describe ?? " "
        cell.mediumLabel.text = "\((drink?.fields.mediumPrice)!)"
        cell.largeLabel.text = "\((drink?.fields.largePrice)!)"

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
