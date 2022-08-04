# ARKit_Barebones
<br/>

### 프로젝트 소개
- ARKit의 기본적인 기능 구현을 익히는 데에 도움을 주는 Bare-bones 프로젝트입니다.
- ARKit을 통해 **SwiftUI 기반의 (3D 모델을 배치하는) 간단한 증강현실 앱**을 구현합니다.
- ARKit을 처음 활용해 보는 경우, 이 프로젝트의 코드를 살펴보면 도움이 됩니다.

https://user-images.githubusercontent.com/74223246/182755526-2e4a19c5-f9f5-4ff6-b787-988fdc74f92a.MP4

<br/>
<br/>

### ARKit이란?   
ARKit은 **AR 앱을 빌드하거나 앱에 AR 기능을 추가할 수 있게 해주는 프레임워크**입니다.    
이 프로젝트는 ARKit 뿐 아니라, AR 개발을 더 빠르고 쉽게 할 수 있도록 도와주는 RealityKit도 함께 사용합니다.    
RealityKit을 통해 AR 앱에서 사용할 3D 모델을 시뮬레이션 및 렌더링할 수 있죠.

<img width="700" alt="arKitImage" src="https://user-images.githubusercontent.com/74223246/182755655-700eb30e-d4cd-49ac-9538-55c278b5efdb.png">

Apple의 증강 현실 세계가 더 궁금하다면 [Apple의 공식 문서](https://developer.apple.com/kr/augmented-reality/)를 참고해 보세요.

<br/>

⭐️ **AR Quick Look**    

[AR Quick Look 갤러리](https://developer.apple.com/kr/augmented-reality/quick-look/)에서 실제 공간에 배치할 수 있는 **3D 모델 파일을 쉽게 다운로드**할 수 있습니다.    
Mac에서 모델을 클릭하여 USDZ 파일을 받고, 프로젝트에 추가하면 우리의 앱에서 사용할 수 있게 됩니다!

<img width="500" alt="스크린샷 2022-08-04 오후 12 06 39" src="https://user-images.githubusercontent.com/74223246/182755906-c7a4e271-b175-4cb4-bdc5-80ad378c2e29.png">

<br/>
<br/>

### 핵심 코드
모델 객체를 생성하고 모델 배열을 얻는 코드와 ARView를 생성하고 3D 물체을 화면에 배치하는 핵심 코드를 참고하세요.

<br/>

**모델 객체 생성 및 배열 얻기**
```Swift
// 모델 객체
class Model {
    var modelName: String // 모델 이름
    var image: UIImage // 모델 이미지(썸네일) 
    var modelEntity: ModelEntity? // 모델 개체
    
    private var cancellable: AnyCancellable? = nil
    
    init(modelName: String) {
        self.modelName = modelName
        self.image = UIImage(named: modelName)!
        let fileName = modelName + ".usdz"
        // 모델 이름에 .usdz 확장자를 붙인 파일 이름으로 모델 개체 불러오기
        self.cancellable = ModelEntity.loadModelAsync(named: fileName)
            .sink(receiveCompletion: { loadCompletion in
                // Handle Error
                print("Unable to load modelEntiry for modelName: \(self.modelName)")
            }, receiveValue: { modelEntity in
                // Get out modelEntity
                self.modelEntity = modelEntity
                print("Successfully loaded modelEntity for modelName: \(self.modelName)")
            })
    }
}
```
```Swift
// 웹 뷰 업데이트
// 모델 이름 배열 얻기 
private var models: [Model] = {
    guard let path = Bundle.main.resourcePath, let files = try? FileManager.default.contentsOfDirectory(atPath: path) else {
        return []
    }
    var models: [Model] = []
    // 파일 이름에서 .usdz 확장자 제거 -> 모델 이름 
    for fileName in files where fileName.hasSuffix("usdz") {
        let modelName = fileName.replacingOccurrences(of: ".usdz", with: "")
        let model = Model(modelName: modelName)
        models.append(model)
    }
    return models
}()
```

<br/>

**ARView 생성 및 3D 물체 배치**
```Swift
// ARView 생성
func makeUIView(context: Context) -> ARView {
    let arView = CustomARView(frame: .zero) // focusSquare를 생성하기 위한 CustomARView
    return arView
}
```
```Swift
// ARView에 3D 물체 배치 
func updateUIView(_ uiView: ARView, context: Context) {
    if let model = self.modelConfirmedForPlacement {
        if let modelEntity = model.modelEntity {
             / 모델을 화면에 배치
            let anchorEntity = AnchorEntity(plane: .any)
            anchorEntity.addChild(modelEntity.clone(recursive: true))
            uiView.scene.addAnchor(anchorEntity)
        } else {
            print("Unable to load modelEntity for \(model.modelName)")
        }
            
        DispatchQueue.main.async {
            self.modelConfirmedForPlacement = nil
        }
    }
}
```
