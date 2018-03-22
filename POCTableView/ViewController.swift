//
//  ViewController.swift
//  POCTableView
//
//  Created by Bondan Eko Prasetyo on 22/03/18.
//  Copyright © 2018 B-Site. All rights reserved.
//

import RxSwift
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var arrOfString = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        arrOfString.append("Test")
        
        let scheduler = SerialDispatchQueueScheduler(qos: .default)
        let subscription = Observable<Int>.interval(1, scheduler: scheduler)
        tableView.estimatedRowHeight = 100
        tableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        subscription
            .subscribe(onNext:{ tick in
            //print(self.arrOfString)
            self.appendText(index: tick)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                //self.tableView.scrollToRow(at: IndexPath(row:(self.arrOfString.count - 1), section: 0), at: UITableViewScrollPosition.bottom, animated: true)
            }
        })
    }
    
    private func appendText(index: Int){
        if(index % 2 == 0){
            self.arrOfString.insert("Lorem ipsum dolor sit amet \(index)", at: 0)
//            for i in 1...60 {
//                if(i % 2 == 0){
//                    self.arrOfString.insert("Lorem ipsum dolor sit amet \(i)", at: 0)
//                }else{
//                    self.arrOfString.insert("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas ornare purus diam, quis pellentesque massa fringilla nec. \(i)", at: 0)
//                }
//            }
        }else{
             self.arrOfString.insert("Test \(index)", at: 0)
//            for i in 1...60 {
//                if(i % 2 == 0){
//                    self.arrOfString.insert("Test \(i)", at: 0)
//                }else{
//                    self.arrOfString.insert("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas ornare purus diam, quis pellentesque massa fringilla nec. Suspendisse sapien est, dignissim sed nisl aliquam, euismod facilisis dui. Vivamus in finibus magna, quis eleifend augue. Vivamus est ipsum, pharetra eu fringilla id.  \(index)", at: 0)
//                }
//            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfString.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // This is to check , when table view is reload data, whether all the datasource is counted or only counted on the viewport
        debugPrint(indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
        cell.textLabel?.text = arrOfString[indexPath.row]
        cell.textLabel?.sizeToFit()
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}
