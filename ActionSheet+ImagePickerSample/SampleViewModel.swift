//
//  SampleViewModel.swift
//  ActionSheet+ImagePickerSample
//
//  Created by cano on 2018/11/22.
//  Copyright © 2018 deskplate. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SampleViewModel  {

    // Inputs
    typealias Inputs = (
        Signal<Void>
    )

    typealias Wireframe  = (
        SampleWireframeType
    )

    // Outputs
    let selectedImage: BehaviorRelay<UIImage?>

    private let disposeBag = DisposeBag()

    init(inputs: Inputs, wireframe: Wireframe) {

        self.selectedImage = wireframe.selectedImage
        
        // アクションシート表示
        inputs.emit(onNext: { _ in
            // アクションシート選択項目
            var actions = [ActionSheetItem<UIImagePickerControllerSourceType>(
                                title: "ライブラリから選択",
                                selectType: UIImagePickerControllerSourceType.photoLibrary,
                                style: .default)]

            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                actions.insert(ActionSheetItem<UIImagePickerControllerSourceType>(
                                    title: "カメラを起動",
                                    selectType: UIImagePickerControllerSourceType.camera,
                                    style: .default), at: 0)
            }
            wireframe.shwoActionSheet(title: "画像設定", message: "選択してください。", actions: actions)
        })
        .disposed(by: self.disposeBag)
    }
}
