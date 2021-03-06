//
//  MyContentViewController.swift
//  NewProduct
//
//  Created by 狍子 on 2021/6/23.
//

import UIKit

class MyContentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    //MARK: - Life Cycle - 生命周期
    //MARK: - Initalization - 初始化
    //MARK: - SubViews - 子视图
    //MARK: - Button Action - 点击事件
    //MARK: - Utility - 多用途(功能)方法
    @IBOutlet weak var topView: UIView!
//    @IBOutlet weak var myTableView: UITableView!
    /**scrollerview2的父视图*/
    @IBOutlet weak var tabBottomView: UIView!
    private var btnAry = [UIButton]()
    private var lineView = UIView()

    private var lastbtn = UIButton()
    private let scrView1 = UIScrollView()
    private var scrView2 = UIScrollView()
    //"首页"-0,"古典"-1,"民族"-2,"芭蕾"-3,"现代"-4,"当代"-5
    private var senderTag = 0
    private let titleArray = ["vr图片","vr视频"];
    private  let firstCell = "FirstMyContentTableViewCell"
    private  let firstCellID = "FirstMyContentTableViewCellID"

    //MARK: - Life Cycle - 生命周期

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

//        initMyTableView()
         
        self.fd_prefersNavigationBarHidden = true
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            self.initscrollerView()

            self.initscrollerView2()
        }
       
    }
//    override func viewWillAppear(_ animated: Bool) {
       
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
//            for btn:UIButton in self.btnAry {
//                if btn.isSelected {
//                    self.lineView1.center.x = btn.center.x
//                }
//            }
//
//        }
//    }
    //MARK: - Initalization - 初始化

    private  func initscrollerView() -> Void {
        scrView1.frame = self.topView.bounds
//        scrView1.contentSize = CGSize(width: 85*titleArray.count+70, height: 35)
        scrView1.contentSize = CGSize(width: SCR_W, height: 35)

        //  水平
        scrView1.showsHorizontalScrollIndicator = false
         // 垂直
        scrView1.showsVerticalScrollIndicator = false
        for i in 0...titleArray.count-1 {
            
//            let btn = UIButton.init(frame: CGRect(x: 15+85*i, y: 1, width: 85, height: 33))
            let btn = UIButton.init(frame: CGRect(x: Int(SCR_W)/titleArray.count*i, y: 1, width: Int(SCR_W)/titleArray.count, height: 33))

            btn.setAttributedTitle(UIButton.getSystemABTbody(titleArray[i], fontInteger: 1, size: 15, color: .black, lineSpacing: 0), for: .normal)
            btn.setAttributedTitle(UIButton.getSystemABTbody(titleArray[i], fontInteger: 1, size: 15, color: seDiao_Color1, lineSpacing: 0), for: .selected)
            btn.addTarget(self, action: #selector(btnAction(sender:)), for: .touchUpInside)
            btn.tag = 620+i
            if i == 0 {
                btn.isSelected = true
                lastbtn = btn
            }
            btnAry.append(btn)
            scrView1.addSubview(btn)
        }
        topView.addSubview(scrView1)
        
        let btn:UIButton = btnAry[0]
        self.topView.addSubview(self.lineView1)
        lineView = self.lineView1
        self.lineView1.mas_makeConstraints { (make) in
            make?.bottom.mas_equalTo()(self.topView)?.offset()(0)
            make?.centerX.mas_equalTo()(btn)?.offset()(0)
            make?.width.mas_equalTo()(35)
            make?.height.mas_equalTo()(2)


        }
    }
    
    @objc func btnAction(sender:UIButton) {
        if lastbtn == sender {
            return
        }
        
        lineView.center.x = sender.center.x
        sender.isSelected = true
        lastbtn.isSelected = false
        if sender.tag == 620 {
            scrView2.contentOffset.x = 0
            senderTag = 0
        }else if sender.tag == 621 {
            scrView2.contentOffset.x = SCR_W
            senderTag = 1
        }else if sender.tag == 622 {
            scrView2.contentOffset.x = SCR_W*2
            senderTag = 2
        }else if sender.tag == 623 {
            scrView2.contentOffset.x = SCR_W*3
            senderTag = 3
        }else if sender.tag == 624 {
            scrView2.contentOffset.x = SCR_W*4
            senderTag = 4
        }else if sender.tag == 625 {
            scrView2.contentOffset.x = SCR_W*5
            senderTag = 5
        }
        
        lastbtn = sender
    }
    
    private  func initscrollerView2() -> Void {
        
        scrView2.frame = self.tabBottomView.bounds
        let h = self.tabBottomView.bounds.size.height
        
        scrView2.contentSize = CGSize(width: Int(SCR_W)*titleArray.count, height: Int(h))

        //  水平
        scrView2.showsHorizontalScrollIndicator = true
         // 垂直
        scrView2.showsVerticalScrollIndicator = false
        scrView2.isUserInteractionEnabled = true
        scrView2.isPagingEnabled = true
        scrView2.delegate = self
        for i in 0...titleArray.count-1 {
            if i == 0 {
                self.tableView1.frame = CGRect(x: Int(SCR_W)*i, y: 0, width: Int(SCR_W), height: Int(h))
                scrView2.addSubview(tableView1)
            }else if i == 1{
                self.tableView2.frame = CGRect(x: Int(SCR_W)*i, y: 0, width: Int(SCR_W), height: Int(h))
                scrView2.addSubview(tableView2)

            }
    
        }
        tabBottomView.addSubview(scrView2)
    }
    private lazy var lineView1: UIView = {
        
        let lineView1 = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 2))
        lineView1.layer.cornerRadius = 2
        lineView1.backgroundColor = seDiao_Color1
        
        return lineView1
    }()
    private lazy var tableView1: UITableView = {
        
//        let tableView1 = UITableView(frame: CGRect.zero, style: .plain)
        let tableView1 = UITableView()
        tableView1.dataSource = self
        tableView1.delegate = self
        
        tableView1.separatorStyle = .none
        tableView1.showsVerticalScrollIndicator = false
        tableView1.tag = 600

        tableView1.rowHeight = 65
        tableView1.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        tableView1.register(UINib(nibName: firstCell, bundle: nil), forCellReuseIdentifier: firstCellID)
      
        return tableView1
    }()
    private lazy var tableView2: UITableView = {
        
//        let tableView1 = UITableView(frame: CGRect.zero, style: .plain)
        let tableView2 = UITableView()
        tableView2.dataSource = self
        tableView2.delegate = self
        tableView2.tag = 601

        tableView2.separatorStyle = .none
        tableView2.showsVerticalScrollIndicator = false
        
        tableView2.rowHeight = 65
        tableView2.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        tableView2.register(UINib(nibName: firstCell, bundle: nil), forCellReuseIdentifier: firstCellID)
     
        return tableView2
    }()
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 180
        }else{
            let array = ["","","","","","","",""]
            
            if (array.count%2 == 0) {
//                return ((SCR_W-40)/2+5)*array.count/2+(array.count/2*10)
                
                let row_h1 = SCR_W-40
                let row_h2 = row_h1/2+5
                let row_h3 = Int(row_h2)*array.count/2
                
                let row_h4 = array.count/2*10

                return CGFloat(row_h3 + row_h4 + 55)
            }else{
//                return ((SCR_W-40)/2+5)*(array.count+1)/2+((array.count+1)/2*10)
                return 20
            }
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell:FirstMyContentTableViewCell = tableView.dequeueReusableCell(withIdentifier: firstCellID, for: indexPath) as! FirstMyContentTableViewCell
        
            return cell
       

    }
    //MARK: - SubViews - 子视图
    //MARK: - Button Action - 点击事件

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(SCR_W)
        print(scrView2.contentOffset.x)
        if scrView2.isDragging == true {
            if scrView2.contentOffset.x >= 0 && scrView2.contentOffset.x < SCR_W/2 {
//                let btn:UIButton = view.viewWithTag(620) as! UIButton
                let btn:UIButton = btnAry[0]

                if lastbtn == btn {
                    return
                }
                UIView.animate(withDuration: 0.3) {
                    self.lineView.center.x = btn.center.x
                }
                senderTag = 0
    //            scrView1.contentOffset.x = 0
                btn.isSelected = true
                lastbtn.isSelected = false
                lastbtn = btn
                
            }else if scrView2.contentOffset.x >= SCR_W/2 && scrView2.contentOffset.x < SCR_W*2-SCR_W/2 {
//                let btn:UIButton = view.viewWithTag(621) as! UIButton
                let btn:UIButton = btnAry[1]

                if lastbtn == btn {
                    return
                }
                UIView.animate(withDuration: 0.3) {
                    self.lineView.center.x = btn.center.x
                }
                senderTag = 1
    //            scrView1.contentOffset.x = 0
                btn.isSelected = true
                lastbtn.isSelected = false
                lastbtn = btn
                print("11111")

            }
        }

    }
    
    /**SecondHomeCenterTableViewCell-Delegate*/
    func CellCollectionAction(cell: SecondHomeCenterTableViewCell, indexPath: NSIndexPath) {
        //"首页"-0,"古典"-1,"民族"-2,"芭蕾"-3,"现代"-4,"当代"-5
        JumpDetailsVC()
        switch senderTag {
        case 0:
            print("首页")
            print(indexPath)

            break
        case 1:
            print("古典")
            print(indexPath)

            break
        case 2:
            print("民族")
            print(indexPath)

            break
        case 3:
            print("芭蕾")
            print(indexPath)

            break
        case 4:
            print("现代")
            print(indexPath)

            break
        case 5:
            print("当代")
            print(indexPath)

            break
        default:
            break
        }
    }
    /**上传作品*/
    @IBAction func addContentButtonAction(_ sender: Any) {
        navigationController?.pushViewController(UploadContentViewController(), animated: true)
    }
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    //MARK: - Utility - 多用途(功能)方法
    func JumpDetailsVC() -> Void {
        let playerModel = WMPlayerModel()
                
//            playerModel.videoURL = [NSURL URLWithString:videoModel.video_url];
        playerModel.videoURL = URL.init(string: "http://vfx.mtime.cn/Video/2019/03/09/mp4/190309153658147087.mp4")
        
        
        //    playerModel.videoURL = [NSURL URLWithString:@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"];
            playerModel.title = "鲁智深拳打镇关西"
        let detailVC = DetailSViewController()
        detailVC.hidesBottomBarWhenPushed = true
        detailVC.playerModel = playerModel;
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    //MARK: - Network request - 网络请求

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
