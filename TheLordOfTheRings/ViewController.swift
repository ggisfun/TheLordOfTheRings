//
//  ViewController.swift
//  TheLordOfTheRings
//
//  Created by Adam Chen on 2024/8/10.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var seriesSegmentedControl: UISegmentedControl!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var introSegmentedControl: UISegmentedControl!
    @IBOutlet weak var trailerWebView: WKWebView!
    @IBOutlet weak var introduceTextView: UITextView!
    
    //電影資料
    let movieList = [
        [
            (name:"魔戒首部曲：魔戒現身",image: "Ring1", ytUrl: "https://www.youtube.com/embed/jdvaHD492W8", introduce: "一位名叫佛羅多的年輕人，無意間得到一枚有著神秘力量的戒指，卻發現這枚戒指原來是黑暗魔王索倫所擁有。幾經波折後，他決定摧毀魔戒，以免索倫奪回去鞏固自己的勢力。巫師甘道夫、精靈、矮人、哈比人和人類於是組成魔戒遠征隊，協助佛羅多前往索倫統治的「中土世界」，將魔戒丟入末日火山摧毀。旅途中索倫派出怪獸追殺佛羅多一群人，魔戒也開始腐蝕人心，讓人產生難以抵擋的慾望，考驗著每位接觸戒指的意志力。"),
            (name:"魔戒二部曲：雙城奇謀",image: "Ring2", ytUrl: "https://www.youtube.com/embed/GUmSiIf9qIA", introduce: "魔戒遠征隊四分五裂、分道揚鑣，每位成員都將遭遇想像不到的敵人與難關。佛羅多和山姆在山區迷路，遇到長期受到魔戒影響，身心嚴重扭曲的生物咕嚕；被抓走的哈比人梅里和皮聘也從強獸人手中掙脫；亞拉岡、精靈弓箭手勒茍拉斯和矮人金靂發現洛汗國國王希優頓聽信巧言，對他們頗有敵意；甘道夫在和炎魔進行一場驚天動地的決鬥之後重獲新生，竟然變成法力更強大的白袍巫師，將再度加入這場神聖的正邪大戰。"),
            (name:"魔戒三部曲：王者再臨",image: "Ring3", ytUrl: "https://www.youtube.com/embed/ytjIH4yqQj8", introduce: "遠征隊的旅程即將畫下句點，中土世界的真正大戰即將到來，眾人集合所有力量來擊敗索倫。儘管不停遭受失落，遠征隊還是持續前往他們這一生最重要的一場戰役，合作無間分散索倫的注意力，好讓佛羅多有機會完成他的使命，將魔戒摧毀。")
        ],
        [
            (name:"哈比人：意外旅程",image: "Hobbit1", ytUrl: "https://www.youtube.com/embed/3G8szPxwvSs", introduce: "第三紀元的中土大陸上，本過著安逸日子的哈比人比爾博·巴金斯被灰袍巫師甘道夫半強迫地加入了由矮人領袖索林·橡木盾領導的十三矮人遠征軍，一同踏上了收復被惡龍史矛革佔據的孤山矮人王國的旅程。途中他們經歷了許多冒險，值遇了食人妖、哥布林、半獸人與座狼等邪惡生物，比爾博更因緣湊巧地意外拾獲了一枚神奇的金戒指...。"),
            (name:"哈比人：荒谷惡龍",image: "Hobbit2", ytUrl: "https://www.youtube.com/embed/7omKFSKS2RE", introduce: "比爾博與矮人遠征軍繼續被阿索格領導的半獸人所追殺，他們歷經千辛萬苦終於抵達旅程的終點——孤山，這時身為「飛賊」比爾博必須要獨自一人面對兇猛的史矛革。同時，甘道夫在老堡壘多爾哥多發覺了敵人的陰謀，沉寂已久的黑暗魔君索倫正集結著半獸人大軍，以向中土大陸開戰...。"),
            (name:"哈比人：五軍之戰",image: "Hobbit3", ytUrl: "https://www.youtube.com/embed/4RcpxU5TIDY", introduce: "比爾博與矮人遠征軍雖已順利收復孤山，但在無意中激怒史矛革，使牠摧毀了長湖鎮。薩魯曼、愛隆與凱蘭崔爾等聖白議會成員至多爾哥多抵擋索倫與九戒靈；然而索倫的半獸人軍隊已在阿索格帶領下離去，意圖奪取孤山，迫使精靈、人類、矮人三大種族必須拋棄彼此間的前嫌，團結一致來對抗敵人...。")
        ]
    ]
    
    var pageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
    }
    
    //切換系列魔戒or哈比人
    @IBAction func seriesChange(_ sender: Any) {
        updateUI()
    }
    
    //下一頁button與左滑共用
    @IBAction func nextPage(_ sender: Any) {
        pageIndex += 1
        if pageIndex >= movieList[seriesSegmentedControl.selectedSegmentIndex].count {
            pageIndex = 0
        }
        updateUI()
    }
    
    //上一頁button與右滑共用
    @IBAction func previousPage(_ sender: Any) {
        pageIndex -= 1
        if pageIndex < 0 {
            pageIndex = movieList[seriesSegmentedControl.selectedSegmentIndex].count - 1
        }
        updateUI()
    }
    
    //切換簡介or預告片
    @IBAction func introChange(_ sender: Any) {
        typeChange()
    }
    
    //更新畫面
    func updateUI() {
        let movieData = movieList[seriesSegmentedControl.selectedSegmentIndex]
        movieImageView.image = UIImage(named: movieData[pageIndex].image)
        movieNameLabel.text = movieData[pageIndex].name
        introduceTextView.text! = movieData[pageIndex].introduce
        pageControl.currentPage = pageIndex
        
        let url = URL(string: movieData[pageIndex].ytUrl)
        let request = URLRequest(url: url!)
        trailerWebView.load(request)
        typeChange()
    }
    
    //判斷要顯示簡介or預告片
    func typeChange() {
        if introSegmentedControl.selectedSegmentIndex == 0 {
            introduceTextView.isHidden = false
            trailerWebView.isHidden = true
        }else {
            introduceTextView.isHidden = true
            trailerWebView.isHidden = false
        }
    }

}

