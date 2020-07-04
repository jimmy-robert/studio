import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController.init()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    self.contentMinSize = NSSize(width: 640, height: 480)
    
    let customToolbar = NSToolbar(identifier: "main")
    titlebarAppearsTransparent = true
    titleVisibility = .hidden
    toolbar = customToolbar
    backgroundColor = .white
    
    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
