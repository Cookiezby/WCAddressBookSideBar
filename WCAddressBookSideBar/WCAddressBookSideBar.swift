//
//  WCAddressBookSideBar.swift
//  WCAddressBookSideBar
//
//  Created by cookie on 17/07/2017.
//  Copyright © 2017 cookie. All rights reserved.
//

import Foundation
import UIKit

class WCSideBarBlock: UIView {
    
    var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "A"
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
    }
    
    override func layoutSubviews() {
        label.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class IndicateView: UIView {
    
    let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "blockBG"))
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        addSubview(label)
        label.frame =  CGRect(x: -5, y: 0, width: frame.width, height: frame.height)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol WCAddressBookDelegate {
    var indicateView: IndicateView { get }
    func indexChanged(newIndex: Int)
}

class WCAddressBookSideBar: UIView {
    
    var sideBlocks = [WCSideBarBlock]()
    var currentIndex: Int = 0
    var delegate: WCAddressBookDelegate!
    let forceFeedBack: UISelectionFeedbackGenerator!
 
    override init(frame: CGRect) {
        forceFeedBack = UISelectionFeedbackGenerator()
        forceFeedBack.prepare()
        super.init(frame: frame)
        initBlocks()
    }
    
    func initBlocks() {
        let originX = (frame.height - 390) / 2
        for i in 0...25 {
            let block = WCSideBarBlock(frame: CGRect(x: frame.width-15, y: originX + CGFloat(i * 15), width: 15, height: 15))
            block.label.text = String(UnicodeScalar(UInt8(65 + i)))
            sideBlocks.append(block)
            addSubview(block)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first?.location(in: self)
        let index = Int(( (point?.y)! - (frame.height - 390) / 2 ) / 15)
        if (index != currentIndex && index <= 26 && index >= 1) {
            self.delegate.indicateView.isHidden = false
            currentIndex =  index
            forceFeedBack.selectionChanged()
            print("\(currentIndex)")
            delegate.indexChanged(newIndex: index)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first?.location(in: self)
        let index = Int(( (point?.y)! - (frame.height - 390) / 2 ) / 15)
        if (index != currentIndex && index <= 26 && index >= 1 ) {
            self.delegate.indicateView.isHidden = false
            currentIndex =  index
            forceFeedBack.selectionChanged()
            print("\(currentIndex)")
            delegate.indexChanged(newIndex: index)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.delegate.indicateView.isHidden = true
    }
    
}
