//
//  HomeCenterViewController.swift
//  Dzbz
//
//  Created by 狍子 on 2021/3/16.
//

import UIKit

class HomeCenterViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,JLCycleScrollerViewDelegate{

    
    //MARK: - Life Cycle - 生命周期
    //MARK: - Initalization - 初始化
    //MARK: - SubViews - 子视图
    //MARK: - Button Action - 点击事件
    //MARK: - Utility - 多用途(功能)方法
    //MARK: - Network request - 网络请求
    @IBOutlet weak var topView: UIView!
//    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var loginStatusButton: UIButton!
    /**scrollerview2的父视图*/
    @IBOutlet weak var tabBottomView: UIView!
    private var btnAry = [UIButton]()
    private var lineView = UIView()

    private var lastbtn = UIButton()
    private let scrView1 = UIScrollView()
    private var scrView2 = UIScrollView()
    
  
    var imgListmodelAry = [Any]()
    var videoListmodelAry = [Any]()
    var staticvrmodel : HomeCenterstaticModel?

    @IBOutlet weak var userNameButton: UIButton!
    //"首页"-0,"古典"-1,"民族"-2,"芭蕾"-3,"现代"-4,"当代"-5
    private var senderTag = 0
    private  let firstCell = "NewFirstHomeCenterTableViewCell"
    private  let firstCellID = "NewFirstHomeCenterTableViewCellID"
    private  let secondCell = "NewSecondHomeCenterTableViewCell"
    private  let secondCellID = "NewSecondHomeCenterTableViewCellID"
    private  let thirdCell = "NewThirdHomeCenterTableViewCell"
    private  let thirdCellID = "NewThirdHomeCenterTableViewCellID"


    //MARK: - Life Cycle - 生命周期

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

//        initMyTableView()
         
        self.fd_prefersNavigationBarHidden = true
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) { [self] in
            self.initscrollerView()

//            self.initscrollerView2()
            self.tableView1.frame = self.tabBottomView.bounds
            self.tabBottomView.addSubview(self.tableView1)
            self.tableView1.backgroundColor = UIColor.clear
            
            if UserInfoManager.getLoginStatus() == "true" {
                loginStatusButton.setTitle("已登录", for: .normal)
            }else{
                loginStatusButton.setTitle("欢迎您，请登录", for: .normal)

            }
            self.getHomeRequest()
        }
       
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        UIApplication.shared.statusBarStyle = .lightContent
      
    }
    //MARK: - Initalization - 初始化
    private lazy var tableView1: UITableView = {
        
        let tableView1 = UITableView(frame: self.tabBottomView.bounds, style: .grouped)
//        let tableView1 = UITableView()
        tableView1.dataSource = self
        tableView1.delegate = self
        
        tableView1.separatorStyle = .none
        tableView1.showsVerticalScrollIndicator = false
        tableView1.tag = 700
//        tableView1.sectionHeerHeight = 0
        tableView1.sectionFooterHeight = 0
        tableView1.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -20, right: 0)
        tableView1.register(UINib(nibName: firstCell, bundle: nil), forCellReuseIdentifier: firstCellID)
        tableView1.register(UINib(nibName: secondCell, bundle: nil), forCellReuseIdentifier: secondCellID)
        tableView1.register(UINib(nibName: thirdCell, bundle: nil), forCellReuseIdentifier: thirdCellID)
        return tableView1
    }()
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return 50

        }
        return 0.000000001
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2 {
            let vi = UIView.init(frame: CGRect(x: 0, y: 0, width: SCR_W, height: 50))
            let img = UIImageView.init(frame: CGRect(x: 0, y: 19, width: 5, height: 13))
            img.image = UIImage.init(named: "矩形 5")
            vi.addSubview(img)
            
            let lab = UILabel.init(frame: CGRect(x: 15, y: 0, width: SCR_W, height: 50))
            
            lab.text = "推荐VR全景图集"
            lab.font = UIFont.boldSystemFont(ofSize: 14)
            lab.textColor = RGB_Color(30,28,28,1.0)
    //            UIColor.init(red: 30/255.0, green: 28/255.0, blue: 28/255.0, alpha: 1.0)
            vi.addSubview(lab)
            vi.backgroundColor = UIColor.white
            return vi
        }else{
            let vi = UIView.init(frame: CGRect(x: 0, y: 0, width: SCR_W, height: 0.000000001))
            vi.backgroundColor = UIColor.clear
            return vi
        }

        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==2 {
            return 3
        }
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return (9*(SCR_W))/16
        case 1:
            return 83
        case 2:
            return (9*(SCR_W))/16+60
        default:
            break
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell:NewFirstHomeCenterTableViewCell = tableView.dequeueReusableCell(withIdentifier: firstCellID, for: indexPath) as! NewFirstHomeCenterTableViewCell
//            NSMutableArray *aryM = [NSMutableArray array];
//            NSMutableArray *titlearyM = [NSMutableArray array];
//            for (int i=0; i<self.lunboarray.count; i++) {
//
//                if (i<4) {
//                    LaborLunBoModel *model = self.lunboarray[i];
//                    [aryM addObject:model.thumbnail];
//                    [titlearyM addObject:model.title];
//                }
//            }
        
                cell.cycleView.titlessourceArray = ["",""]
                cell.cycleView.sourceArray = ["http://111.74.0.243:81/group1/M00/00/0D/L2-LSl-8ZsuAc8f8AAVjOCZF3GU183.png","http://111.74.0.243:81/group1/M00/00/0D/L2-LSl-8ZsuAc8f8AAVjOCZF3GU183.png"]
                cell.cycleView.delegate = self;
                cell.cycleView.pageControl_centerX = 0;

            
            return cell
        }else if indexPath.section == 1{
            let cell:NewSecondHomeCenterTableViewCell = tableView.dequeueReusableCell(withIdentifier: secondCellID, for: indexPath) as! NewSecondHomeCenterTableViewCell
            if self.staticvrmodel != nil {
                cell.reloadData(model: self.staticvrmodel!)
            }
            
            return cell
        }else{
            let cell:NewThirdHomeCenterTableViewCell = tableView.dequeueReusableCell(withIdentifier: thirdCellID, for: indexPath) as! NewThirdHomeCenterTableViewCell
            
            
            return cell
        }

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DQVRWKViewController()
            vc.urlstring = "http://www.expoon.com/26925/"
        vc.hidesBottomBarWhenPushed = true

        navigationController?.pushViewController(vc, animated: true)
        

    }
    private  func initscrollerView() -> Void {

    }
   /**点击欢迎您，请登录*/
    @IBAction func userNameButtonAction(_ sender: Any) {
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
    /**
     点击轮播Cell代理
     @param index 点击的<0.1.2...>
     @param sourceArray 传入进来的原始数据
     */
     func jl_cycleScrollerView(_ view: JLCycleScrollerView, didSelectItemAt index: Int, sourceArray: [Any]) {
        
    }
    //MARK: - Network request - 网络请求
    /**首页数据*/
    private  func getHomeRequest() -> Void {
        var para = [String:String]()
        para["userId"] = String.init(UserInfoManager.getUid())
        
//        var resultDic = [String: Any]()
//        resultDic["body"] = "phoneNumber=16870714471&pwd=12345"
        HomeRequestDatas().RequestWithgetHome(parameters: para) { (result) in
//            let mo:registerModel = result as! registerModel
//            print(mo.birthday)
            
            let imgListAry = result["imgList"] as! Array<Any>
            let videoListAry = result["imgList"] as! Array<Any>
            let staticvr = result["vrStatistic"] as? NSDictionary

            self.imgListmodelAry = [HomeCenterbanerModel].deserialize(from: imgListAry)!
            self.videoListmodelAry = [HomeCentervideoModel].deserialize(from: videoListAry)!
            self.staticvrmodel = HomeCenterstaticModel.deserialize(from: staticvr)
           
            self.tableView1.reloadData()
//            deserialize(from: result["imgList"])
            
//            deserialize(from: data["vrStatistic"] as? NSDictionary)
            
        } failure: { (error) in
            
        }

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
