//
//  UIViewController.swift
//  ActionSheet+ImagePickerSample
//
//  Created by cano on 2018/11/22.
//  Copyright © 2018 deskplate. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UIViewController {
    // Observable化したアクションシートの表示
    func showActionSheet<T>(title: String?, message: String?, cancelMessage: String = "キャンセル", actions: [ActionSheetItem<T>]) -> Observable<T> {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)

        return actionSheet.addAction(actions: actions, cancelMessage: cancelMessage, cancelAction: nil)
            .do(onSubscribed: { [weak self] in
                self?.present(actionSheet, animated: true, completion: nil)
            })
    }
}
