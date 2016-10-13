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
    var player_num : Int = 0                                //player番号
    var tehuda : [Int]=[11,103,84,22,74,83,54,44]           //持ち札
    var syutoku : [Int]=[1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]          //取得札
    var tehuda_max = 8                              //持ち札の残り枚数
    var tehuda_cnt = 0                              //手札の残数のカウント用
    var syutoku_maisu = 2                           //取得札の枚数
    var points:Int = 0                              //得点
    var yaku_cnt:Int = 0                            //役判定
    var select_tnum: Int = 0                        //手札の選択
    var select_bnum: Int = 0                        //場札の選択
    var yc_flag = 0                                 //役判定用flag
    var cp_flag = 0                                 //cp用flag

    
    
    func Check_points() -> Void {                         //得点のチェック
        print("player",player_num, "の得点は",points,"点です。")
    }
    
    
    func Tehuda_print() -> Void {                         //持ち札のチェック
        print("player", player_num, "の")
        
        for i in 0..<tehuda_max{
            
            print(i+1,"枚目の持ち札は",huda[tehuda[i]])
        
        }
    }
    
    func Check_tehuda() -> Int {                          //手札の枚数をカウントする関数
        
        tehuda_cnt = 0
        
        for i in 0 ..< 8 {
            
            if tehuda[i] == 0 {
                tehuda_cnt += 1
            }
        }
        
        return tehuda_cnt
    }
    
 
    
    func Check_yaku() -> Void {                           //役のチェック関数
        yc_flag = 0
        
        Goko_check()
        Kasu_check()
        Tan_check()
        InoShikaCyo()
        
    }
    
    func Goko_check() -> Void {                           //五光のチェック関数

        
        for i in 0..<syutoku_maisu{                       //五光札の枚数をカウントしyaku_checkに格納
            
            if huda[syutoku[i]] == "五光"{
                yaku_cnt = yaku_cnt+1
            }
        }
        
        switch yaku_cnt{                                  //yaku_checkにより役を識別、得点を加算
        case 3:
            print("三光です")
            points = points + 6
        case 4:
            yc_flag = 0
            
            for i in 0..<syutoku_maisu{
                if syutoku[i] == 114 {
                    yc_flag = 1
                    break
                }
            }
            
            if yc_flag == 1 {
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
            print(yaku_cnt)
        }
        
        
    }
    
    func Kasu_check() -> Void {                            //カスのチェック関数
        yaku_cnt = 0
        
        for i in 0..<syutoku_maisu{                        //カス札の枚数をカウントしyaku_checkに格納
            
            if huda[syutoku[i]] == "カス"{
                yaku_cnt = yaku_cnt + 1
            }
        }
        
       if yaku_cnt > 9{                                    //カス札の枚数に応じた得点を加算
            points = points + (yaku_cnt-9)
            print("カスです")
        }
    }
    
    func Tan_check() -> Void {                             //タンのチェック関数
        yaku_cnt = 0
        
        for i in 0..<syutoku_maisu{                        //短冊札の枚数をカウントしyaku_checkに格納
            
            if huda[syutoku[i]] == "短冊"{
                yaku_cnt = yaku_cnt + 1
            }
        }
        
        if yaku_cnt > 4{                                   //短冊札の枚数に応じた得点を加算
            points = points + (yaku_cnt-4)
            print("短冊です")
        }
    }
    
    func Tane_check() -> Void {                             //タネのチェック関数
        yaku_cnt = 0
        
        for i in 0..<syutoku_maisu{                         //タネ札の枚数をカウントしyaku_checkに格納
            
            if huda[syutoku[i]] == "タネ"{
                yaku_cnt = yaku_cnt + 1
            }
        }
        if yaku_cnt > 4{                                    //タネ札の枚数に応じた得点を加算
            points = points + (yaku_cnt - 4)
            print("タネです")
        }
    }
    
    func InoShikaCyo() -> Void {                            //猪鹿蝶のチェック関数
        yaku_cnt = 0
        
        for i in 0..<syutoku_maisu{                         //猪・鹿・蝶の札の枚数をカウントしyaku_checkに格納
            
            if syutoku[i] == 64{
                yaku_cnt = yaku_cnt + 1
            }else if syutoku[i] == 74{
                yaku_cnt = yaku_cnt + 1
            }else if syutoku[i] == 104{
                yaku_cnt = yaku_cnt + 1
            }
        }
        
        if yaku_cnt == 3{                                    //猪鹿蝶の得点を加算
            points = points + 5
            print("猪鹿蝶です")
        }
    }
    
    
    
    func Add_syutoku_tb(select_tnum: Int, select_bnum: Int) -> Int {   //選択した手札と場札の番号を受け取りそれぞれを取得配列に格納する関数
        
        if tehuda[select_tnum] / 10 != table.bahuda[select_bnum] / 10 { //手札と場札が合わない場合1を返り値とする
            
            return 1
        }
        
        if tehuda[select_tnum] == 0 {                                   //選択した手札が空行列の時1を返り値とする
            
            return 1
        }
        
        
        syutoku[syutoku_maisu] = tehuda[select_tnum]
        tehuda[select_tnum] = 0
        syutoku_maisu += 1
        
        syutoku[syutoku_maisu] = table.bahuda[select_bnum]
        table.bahuda[select_bnum] = 0
        syutoku_maisu += 1
//        syutoku[syutoku_maisu] = table.Bahuda_select(select_bnum)

        

        return 0
        
    }
    
    func Add_syutoku_yb(select_y: Int, select_b: Int) -> Void {         //手札と山札の組を取得配列に格納する関数
        
        syutoku[syutoku_maisu] = select_y
        syutoku_maisu += 1
        syutoku[syutoku_maisu] = select_b
        syutoku_maisu += 1
        
    }
    
    func Add_bahuda_t(select_t: Int) -> Int {                           //手札を場札配列の空きに挿入する関数
        
        for i in 0 ..< 8 {
            
            if table.bahuda[i] == 0 {
                table.bahuda[i] = tehuda[select_t]
                return 0
            }
        }
        
        return 1
        
    }
    

    
    
    func CP() -> Void {                                                 //CPの動作決定関数
        
        for i in 0 ..< 8 {
        
            for j in 0 ..< 8 {
            
                 cp_flag = Add_syutoku_tb(i, select_bnum: j)
                
                if cp_flag == 0 {
                    print("test")
                    break
                }
                
            }
            
            if cp_flag == 0 {
                print("test2")

                break
            }
            
            
        }
        
        
        if cp_flag == 1 {
            
            for i in 0 ..< 8 {
                
                if tehuda[i] != 0 {
                    Add_bahuda_t(tehuda[i])
                    break
                }
            }
        }
        
        table.Draw(1)

        
    }
    



    
}




class Table {
    var base : [Int] = [11, 12, 13, 14, 21, 22, 23, 24, 31, 32, 33, 34, 41, 42, 43, 44,
                        51, 52, 53, 54, 61, 62, 63, 64, 71, 72, 73, 74, 81, 82, 83, 84,
                        91, 92, 93, 94, 101, 102, 103, 104, 111, 112, 113, 114, 121, 122, 123, 124] //base配列
    var shuffle_base : [Int] = [ ]                                           //shuffle後のbase配列格納
    var yamahuda : [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,122,11,52,51] //山札
    var bahuda : [Int] = [73,14,12,13,43,34,0,0]                             //場札
    var bahuda_max = 8                                                       //場札最大枚数
    var yamahuda_nokori = 24                                                 //山札残数
    var huda_check = 0                                                       //任意の札枚数カウント
    var huda_flag : [Int] = [0,0,0,0,0,0,0,0]                                //任意の札の位置を記憶
    var pair_cnt = 0                                                         //ペア数カウント用変数
    var bahuda_tmp = 0                                                       //場札の一時格納変数
    var draw_ytmp = 0                                                        //Draw関数の山札格納変数
    var draw_btmp = 0                                                        //Draw関数の場札格納変数
    
    
    
    func Bahuda_check(huda_num: Int) -> Int {                               //選択した手札と合う場札が無いか検索する関数
        
        
        let huda_num = huda_num / 10
        huda_check = 0
        
        switch huda_num{
            
        case 1:
            for i in 0..<bahuda_max{
                if 10 < bahuda[i] && bahuda[i] < 15{
                    huda_flag[i] = bahuda[i]
                    huda_check += 1
                }
            }

        case 2:
            for i in 0..<bahuda_max{
                if 20 < bahuda[i] && bahuda[i] < 25{
                    huda_flag[i] = bahuda[i]
                    huda_check += 1
                }
            }
        case 3:
            for i in 0..<bahuda_max{
                if 30 < bahuda[i] && bahuda[i] < 35{
                    huda_flag[i] = bahuda[i]
                    huda_check += 1
                }
            }
        case 4:
            for i in 0..<bahuda_max{
                if 40 < bahuda[i] && bahuda[i] < 45{
                    huda_flag[i] = bahuda[i]
                    huda_check += 1
                }
            }
        case 5:
            for i in 0..<bahuda_max{
                if 50 < bahuda[i] && bahuda[i] < 55{
                    huda_flag[i] = bahuda[i]
                    huda_check += 1
                }
            }
        case 6:
            for i in 0..<bahuda_max{
                if 60 < bahuda[i] && bahuda[i] < 65{
                    huda_check += 1
                    huda_flag[i] = bahuda[i]
                }
            }
        case 7:
            for i in 0..<bahuda_max{
                if 70 < bahuda[i] && bahuda[i] < 75{
                    huda_flag[i] = bahuda[i]
                    huda_check += 1
                }
            }
        case 8:
            for i in 0..<bahuda_max{
                if 80 < bahuda[i] && bahuda[i] < 85{
                    huda_flag[i] = bahuda[i]
                    huda_check += 1
                }
            }
        case 9:
            for i in 0..<bahuda_max{
                if 90 < bahuda[i] && bahuda[i] < 95{
                    huda_flag[i] = bahuda[i]
                    huda_check += 1
                }
            }
        case 10:
            for i in 0..<bahuda_max{
                if 100 < bahuda[i] && bahuda[i] < 105{
                    huda_flag[i] = bahuda[i]
                    huda_check += 1
                }
            }
        case 11:
            for i in 0..<bahuda_max{
                if 110 < bahuda[i] && bahuda[i] < 115{
                    huda_flag[i] = bahuda[i]
                    huda_check += 1
                }
            }
        case 12:
            for i in 0..<bahuda_max{
                if 120 < bahuda[i] && bahuda[i] < 125{
                    huda_flag[i] = bahuda[i]
                    huda_check += 1
                }
            }

        default:
            break
        
        }
        
        if huda_check != 0{
            for i in 0..<bahuda_max {
                if huda_flag[i] != 0 {
                    print(huda_flag[i])
                    pair_cnt = i
                }
            }
        }else{
            print("ペアとなる札が存在しません")
        }
        
            return pair_cnt
        
    }
    
    func Bahuda_select(select_bnum: Int) -> Int {           //選択した場札を場札配列から削除しその場札を返り値にする関数
        
        bahuda_tmp = bahuda[select_bnum]
        bahuda[select_bnum] = 0
    
        
        return bahuda_tmp
    }
    
    
    func Add_bahuda_y(y: Int) -> Int {                      //空いている場札配列に選択した山札を挿入
        
        for i in 0 ..< 8 {
            
            if bahuda[i] == 0 {
                bahuda[i] = y
                return 0
            }
        }
        
        return 0
        
    }
    
    func Draw(player_num: Int) -> Int {            //山札からDrawを行う関数
        print("true")
        draw_btmp = 0
        
        draw_ytmp = yamahuda[yamahuda_nokori - 1]
        yamahuda[yamahuda_nokori - 1] = 0
        yamahuda_nokori -= 1
        
        for i in 0 ..< bahuda_max {
            if draw_ytmp/10 == bahuda[i]/10 {
                print("true2")
                draw_btmp = Bahuda_select(i)
                
                if player_num == 1 {
                    player1.Add_syutoku_yb(draw_ytmp, select_b: draw_btmp)
                }else if player_num == 2 {
                    player2.Add_syutoku_yb(draw_ytmp, select_b: draw_btmp)
                }
                
                return 0
            }
        }
        print(draw_ytmp)
        Add_bahuda_y(draw_ytmp)
        
        return 1
    }

    
    func Shuffle () -> Void {                           //シャッフル関数
        
        for i in 0 ..< 48 {                       //base配列をランダムにしてbase_shuffle配列に格納
            self.shuffle_base.append(self.base.removeAtIndex(Int(arc4random_uniform(UInt32(48 - i)))))
        }

        
        for i in 0 ..< 8 {
            player1.tehuda[i] = shuffle_base[i]
        }
        
        for i in 8 ..< 16 {
            player2.tehuda[i - 8] = shuffle_base[i]
        }
        
        for i in 16 ..< 24 {
            table.bahuda[i - 16] = shuffle_base[i]
        }
        
        for i in 24 ..< 48 {
            table.yamahuda[i - 24] = shuffle_base[i]
        }

        
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
        
        player1.player_num = 1
        player2.player_num = 2
        print("null")
      //  table.Shuffle()
        

        
        for test2 in table.bahuda {
            print(test2)
        }
        
        for test2 in table.yamahuda {
            print(test2)
        }
  
                print("")
        for test2 in player1.syutoku {
            print(test2)
        }

        
        player1.CP()
                print("")
                print(player1.syutoku_maisu)
    


        print("")
        
        print("")
        
        

        
        for test2 in table.bahuda {
            print(test2)
        }
        
        for test2 in table.yamahuda {
            print(test2)
        }
        print("")
        for test2 in player1.syutoku {
            print(test2)
        }
        
        print("")

        
//        for test3 in player1.tehuda {
//            print(test3)
//        }
//        
//        print("")
//
//        for test4 in table.yamahuda {
//            print(test4)
//        }
        
        

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