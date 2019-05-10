## UIImagePickerViewController 

By default the photo libray is accessible from the simulator or iOS device without needing to add additional access in the Info.plist file. However explicit access needs to be granted for accessing the user's camera. This accesss is made possible via the **NSCameraUsageDescription** key in the Info.plist with an explicit String explaining the reason for camera usage. 

## Vocabulary

- AVFoundation
- UIImagePickerViewController 
- AVCaptureDevice
- AVCaptureDevice.authorizationStatus
- AVCaptureDevice.requestAccess
- UIImagePickerControllerDelegate
- UINavigationControllerDelegate
- UIImagePickerController.InfoKey

## UIImagePickerControllerDelegate Methods 

```swift 
extension PhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    print("\ninfo: \(info)\n") // keys: UIImagePickerController.InfoKey.originalImage
    guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
      print("no image found")
      return
    }
    imageView.image = image
    dismiss(animated: true, completion: nil)
  }
}
```
