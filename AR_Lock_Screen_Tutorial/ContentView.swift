//
//  ContentView.swift
//  AR_Lock_Screen_Tutorial
//
//  Created by Cole Dennis on 9/25/22.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        var newConfig = ARFaceTrackingConfiguration()
        newConfig.frameSemantics.insert(.personSegmentation)
        arView.session.run(newConfig)
      
        let textAnchor = AnchorEntity(.camera)
        textAnchor.addChild(textGen(textString: getTime()))
        arView.scene.addAnchor(textAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    
    func textGen(textString: String) -> ModelEntity {
        
        var materialVar = UnlitMaterial(color: .black)
        
        materialVar.blending = .transparent(opacity: 0.8)
        
        let depthVar: Float = 0.005
        let fontVar = UIFont.systemFont(ofSize: 0.15, weight: .bold, width: .standard)
        let containerFrameVar = CGRect(x: -0.4, y: 0.0, width: 0.8, height: 0.4)
        let alignmentVar: CTTextAlignment = .center
        let lineBreakModeVar : CTLineBreakMode = .byCharWrapping
        
        let textMeshResource : MeshResource = .generateText(textString,
                                                            extrusionDepth: depthVar,
                                                            font: fontVar,
                                                            containerFrame: containerFrameVar,
                                                            alignment: alignmentVar,
                                                            lineBreakMode: lineBreakModeVar)
        
        let textEntity = ModelEntity(mesh: textMeshResource, materials: [materialVar])
        textEntity.transform.translation = [0, 0.1,-0.9]
        
        return textEntity
    }
    
    func getTime() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        var dateString = formatter.string(from: Date())
        dateString.removeLast(3)
        return dateString
    }
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
