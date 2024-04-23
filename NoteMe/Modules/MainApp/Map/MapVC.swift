//
//  MapVC.swift
//  NoteMe
//
//  Created by PavelKrm on 22.03.24.
//

import UIKit
import SnapKit
import MapKit

@objc protocol MapViewModelProtocol {
    
    var setRegion: ((MKCoordinateRegion) -> Void)? { get set }
    
    func makeTableView() -> UITableView
    func viewDidLoad()
    @objc func cancel()
    @objc func selectLocation(region: MKCoordinateRegion,
                              view: UIView,
                              circle: UIView,
                              mapView: MKMapView)
}

final class MapVC: UIViewController {
    
    private lazy var contentView: UIView = .contentView()
    private lazy var tableView: UITableView = viewModel.makeTableView()
    
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = L10n.searchPH
        search.layer.cornerRadius = 18.0
        search.backgroundColor = .appGray
        search.delegate = self
        return search
    }()
    
    private lazy var cancelSearchButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.appYellow, for: .normal)
        button.setTitle(L10n.cancelSearch, for: .normal)
        button.titleLabel?.font = .appFont.withSize(16.0)
        return button
    }()
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.isRotateEnabled = false
        map.showsUserLocation = true
        return map
    }()
    
    private lazy var circleImage: UIImageView = {
        let circle = UIImageView()
        circle.image = .General.region
        return circle
    }()
    
    private lazy var selectButton: UIButton =
        .yellowRoundedButton(L10n.select)
        .withAction(self, #selector(selectDidTap))
    
    private lazy var cancelButton: UIButton =
        .appCancelButton()
        .withAction(viewModel, #selector(MapViewModelProtocol.cancel))
    
    private var viewModel: MapViewModelProtocol
    
    init(viewModel: MapViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setupUI()
        setupConstraince()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func bind() {
        viewModel.setRegion = { [weak self] region in
            self?.mapView.setRegion(region, animated: true)
        }
    }
    
    @objc private func selectDidTap() {
        
        let mapRegion = mapView.convert(circleImage.bounds,
                                        toRegionFrom: circleImage)
        
        viewModel.selectLocation(region: mapRegion,
                                 view: view,
                                 circle: circleImage,
                                 mapView: mapView)
    }
    
    private func setupUI() {
        
        view.backgroundColor = .appBlack
        view.addSubview(contentView)
        view.addSubview(mapView)
        view.addSubview(selectButton)
        view.addSubview(cancelButton)
        
        mapView.addSubview(circleImage)
        
        contentView.addSubview(searchBar)
        contentView.addSubview(cancelSearchButton)
    }
    
    private func setupConstraince() {
        
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        cancelSearchButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10.0)
            make.right.equalToSuperview().inset(8.0)
            make.left.equalTo(searchBar.snp.right).inset(8.0)
            make.width.equalTo(72.0)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.height.equalTo(45.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(8.0)
        }
        
        selectButton.snp.makeConstraints { make in
            make.height.equalTo(45.0)
            make.horizontalEdges.equalToSuperview().inset(20.0)
            make.bottom.equalTo(cancelButton.snp.top).inset(-8.0)
        }
        
        mapView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(selectButton.snp.centerY)
            make.top.equalTo(contentView.snp.bottom)
        }
        
        circleImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(95.0)
        }
    }
}

//MARK: - UISearchBarDelegate

extension MapVC: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        cancelSearchButton.setTitleColor(.appBlack, for: .normal)
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        cancelSearchButton.setTitleColor(.appYellow, for: .normal)
        return true
    }
}

//MARK: - L10n
extension MapVC {
    private enum L10n {
        static let searchPH = "MapVC_searchPH_placeholder".localized
        static let cancelSearch = "MapVC_cancelSearchBtn_title".localized
        static let select = "MapVC_selectBtn_title".localized
        static let cancel = "MapVC_cancelBtn_title".localized
    }
}
