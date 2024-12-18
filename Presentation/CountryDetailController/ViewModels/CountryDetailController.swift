//
//  CountryDetailController.swift
//  CountryAppKenan
//
//  Created by Kenan on 14.12.24.
//

import UIKit
import MapKit
final class CountryDetailController: BaseViewController {
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView(style: .large)
        v.tintColor = .red
        return v
    }()
    
    private lazy var mapView: MKMapView = {
       let m = MKMapView()
        m.overrideUserInterfaceStyle = .dark
        m.delegate = self
        return m
    }()
    
    private let viewModel: CountryDetailViewModel
    private var coordinator: CLLocationCoordinate2D?
    init(viewModel: CountryDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
    }
    
    override func configureView() {
        super.configureView()
        coordinator = .init(latitude: viewModel.getLatlng().0, longitude: viewModel.getLatlng().1)
        view.addSubViews(loadingView, mapView)
        navigationItem.title = viewModel.getTitle()
        addPin()
    }
    
    override func configureConstraint() {
        super.configureConstraint()
        loadingView.fillSuperview()
        mapView.fillSuperviewSafeAreaLayoutGuide(padding: .init(top: 50, left: 0, bottom: 0, right: 0))
    }
    
    override func configureTargets() {
        super.configureTargets()
    }
    
    fileprivate func addPin() {
        guard let coordinator = coordinator else {return}
        let pin = MKPointAnnotation()
        pin.title = viewModel.getTitle()
        pin.coordinate = coordinator
        mapView.addAnnotation(pin)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.setRegion()
            
        }
    }
    
    fileprivate func setRegion() {
        guard let coordinator = coordinator else {return}
        let span: MKCoordinateSpan = MKCoordinateSpan(
            latitudeDelta: 0.5, longitudeDelta: 0.5)
        mapView.setRegion(.init(center: coordinator, span: span), animated: true)
    }
    
    fileprivate func configureViewModel() {
        
        viewModel.listener = { [weak self] state in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch state {
                    case .loading:
                        self.loadingView.startAnimating()
                    case .loaded:
                        self.loadingView.stopAnimating()
                    case .success:
                        print(#function, state)
                    case .error(let message):
                        self.showMessage(title: "Xeta", message: message)
                }
            }
        }
    }
}

extension CountryDetailController: MKMapViewDelegate {
    
}
