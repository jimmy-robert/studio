import Flutter
import UIKit

public class SwiftStudioPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "studio", binaryMessenger: registrar.messenger())
    let instance = SwiftStudioPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    // todo: Add plugin methods here
    result(FlutterMethodNotImplemented)
  }
}
