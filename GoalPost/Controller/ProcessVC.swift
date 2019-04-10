//
//  ProcessVC.swift
//  GoalPost
//
//  Created by Kien on 3/11/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit
import QuartzCore
import CoreData

class ProcessVC: UIViewController,LineChartDelegate {
   
    
    var lineChart:LineChart!
    var goals:[Goal] = []


 
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCoreDataObjects()
        
        var views: [String: AnyObject] = [:]
        lineChart = LineChart()
        lineChart.animation.enabled = true
        lineChart.area = true
        lineChart.x.labels.visible = true
        lineChart.x.grid.count = 5
        lineChart.y.grid.count = 5
        
        var goalprogress:[CGFloat] = []
        
        for goal in goals{
            goalprogress.append(CGFloat(goal.goalProgress))
        }
        
        lineChart.addLine(goalprogress)
        self.view.addSubview(lineChart)

 
//        lineChart.addLine([3, 4, 9, 11, 13, 15])
//        lineChart.addLine([5, 4, 3, 6, 6, 7])
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        lineChart.delegate = self
        self.view.addSubview(lineChart)
        
//        label.text = "Your target this week, "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
        views["label"] = label


        views["chart"] = lineChart
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[chart]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[label]-[chart(==200)]", options: [], metrics: nil, views: views))
        // Do any additional setup after loading the view.
    }
    
    func didSelectDataPoint(_ x: CGFloat, yValues: [CGFloat]) {
        print("\(x) and \(yValues)")

    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if let chart = lineChart {
            chart.setNeedsDisplay()
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
      
        
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        
        
        let mainController = self.storyboard?.instantiateViewController(withIdentifier: "Main")
        self.present(mainController!, animated: true, completion: nil)
    }
    
    func fetchCoreDataObjects() {
        self.fetch { (complete) in
            if complete {
                
                label.text = "You have \(goals.count) targets this week"
            
                
            }
        }
    }
    
    func rowIndex()  {
        
        var goalprogress:[CGFloat] = []

        for goal in goals{
            goalprogress.append(CGFloat(goal.goalProgress))
        }
        
        lineChart.addLine(goalprogress)
        self.view.addSubview(lineChart)

        
        
    }
    
    func fetch(completion:(_ complete:Bool)->())  {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            goals = try managedContext.fetch(fetchRequest)
            print("Successfully fetched data.")
            print("hello what is this\(goals.count)")
            
            completion(true)
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
        
    }
    
    
    
    



}
