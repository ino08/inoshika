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



class Player {
    var player_name : String = ""                                //player番号
    var tehuda : [Int]=[11,103,84,22,74,83,54,44]     //持ち札
    var syutoku : [Int]=[14,34,84,114,123,11,21,31,41,51,61,71,81,91,101,64,74,104,0,0,0,0]          //取得札
    var tehuda_nokori = 8                            //持ち札の残り枚数
    var syutoku_maisu = 18                          //取得札の枚数
    var points:Int = 0                              //得点
    var yaku_check:Int = 0                          //役判定
    var select_tnum: Int = 0                        //手札の選択
    var select_bnum: Int = 0                        //場札の選択
    var i = 0
    var flag = 0

    
    
    func Check_points() -> Void {                      //得点のチェック
        print(player_name, "の得点は",points,"点です。")
    }
    
    
    func Mochihuda() -> Void {                         //持ち札のチェック
        print(player_name, "の")
        
        for i in 0..<tehuda_nokori{
            
            print(i+1,"枚目の持ち札は",huda[tehuda[i]])
        
        }
    }
 
    
    func Check_yaku() -> Void {                           //役のチェック
        
        Goko_check()
        Kasu_check()
        Tan_check()
        InoShikaCyo()
        
    }
    
    func Goko_check() -> Void {                           //五光のチェック

        
        for i in 0..<syutoku_maisu{                       //五光札の枚数をカウントしyaku_checkに格納
            
            if huda[syutoku[i]] == "五光"{
                yaku_check = yaku_check+1
            }
        }
        
        switch yaku_check{                                //yaku_checkにより役を識別、得点を加算
        case 3:
            print("三光です")
            points = points + 6
        case 4:
            flag = 0
            
            for i in 0..<syutoku_maisu{
                if syutoku[i] == 114 {
                    flag = 1
                    break
                }
            }
            
            if flag == 1 {
                print("雨四光です")
                points = points + 8
            } else {
                print("四光です")
                points = points + 10
            }
        case 5:
            print("五光です")
            points = points + 15
        default:
            print(yaku_check)
        }
        
        
    }
    
    func Kasu_check() -> Void {                            //カスのチェック
        yaku_check = 0
        
        for i in 0..<syutoku_maisu{                        //カス札の枚数をカウントしyaku_checkに格納
            
            if huda[syutoku[i]] == "カス"{
                yaku_check = yaku_check + 1
            }
        }
        
       if yaku_check > 9{                                  //カス札の枚数に応じた得点を加算
            points = points + (yaku_check-9)
            print("カスです")
        }
    }
    
    func Tan_check() -> Void {                             //タンのチェック
        yaku_check = 0
        
        for i in 0..<syutoku_maisu{                        //短冊札の枚数をカウントしyaku_checkに格納
            
            if huda[syutoku[i]] == "短冊"{
                yaku_check = yaku_check + 1
            }
        }
        
        if yaku_check > 4{                                 //短冊札の枚数に応じた得点を加算
            points = points + (yaku_check-4)
            print("短冊です")
        }
    }
    
    func Tane_check() -> Void {                             //タネのチェック
        yaku_check = 0
        
        for i in 0..<syutoku_maisu{                         //タネ札の枚数をカウントしyaku_checkに格納
            
            if huda[syutoku[i]] == "タネ"{
                yaku_check = yaku_check + 1
            }
        }
        if yaku_check > 4{                                  //タネ札の枚数に応じた得点を加算
            points = points + (yaku_check-4)
            print("タネです")
        }
    }
    
    func InoShikaCyo() -> Void {                            //猪鹿蝶のチェック
        yaku_check = 0
        
        for i in 0..<syutoku_maisu{                         //猪・鹿・蝶の札の枚数をカウントしyaku_checkに格納
            
            if syutoku[i] == 64{
                yaku_check = yaku_check + 1
            }else if syutoku[i] == 74{
                yaku_check = yaku_check + 1
            }else if syutoku[i] == 104{
                yaku_check = yaku_check + 1
            }
        }
        
        if yaku_check == 3{                                 //猪鹿蝶の得点を加算
            points = points + 5
            print("猪鹿蝶です")
        }
    }
    
    func tehuda_select(select_tnum: Int, select_bnum: Int) -> Int {
        
        syutoku[syutoku_maisu] = tehuda[select_tnum]
        tehuda[select_tnum] = 0
        syutoku_maisu += 1
        tehuda_nokori -= 1
        syutoku[syutoku_maisu] = table.bahuda_select(select_bnum)
        syutoku_maisu += 1
        

        return 0
        
    }


    
}



class Table {
    var yamahuda : [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var bahuda : [Int] = [73,14,12,13,44,34,24,33]
    var bahuda_nokori = 8
    var yamahuda_nokori = 24
    var huda_check = 0
    var huda_flag : [Int] = [0,0,0,0,0,0,0,0]
    var tmp = 0
    
    
    
    
    func bahuda_check(huda_num: Int) -> Void {
        
        
        let huda_num = huda_num / 10
        huda_check = 0
        
        switch huda_num{
            
        case 1:
            for i in 0..<bahuda_nokori{
                if 10 < bahuda[i] && bahuda[i] < 15{
                    huda_flag[i] = bahuda[i]
                    huda_check += 1
                }
            }

        case 2:
            for i in 0..<bahuda_nokori{
                if 20 < bahuda[i] && bahuda[i] < 25{
                    huda_flag[i] = bahuda[i]
                    huda_check += 1
                }
            }
        case 3:
            for i in 0..<bahuda_nokori{
                if 30 < bahuda[i] && bahuda[i] < 35{
                    huda_flag[i] = bahuda[i]
                    huda_check += 1
                }
            }
        case 4:
            for i in 0..<bahuda_nokori{
                if 40 < bahuda[i] && bahuda[i] < 45{
                    huda_flag[i] = bahuda[i]
                    huda_check += 1
                }
            }
        case 5:
            for i in 0..<bahuda_nokori{
                if 50 < bahuda[i] && bahuda[i] < 55{
                    huda_flag[i] = bahuda[i]
                    huda_check += 1
                }
            }
        case 6:
            for i in 0..<bahuda_nokori{
                if 60 < bahuda[i] && bahuda[i] < 65{
                    huda_check += 1
                    huda_flag[i] = bahuda[i]
                }
            }
        case 7:
            for i in 0..<bahuda_nokori{
                if 70 < bahuda[i] && bahuda[i] < 75{
                    huda_flag[i] = bahuda[i]
                    huda_check += 1
                }
            }
        case 8:
            for i in 0..<bahuda_nokori{
                if 80 < bahuda[i] && bahuda[i] < 85{
                    huda_flag[i] = bahuda[i]
                    huda_check += 1
                }
            }
        case 9:
            for i in 0..<bahuda_nokori{
                if 90 < bahuda[i] && bahuda[i] < 95{
                    huda_flag[i] = bahuda[i]
                    huda_check += 1
                }
            }
        case 10:
            for i in 0..<bahuda_nokori{
                if 100 < bahuda[i] && bahuda[i] < 105{
                    huda_flag[i] = bahuda[i]
                    huda_check += 1
                }
            }
        case 11:
            for i in 0..<bahuda_nokori{
                if 110 < bahuda[i] && bahuda[i] < 115{
                    huda_flag[i] = bahuda[i]
                    huda_check += 1
                }
            }
        case 12:
            for i in 0..<bahuda_nokori{
                if 120 < bahuda[i] && bahuda[i] < 125{
                    huda_flag[i] = bahuda[i]
                    huda_check += 1
                }
            }

        default:
            break
        
        }
        
        if huda_check != 0{
            for i in 0..<bahuda_nokori {
                if huda_flag[i] != 0 {
                    print(huda_flag[i])
                }
            }
        }else{
            print("ペアとなる札が存在しません")
        }

    }
    
    func bahuda_select(select_bnum: Int) -> Int {
        
        tmp = bahuda[select_bnum]
        bahuda[select_bnum] = 0
        
        return tmp
    }
}

var huda: [Int:String] = [11:"カス", 12:"カス", 13:"短冊", 14:"五光",                   //札の識別用辞書
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

var image: [Int:String] = [11:"image11", 12:"image12", 13:"image13", 14:"image14",      //画像ファイル識別用辞書
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


var player1 = Player()
var player2 = Player()
var table = Table()


class GameViewController: UIViewController {
    
    private var myImageView: UIImageView!
    
    @IBOutlet weak var testButton: UIButton!
    
    @IBAction func touchTextButton(sender: UIButton) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        player1.player_name = "player1"
        player2.player_name = "player2"
        player1.tehuda_nokori = 7
        player1.Check_points()
        player2.Check_points()
        player1.Mochihuda()
        player1.Check_yaku()
        player1.Check_points()
        player1.Mochihuda()
        print(player1.syutoku[19])
        print(player1.syutoku[18])
        print(player1.syutoku[17])
        print(player1.syutoku[16])
        player1.tehuda_select(2, select_bnum: 1)
        print(player1.syutoku[19])
        print(player1.syutoku[18])
        print(player1.syutoku[17])
        print(player1.syutoku[16])
        table.bahuda_check(72)
        
        

////        // UIImageViewを作成する.
////        myImageView = UIImageView(frame: CGRectMake(0,0,100,120))
////        
////        // 表示する画像を設定する.
////        let myImage = UIImage(named: "test.png")
////        
////        // 画像をUIImageViewに設定する.
////        myImageView.image = myImage
////        
////        // 画像の表示する座標を指定する.
////        myImageView.layer.position = CGPoint(x: self.view.bounds.width/2, y: 200.0)
////        
////        // UIImageViewをViewに追加する.
////        self.view.addSubview(myImageView)
//
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