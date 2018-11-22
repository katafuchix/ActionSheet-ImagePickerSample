//
//  UIAlertController.swift
//  ActionSheet+ImagePickerSample
//
//  Created by cano on 2018/11/22.
//  Copyright © 2018 deskplate. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// アクションシートの項目を指定する構造体
struct ActionSheetItem<Type> {
    let title: String
    let selectType: Type
    let style: UIAlertActionStyle
}

extension UIAlertController {
    // アクションシートに項目を追加し、Observable化
    func addAction<T>(actions: [ActionSheetItem<T>], cancelMessage: String, cancelAction: ((UIAlertAction) -> Void)?) -> Observable<T> {
        return Observable.create { [weak self] observer in
            actions.map { action in
                return UIAlertAction(title: action.title, style: action.style) { _ in
                        observer.onNext(action.selectType)
                        observer.onCompleted()
                    }
                }.forEach { action in
                    self?.addAction(action)
                }

            self?.addAction(UIAlertAction(title: cancelMessage, style: .cancel) {
                cancelAction?($0)
                observer.onCompleted()
            })

            return Disposables.create {
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
}
