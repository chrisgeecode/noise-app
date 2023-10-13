import Cocoa
import AVFoundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  func applicationDidFinishLaunching(_ notification: Notification) {
    // Your app code here


let audioSession = AVAudioSession.sharedInstance()

func checkAudioLevel() {

  audioSession.requestRecordPermission { (granted) in
    if granted {
      let inputNode = audioEngine.inputNode
      let inputFormat = inputNode.outputFormat(forBus: 0)
      inputNode.installTap(onBus: 0, bufferSize: 1024, format: inputFormat) { (buffer, time) in
        let channelData = buffer.floatChannelData![0]
        let averagePower = 20 * log10(calculateRMS(channelData))
        
        if averagePower &gt; 70 {
          // set icon to red
        } else if averagePower &gt; 50 {
           // set icon to orange
        } else {
           // set icon to green
        }
      }
    }
  }

}

func calculateRMS(_ data: [Float]) -&gt; Float {
  let meanSquared = data.reduce(0, {$0 + $1 * $1}) / Float(data.count)
  return sqrt(meanSquared)
}

// Run checkAudioLevel periodically 
Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
  checkAudioLevel()
}
  }

}

