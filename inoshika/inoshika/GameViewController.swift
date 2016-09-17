//
//  GameViewController.swift
//  inoshika
//
//  Created by 協調メディア研究室 on 2016/09/07.
//  Copyright (c) 2016年 協調メディア研究室. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
    
        private var myImageView: UIImageView!
    
    var huda: [UInt8:String] = [11:"カス", 12:"カス", 13:"短冊", 14:"五光",
                                21:"カス", 22:"カス", 23:"短冊", 24:"タネ",
                                31:"カス", 32:"カス", 33:"短冊", 34:"五光",
                                41:"カス", 42:"カス", 43:"短冊", 44:"タネ",
                                51:"カス", 52:"カス", 53:"短冊", 54:"タネ",
                                61:"カス", 62:"カス", 63:"短冊", 64:"タネ",
                                71:"カス", 72:"カス", 73:"短冊", 74:"タネ",
                                81:"カス", 82:"カス", 83:"タネ", 84:"五光",
                                91:"カス", 92:"カス", 93:"短冊", 94:"タネ",
                                101:"カス", 102:"カス", 103:"短冊", 104:"タネ",
                                111:"カス", 112:"短冊", 113:"タネ", 114:"五光",
                                121:"カス", 122:"カス", 123:"カス", 124:"五光"]
    
    var image: [UInt8:String] = [11:"image11", 12:"image12", 13:"image13", 14:"image14",
                                 21:"image21", 22:"image22", 23:"image23", 24:"image24",
                                 31:"image31", 32:"image32", 33:"image33", 34:"image34",
                                 41:"image41", 42:"image42", 43:"image43", 44:"image44",
                                 51:"image51", 52:"image52", 53:"image53", 54:"image54",
                                 61:"image61", 62:"image62", 63:"image63", 64:"image64",
                                 71:"image71", 72:"image72", 73:"image73", 74:"image74",
                                 81:"image81", 82:"image82", 83:"image83", 84:"image84",
                                 91:"image91", 92:"image92", 93:"image93", 94:"image94",
                                 101:"image101", 102:"image102", 103:"image103", 104:"image104",
                                 111:"image111", 112:"image112", 113:"image113", 114:"image114",
                                 121:"image121", 122:"image122", 123:"image123", 124:"image124"]
    


    
                                

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // UIImageViewを作成する.
//        myImageView = UIImageView(frame: CGRectMake(0,0,100,120))
//        
//        // 表示する画像を設定する.
//        let myImage = UIImage(named: "test.png")
//        
//        // 画像をUIImageViewに設定する.
//        myImageView.image = myImage
//        
//        // 画像の表示する座標を指定する.
//        myImageView.layer.position = CGPoint(x: self.view.bounds.width/2, y: 200.0)
//        
//        // UIImageViewをViewに追加する.
//        self.view.addSubview(myImageView)
        for num in huda.keys {
            print(num)
        }
        
        for kinds in huda.values {
            print("\(kinds):t")
        }
        
    }
//
//        // create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
//        
//        // create and add a camera to the scene
////        let cameraNode = SCNNode()
//        cameraNode.camera = SCNCamera()
//        scene.rootNode.addChildNode(cameraNode)
//        
//        // place the cameraaas
//        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
//        
//        // create and add a light to the scene
//        let lightNode = SCNNode()
//        lightNode.light = SCNLight()
//        lightNode.light!.type = SCNLightTypeOmni
//        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
//        scene.rootNode.addChildNode(lightNode)
//        
//        // create and add an ambient light to the scene
//        let ambientLightNode = SCNNode()
//        ambientLightNode.light = SCNLight()
//        ambientLightNode.light!.type = SCNLightTypeAmbient
//        ambientLightNode.light!.color = UIColor.darkGrayColor()
//        scene.rootNode.addChildNode(ambientLightNode)
//        
//        // retrieve the ship node
//        let ship = scene.rootNode.childNodeWithName("ship", recursively: true)!
//        
//        // animate the 3d object
//        ship.runAction(SCNAction.repeatActionForever(SCNAction.rotateByX(0, y: 2, z: 0, duration: 1)))
//        
//        // retrieve the SCNView
//        let scnView = self.view as! SCNView
//        
//        // set the scene to the view
//        scnView.scene = scene
//        
//        // allows the user to manipulate the camera
//        scnView.allowsCameraControl = true
//        
//        // show statistics such as fps and timing information
//        scnView.showsStatistics = true
//        
//        // configure the view
//        scnView.backgroundColor = UIColor.blackColor()
//        
//        // add a tap gesture recognizer
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
//        scnView.addGestureRecognizer(tapGesture)
//    }
//    
//    func handleTap(gestureRecognize: UIGestureRecognizer) {
//        // retrieve the SCNView
//        let scnView = self.view as! SCNView
//        
//        // check what nodes are tapped
//        let p = gestureRecognize.locationInView(scnView)
//        let hitResults = scnView.hitTest(p, options: nil)
//        // check that we clicked on at least one object
//        if hitResults.count > 0 {
//            // retrieved the first clicked object
//            let result: AnyObject! = hitResults[0]
//            
//            // get its material
//            let material = result.node!.geometry!.firstMaterial!
//            
//            // highlight it
//            SCNTransaction.begin()
//            SCNTransaction.setAnimationDuration(0.5)
//            
//            // on completion - unhighlight
//            SCNTransaction.setCompletionBlock {
//                SCNTransaction.begin()
//                SCNTransaction.setAnimationDuration(0.5)
//                
//                material.emission.contents = UIColor.blackColor()
//                
//                SCNTransaction.commit()
//            }
//            
//            material.emission.contents = UIColor.redColor()
//            
//            SCNTransaction.commit()
//        }
//    }
//    
//    override func shouldAutorotate() -> Bool {
//        return true
//    }
//    
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }
//    
//    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
//        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
//            return .AllButUpsideDown
//        } else {
//            return .All
//        }
//    }
//    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
           // Release any cached data, images, etc that aren't in use.
        }

}
