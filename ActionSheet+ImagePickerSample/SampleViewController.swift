//
//  ViewController.swift
//  ActionSheet+ImagePickerSample
//
//  Created by cano on 2018/11/22.
//  Copyright © 2018 deskplate. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SampleViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var button: UIButton!

    private var viewModel: SampleViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // ViewModel初期化
        viewModel = SampleViewModel(
                inputs: button.rx.tap.asSignal(),
                wireframe: SampleWireframe(view: self)
            )

        // 画像選択
        viewModel.selectedImage
            .asObservable()
            .bind(to: self.imageView.rx.image)
            .disposed(by: self.disposeBag)

    }
}

