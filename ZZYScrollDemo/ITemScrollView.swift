//
//  ITemScrollView.swift
//  test
//
//  Created by zzy on 2018/5/23.
//  Copyright © 2018年 zzy. All rights reserved.
//

import UIKit

class ITemScrollView: UIView {
    
    typealias clickBtnBlock = (Int) -> Void
    
    let staticLineSpace:CGFloat = 40
    var clickBack:clickBtnBlock
    
    lazy var lineSpace:CGFloat = {
        var contentWidth:CGFloat = 0.0
        for width in self.widths
        {
            contentWidth = contentWidth + width + self.staticLineSpace
        }
        
        if contentWidth < self.frame.width
        {
            var itemWidths:CGFloat = 0.0
            
            
            for width in self.widths
            {
                itemWidths = itemWidths + width
            }
            return (self.frame.width - itemWidths) / CGFloat(self.widths.count)
        }
        return self.staticLineSpace
        
    }()
    var titleAry:[String]
    var lastBtn:UIButton = UIButton()
    var targetBtns:[UIButton] = []
    
    lazy var allWidth:CGFloat = {
        var contentWidth:CGFloat = 0.0
        for width in self.widths
        {
            contentWidth = contentWidth + width + self.lineSpace
        }
        return contentWidth
    }()
    
    lazy var backView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.frame = CGRect.init(x: 0, y: 0, width: self.allWidth, height: self.frame.height)
        return view
        
    }()
    
    lazy var selectView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.frame = CGRect.init(x: self.lineSpace / 2.0 , y: 0, width: self.widths.first ?? 0, height: self.frame.height)
        return view
    }()
    
    
    lazy var scrollView:UIScrollView = {
        let view = UIScrollView()
        view.bounces = false;
        view.frame = self.bounds
        view.contentSize = CGSize.init(width: self.allWidth, height: self.frame.height - 2)
        view.showsHorizontalScrollIndicator = false
        view.addSubview(self.backView)
        self.backView.insertSubview(self.selectView, at: 0)
        var oringX:CGFloat  = 0.0
        for i in 0 ..< self.titleAry.count
        {
            let btn:UIButton = UIButton()
            
            btn.frame = CGRect.init(x: oringX, y: 0, width: self.widths[i] + self.lineSpace, height: self.frame.height - 2)
            btn.setTitle(self.titleAry[i], for: UIControlState.normal)
            btn.addTarget(self, action: #selector(clickBtn(sender:)), for: UIControlEvents.touchUpInside)
            btn.setTitleColor(UIColor.red, for: UIControlState.selected)
            btn.setTitleColor(UIColor.black, for: UIControlState.normal)
            btn.backgroundColor = UIColor.gray
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btn.tag = i
            if i == 0 {
                btn.isSelected = true
                self.lastBtn = btn
            }
            oringX = oringX + self.widths[i] + self.lineSpace
            self.backView.addSubview(btn)
            self.targetBtns.append(btn)
        }
        return view
        
    }()
    func setItemtarget(index:Int) {
        guard index < self.targetBtns.count else {
            return
        }
        self.clickBtnResponse(sender: self.targetBtns[index])
    }
    
    lazy var widths:[CGFloat] = {
        var allWidth:[CGFloat] = []
        for str:String in self.titleAry {
            let width = str.caculateWidth(font: UIFont.systemFont(ofSize: 15))
            allWidth.append(width)
        }
        return allWidth;
    }()
    @objc func clickBtn(sender:UIButton){
        self.clickBtnResponse(sender: sender)
        self.clickBack(sender.tag)
    }
    func clickBtnResponse(sender:UIButton)
    {
        if sender.isEqual(self.lastBtn) {
            return;
        }
        
        self.lastBtn.isSelected = false
        sender.isSelected = true
        var oringX:CGFloat = self.lineSpace / 2.0
        for i in 0 ..< sender.tag {
             oringX = oringX + self.lineSpace + self.widths[i]
        }
        UIView.animate(withDuration: 0.3, animations: {
            var frame = self.selectView.frame
            frame.origin.x = oringX
            frame.size.width = self.widths[sender.tag]
            self.selectView.frame = frame
        }) { (complect) in
            if complect
            {
                self.scrollToorigX(orig: self.selectView.frame.midX - self.frame.width / 2.0)
            }
        }
        self.lastBtn = sender
    }
    func scrollToorigX(orig:CGFloat) {
        if orig <= 0 {
        self.scrollView.setContentOffset(CGPoint.init(x: 0.0, y: 0.0), animated: true)
            return
        }
        else if orig + self.frame.width >= allWidth {
            self.scrollView.setContentOffset(CGPoint.init(x: self.allWidth - self.frame.width, y: 0.0), animated: true)
            return
        }
       
       self.scrollView.setContentOffset(CGPoint.init(x: orig, y: 0), animated: true)
    }
    
    
    init(frame: CGRect,dataAry:[String], back:@escaping clickBtnBlock) {
        self.titleAry = dataAry
        self.clickBack = back
        super.init(frame: frame)
        self.addSubview(scrollView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
