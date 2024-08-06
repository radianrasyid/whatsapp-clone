//
//  WhatsappCameraComp.swift
//  Whatsapp
//
//  Created by Muhammad Radian Rasyid on 05/08/24.
//

import SwiftUI
import AVFoundation
import Photos

struct MediaItem: Identifiable {
    let id: String
    let asset: PHAsset
}

func fetchRecentMediaItems() -> [MediaItem] {
    let fetchOptions = PHFetchOptions()
    fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
    
    let fetchResult = PHAsset.fetchAssets(with: fetchOptions)
    
    return (0..<fetchResult.count).compactMap{
        index in
        guard let asset = fetchResult.object(at: index) as? PHAsset else {return nil}
        return MediaItem(id: asset.localIdentifier, asset: asset)
    }
}

struct WhatsappCustomCameraView: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
    @State private var recentMedia: [MediaItem] = []
    
    func makeUIViewController(context: Context) -> WhatsappCustomCameraViewController {
        let controller = WhatsappCustomCameraViewController()
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: WhatsappCustomCameraViewController, context: Context) {
        DispatchQueue.main.async{
            let recentMedia = fetchRecentMediaItems()
            uiViewController.updateRecentMedia(recentMedia)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WhatsappCustomCameraViewControllerDelegate {
        let parent: WhatsappCustomCameraView
        
        init(_ parent: WhatsappCustomCameraView){
            self.parent = parent
        }
        
        func didTakePhoto(_ image: UIImage){
            parent.image = image
            parent.isPresented = false
        }
    }
}

protocol WhatsappCustomCameraViewControllerDelegate: AnyObject {
    func didTakePhoto(_ image: UIImage)
}

class WhatsappCustomCameraViewController: UIViewController {
    weak var delegate: WhatsappCustomCameraViewControllerDelegate?
    var recentMediaItems: [MediaItem] = []
    private var collectionView: UICollectionView!
    private let captureSession = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private let output = AVCapturePhotoOutput()
    private var currentCameraPosition: AVCaptureDevice.Position = .back
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        setupUI()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(WhatsappThumbnailCell.self, forCellWithReuseIdentifier: WhatsappThumbnailCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            collectionView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func checkPhotoLibraryPermission() {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized, .limited:
                    self.loadRecentMedia()
                case .denied, .restricted:
                    print("Photo library access denied")
                    // Show an alert to the user
                case .notDetermined:
                    print("Photo library access not determined")
                @unknown default:
                    break
                }
            }
        }
    }
    
    private func loadRecentMedia() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOptions.fetchLimit = 20
        
        let fetchResult = PHAsset.fetchAssets(with: fetchOptions)
        recentMediaItems = (0..<fetchResult.count).compactMap { index in
            guard let asset = fetchResult.object(at: index) as? PHAsset else { return nil }
            return MediaItem(id: asset.localIdentifier, asset: asset)
        }
        collectionView.reloadData()
    }
    
    func updateRecentMedia(_ items: [MediaItem]) {
        recentMediaItems = items
        collectionView.reloadData()
    }
    
    private func setupCamera() {
        guard let camera = camera(with: currentCameraPosition) else { return }
        do {
            let input = try AVCaptureDeviceInput(device: camera)
            captureSession.beginConfiguration()
            captureSession.inputs.forEach { captureSession.removeInput($0) } // Remove existing inputs
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
            if captureSession.canAddOutput(output) {
                captureSession.addOutput(output)
            }
            captureSession.commitConfiguration()
            
            if previewLayer == nil {
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                previewLayer?.videoGravity = .resizeAspectFill
                previewLayer?.frame = view.bounds
                if let previewLayer = previewLayer {
                    view.layer.addSublayer(previewLayer)
                }
            }
            captureSession.startRunning()
        } catch {
            print("\(error)")
        }
    }
    
    private func camera(with position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let devices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .unspecified).devices
        return devices.first { $0.position == position }
    }
    
    private func setupUI() {
        // Create the buttons
        let buttonSize: CGSize = CGSize(width: 60, height: 60)
        
        let button1 = UIButton(type: .system)
        button1.setImage(UIImage(systemName: "photo.circle.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: buttonSize.width)), for: .normal)
        button1.addTarget(self, action: #selector(openGallery), for: .touchUpInside)
        button1.frame = CGRect(x: 0, y: 0, width: buttonSize.width, height: buttonSize.height)
        button1.tintColor = .label
        
        let button2 = UIButton(type: .system)
        button2.setImage(UIImage(systemName: "inset.filled.circle")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: buttonSize.width)), for: .normal)
        button2.addTarget(self, action: #selector(capturePhoto), for: .touchUpInside)
        button2.frame = CGRect(x: 0, y: 0, width: buttonSize.width, height: buttonSize.height)
        button2.tintColor = .label
        
        let button3 = UIButton(type: .system)
        button3.setImage(UIImage(systemName: "arrow.trianglehead.2.clockwise.rotate.90")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: buttonSize.width)), for: .normal)
        button3.addTarget(self, action: #selector(switchingCamera), for: .touchUpInside)
        button3.frame = CGRect(x: 0, y: 0, width: buttonSize.width, height: buttonSize.height)
        button3.tintColor = .label
        
        // Create spacers
        let spacer1 = UIView()
        let spacer2 = UIView()
        
        // Set the content hugging priority so spacers expand to fill space
        spacer1.setContentHuggingPriority(.required, for: .horizontal)
        spacer2.setContentHuggingPriority(.required, for: .horizontal)
        
        // Create a horizontal stack view
        let stackView = UIStackView(arrangedSubviews: [button1, spacer1, button2, spacer2, button3])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        
        // Add the stack view to the view
        view.addSubview(stackView)

        button1.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        button3.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button1.widthAnchor.constraint(equalToConstant: buttonSize.width),
            button1.heightAnchor.constraint(equalToConstant: buttonSize.height),
            
            button2.widthAnchor.constraint(equalToConstant: buttonSize.width),
            button2.heightAnchor.constraint(equalToConstant: buttonSize.height),
            
            button3.widthAnchor.constraint(equalToConstant: buttonSize.width),
            button3.heightAnchor.constraint(equalToConstant: buttonSize.height),
        ])
        
        // Set up constraints for the stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func savePhotoToGallery(_ image: UIImage) {
        whatsappRequestPhotoLibraryPermission(completion: {
            granted in
            if granted {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
            }else{
                print("Permission to save photo was denied")
            }
        })
    }
    
    func whatsappRequestPhotoLibraryPermission(completion: @escaping (Bool) -> Void){
        PHPhotoLibrary.requestAuthorization {
            status in
            DispatchQueue.main.async{
                completion(status == .authorized)
            }
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer){
        if let error = error {
            print("Error saving image: \(error.localizedDescription)")
        }else{
            print("Photo saved successfully")
        }
    }
    
    @objc private func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        output.capturePhoto(with: settings, delegate: self)
    }
    
    @objc private func openGallery(){
        print("opening gallery")
    }
    
    @objc private func switchingCamera(){
        currentCameraPosition = currentCameraPosition == .back ? .front : .back
        setupCamera()
    }
}

extension WhatsappCustomCameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation(),
              let image = UIImage(data: data) else {return}
        
        savePhotoToGallery(image)
        
        delegate?.didTakePhoto(image)
    }
}

extension WhatsappCustomCameraViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentMediaItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("Dequeuing cell for index \(indexPath.item)")
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WhatsappThumbnailCell.reuseIdentifier, for: indexPath) as? WhatsappThumbnailCell else {
            print("Failed to dequeue WhatsappThumbnailCell")
            return WhatsappThumbnailCell(frame: .zero)
        }
        
        print("Successfully dequeued cell")
        guard indexPath.item < recentMediaItems.count else {
            print("Index out of bounds: \(indexPath.item), recentMediaItems count: \(recentMediaItems.count)")
            return cell
        }
        
        let asset = recentMediaItems[indexPath.item].asset
        print("Configuring cell with asset")
        cell.configure(with: asset)
        
        if indexPath.item < recentMediaItems.count {
            let asset = recentMediaItems[indexPath.item].asset
            cell.configure(with: asset)
        }
        
        return cell
    }
}

struct WhatsappThumbnailView: View {
    let asset: PHAsset
    @State private var image: UIImage?
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                Color.gray
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .clipShape(.rect(cornerRadius: 8))
        .onAppear(perform: loadImage)
    }
    
    private func loadImage() {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        option.isSynchronous = false
        option.deliveryMode = .fastFormat
        
        manager.requestImage(for: asset, targetSize: CGSize(width: 120, height: 120), contentMode: .aspectFill, options: option) { result, info in
            DispatchQueue.main.async {
                self.image = result
            }
        }
    }
}

class WhatsappThumbnailCell: UICollectionViewCell {
    static let reuseIdentifier = "WhatsappThumbnailCell"
    
    private var hostingController: UIHostingController<WhatsappThumbnailView>?
    
    func configure(with asset: PHAsset) {
        if let hostingController = hostingController {
            hostingController.rootView = WhatsappThumbnailView(asset: asset)
        } else {
            let thumbnailView = WhatsappThumbnailView(asset: asset)
            hostingController = UIHostingController(rootView: thumbnailView)
            
            guard let thumbnailRootView = hostingController?.view else { return }
            thumbnailRootView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(thumbnailRootView)
            thumbnailRootView.layer.cornerRadius = 8
            
            NSLayoutConstraint.activate([
                thumbnailRootView.topAnchor.constraint(equalTo: contentView.topAnchor),
                thumbnailRootView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                thumbnailRootView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                thumbnailRootView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ])
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hostingController?.rootView = WhatsappThumbnailView(asset: PHAsset())
    }
}
//import Foundation
//import UIKit
//import SwiftUI
//
//struct ImagePicker: UIViewControllerRepresentable {
//    @Binding var image: UIImage?
//    @Binding var isPresented: Bool
//    var sourceType: UIImagePickerController.SourceType = .camera
//
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.sourceType = sourceType
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//        let parent: ImagePicker
//
//        init(_ parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//            if let image = info[.originalImage] as? UIImage {
//                parent.image = image
//            }
//            parent.isPresented = false
//        }
//
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            parent.isPresented = false
//        }
//    }
//}
//
//struct CameraView: View {
//
//    @State private var image: UIImage?
//    @State private var showingImagePicker = false
//
//    var body: some View {
//        VStack{
//            if let image = image {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//            }else{
//                Text("No image selected")
//            }
//
//            Button(action: {
//                showingImagePicker = true
//            }, label: {
//                Text("Take photo")
//            })
//
//        }
//        .sheet(isPresented: $showingImagePicker){
//            ImagePicker(image: $image, isPresented: $showingImagePicker, sourceType: .camera)
//        }
//    }
//}
//
//#Preview{
//    CameraView()
//}
