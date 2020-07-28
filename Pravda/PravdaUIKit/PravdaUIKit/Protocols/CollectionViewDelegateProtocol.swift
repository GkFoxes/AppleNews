//
//  CollectionViewDelegateProtocol.swift
//  PravdaUIKit
//
//  Created by Дмитрий Матвеенко on 28.07.2020.
//  Copyright © 2020 GkFoxes. All rights reserved.
//

protocol CollectionViewDelegateProtocol: UICollectionViewDelegate {
	var selectedItemHandler: ((IndexPath) -> Void)? { get set }
}
