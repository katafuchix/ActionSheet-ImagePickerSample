//
//  SampleWireframe.swift
//  ActionSheet+ImagePickerSample
//
//  Created by cano on 2018/11/22.
//  Copyright © 2018 deskplate. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol SampleWireframeType {
    func shwoActionSheet<T>(title: String, message: String, actions: [ActionSheetItem<T>])
    var selectedImage: BehaviorRelay<UIImage?> { get }
}


class SampleWireframe: SampleWireframeType {

    var viewController: UIViewController? { return sampleViewController }
    private weak var sampleViewController: SampleViewController?

    private let disposeBag = DisposeBag()

    let selectedImage: BehaviorRelay<UIImage?>

    init(view: SampleViewController) {
        self.sampleViewController = view
        self.selectedImage = BehaviorRelay<UIImage?>(value: nil)
    }

    // アクションシートを起動してUIImagePickerController起動
    func shwoActionSheet<T>(title: String, message: String, actions: [ActionSheetItem<T>]) {
        viewController?.showActionSheet(title: title, message: message, actions: actions)
            .subscribe({ [unowned self] event in
                if let sourceType = event.element as? UIImagePickerController.SourceType {
                    switch sourceType {
                    case .camera:
                        self.launchPhotoPicker(.camera)
                    case .photoLibrary:
                        self.launchPhotoPicker(.photoLibrary)
                    case .savedPhotosAlbum:
                        break
                    }
                }
            })
            .disposed(by: self.disposeBag)
    }

    // UIImagePickerControllerの起動と選択した画像の処理
    private func launchPhotoPicker(_ type: UIImagePickerController.SourceType) {
        UIImagePickerController.rx.createWithParent(self.viewController) { picker in
                picker.sourceType = type
                picker.allowsEditing = true
            }
            .flatMap { $0.rx.didFinishPickingMediaWithInfo }
            .take(1)
            .map { info in return info[UIImagePickerControllerOriginalImage] as? UIImage }
            .bind(to: self.selectedImage)
            .disposed(by: self.disposeBag)
    }
}

