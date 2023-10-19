//
//  AccessibiltyReport.swift
//  AccessibilityGuide
//
//  Created by Grace Stangroome on 29/09/2023.
//

import SwiftUI
import MessageUI
import AVFoundation

struct AccessibilityReport {
    var id: Int = 0
    var location: String = ""
    var icon: String = ""// Just the word to send via email
    var voicememo: UInt16 = 0 // No idea what this needs to be
    var textdescription: String = ""
}

struct AccessibiltyReportUI: View {
    @State var viewController = ViewController()
    @State private var thisReport = AccessibilityReport()
    @State private var selectedIcon: String = "Choose an icon"
    @State private var selectedIconIcon: String = " "
    @State private var selectedLocation: String = "Choose an Location"
    var audioPlayer: AVAudioPlayer!
    var audioRecorder: AVAudioRecorder!
    var body: some View {
        VStack {
            HStack{
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150, alignment: .leading)
                VStack{
                    Text("Guide for the SS Great Britain")
                        .font(.system(size: 40))
                        .bold()
                        .padding([.leading], 25)
                    Text("Reporting an accessibility report we missed")
                        .font(.system(size: 30))
                        .multilineTextAlignment(.leading)
                        .padding([.leading], 30)
                }
                .frame(width: 590, height: 0)
                Spacer()
                Button(action: viewController.goToInstructions){
                    Text("Instruction Page")
                        .font(.system(size: 30))
                        .multilineTextAlignment(.trailing)
                        .padding([.leading, .top], 20)
                    Image(systemName: "questionmark")
                        .font(.system(size: 45))
                        .multilineTextAlignment(.trailing)
                        .padding([.top], 20)
                } // Closing Instruciton button
                .padding()
            } // Closing Header
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding([.leading, .trailing, .bottom,])
            .foregroundColor(Color.white)
            .background(Color.red)
            
            VStack { // Opening the rest of the page
                Spacer()
                HStack {
                    Spacer()
                    Text("Where is the accessibilty issue located: ").font(.system(size: 27))
                    Spacer()
                    Menu(content: {
                        Button(action: { recordLocation("Dry Ship") }){Text("The Ship: Dry Dock")}
                        Button(action: { recordLocation("Top Deck") }){Text("The Ship: Top Deck")}
                        Button(action: { recordLocation( "Lower Deck")}){Text("The Ship: Lower Deck")}
                        Button(action: { recordLocation("Middle Deck")}){Text("The Ship: Middle Deck")}
                        Button(action: { recordLocation( "Being Brunel: Ground")}){Text("Being Brunel: Ground")}
                        Button(action: { recordLocation("Being Brunel: First")}){Text("Being Brunel: First")}
                    },
                         label: {Text(selectedLocation)
                        Image(systemName: "chevron.down")
                    })
                    .font(.system(size: 27))
                    .foregroundColor(Color.black)
                    .frame(width: 350, height: 75)
                    .multilineTextAlignment(.leading)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 3)
                            .background(Color.white)
                    )
                    .foregroundColor(Color.black)
                    Spacer()
                }
                Spacer()
                HStack {
                    Spacer()
                    Text("Which icon best describes the issue: ").font(.system(size: 27))
                    Spacer()
                    Menu(content: {
                        Button(action: { recordIcon( "Touch")}){Text("Touch")
                            Image(systemName: "hand.point.up.left")}
                        Button(action: { recordIcon( "Sight")}){Text("Sight")
                            Image(systemName: "eye")}
                        Button(action: { recordIcon( "Sound")}){Text("Sound")
                            Image(systemName: "ear")}
                        Button(action: { recordIcon( "Smell")}){Text("Smell")
                            Image(systemName: "nose")}
                        Button(action: { recordIcon( "Other")}){Text("Other Sensory")
                            Image(systemName: "square.fill")}
                        Button(action: {recordIcon("Mannequin")}){Text("Mannequin")
                            Image(systemName: "person")}
                    },
                        label: {
                        Image(systemName: selectedIconIcon)
                        Text(selectedIcon)
                        Image(systemName: "chevron.down")
                    })
                    .font(.system(size: 27))
                    .foregroundColor(Color.black)
                    .frame(width: 350, height: 75)
                    .multilineTextAlignment(.leading)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 3)
                            .background(Color.white)
                    )
                    .foregroundColor(Color.black)
                    Spacer()
                }
                Spacer()
                Text(" ").frame(width: 2000, height: 10, alignment: .leading)
                    .background(Color.red)
                Spacer()
                Text("Click your preferred method to describe the need you noticed:")
                    .font(.system(size: 27))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding([.leading], 20)
                    .padding([.bottom], -10)
                Spacer()
                HStack {
                    Spacer()
                    Button(action: typed) {
                        Text("Type your description").font(.system(size: 27))
                            .foregroundColor(Color.black)
                            .frame(width: 350, height: 75)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 3)
                                    .background(Color.white)
                            )
                            .foregroundColor(Color.black)
                    }
                    Spacer()
                    Button(action: voice) {
                        Text("Leave a voice memo").font(.system(size: 27))
                            .foregroundColor(Color.black)
                            .frame(width: 350, height: 75)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 3)
                                    .background(Color.white)
                            )
                            .foregroundColor(Color.black)
                    }
                    Spacer()
                }
                Spacer()
                Text(" ").frame(width: 2000, height: 10, alignment: .leading)
                    .background(Color.red)
                Spacer()
                HStack{
                    Spacer()
                    Text("Clicking “Submit” will anonymously send this information to an \n encrypted mailbox for staff to review before it is added to our guide").font(.system(size: 25))
                        .multilineTextAlignment(.center)
                    Spacer()
                    Button(action: submitAR) {
                        Text("Submit").bold()
                            .font(.system(size: 40)).foregroundColor(Color.black)
                            .frame(width: 200, height: 75)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 3)
                                    .background(Color.white)
                            )
                            .foregroundColor(Color.black)
                    }
                    Spacer()
                }
                Button(action: viewController.goToMap) {Text("Touch HERE to go back to map without submitting").bold()
                        .font(.system(size: 40))
                        .multilineTextAlignment(.trailing)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(Color.white)
                        .background(Color.red)
                }
            } // Closing the main body
        } // Closing Vstack of everything
    } // closing the body
    func recordLocation(_ location: String) {
        selectedLocation = location
        thisReport.location = location
    }

    func recordIcon(_ icon: String) {
        selectedIcon = icon
        thisReport.icon = icon
        if icon == "Touch" {
            selectedIconIcon = "hand.point.up.left"
        } else if icon == "Sight" {
            selectedIconIcon = "eye"
        } else if icon == "Sound" {
            selectedIconIcon = "ear"
        } else if icon == "Smell" {
            selectedIconIcon = "nose"
        } else if icon == "Other" {
            selectedIconIcon = "square.fill"
        } else if icon == "Mannequin" {
            selectedIconIcon = "person"
        } else { // should be impossible but just in case
            selectedIconIcon = "chevron.down"
        }
    }
    
    func typed() {
        // do something that records a typed message
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func voice() {
        // do something that audio records
        AVAudioApplication.requestRecordPermission { (granted) in
            if granted {
                print("Microphone access granted")
                // Microphone access granted
                // first, we'll update thisReport
                thisReport.textdescription = "Voice Description"
                // So we need to set up everything for recording
                // check we have the space to record
                var audioRecorder: AVAudioRecorder!
                let audioSettings: [String: Any] = [
                        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                        AVSampleRateKey: 44100.0,
                        AVNumberOfChannelsKey: 2,
                        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                    ]

                do {
                    let audioFilename = getDocumentsDirectory().appendingPathComponent("audioRecording.m4a")
                    audioRecorder = try AVAudioRecorder(url: audioFilename, settings: audioSettings)
                    audioRecorder.prepareToRecord()
                    startRecording()
                } catch {
                    // Handle the error
                    print("Error setting up audio recorder: \(error.localizedDescription)")
                    var popUpWindow: PopUpWindow!
                    popUpWindow = PopUpWindow(title: "Error setting up audio recorder:", text: "\(error.localizedDescription)")
                    popUpWindow.present(popUpWindow, animated: true, completion: nil)
                }
            } else {
                // Microphone Access Denied
                var popUpWindow: PopUpWindow!
                popUpWindow = PopUpWindow(title: "Microphone Access Denied", text: "In order to record a voice message, microphone access must be granted. You can change your permission settings in the Privacy & Security section of the Settings app.")
                popUpWindow.present(popUpWindow, animated: true, completion: nil)
            }
        }
    }
    
    // Functions to call to start and stop recording
    // will be necessary with some kind of pop up
    func startRecording() {
        if !audioRecorder.isRecording {
            audioRecorder.record()
        }
    }
    
    func stopRecording() {
        if audioRecorder.isRecording {
            audioRecorder.stop()
        }
    }

    // pressing Submit will send an email to an email address
    func submitAR() {
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        print("Sending email")
        /*
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["ssgb@gmail.com"])
        composer.setSubject("Accessibility Report")
        composer.setMessageBody("Location: \(thisReport.location) \n Icon: \(thisReport.icon) Further information: \n \(thisReport.textdescription)\n \(thisReport.voicememo)", isHTML: false)
        present(composer, animated: true)
         */
    }
} // Closing the View


// This doesn't work because Accessibility Report UI isn't a class and I don't want it to be,
class Mailer: MFMailComposeViewControllerDelegate {
    func isEqual(_ object: Any?) -> Bool {
        <#code#>
    }
    
    var hash: Int
    
    var superclass: AnyClass?
    
    func `self`() -> Self {
        <#code#>
    }
    
    func perform(_ aSelector: Selector!) -> Unmanaged<AnyObject>! {
        <#code#>
    }
    
    func perform(_ aSelector: Selector!, with object: Any!) -> Unmanaged<AnyObject>! {
        <#code#>
    }
    
    func perform(_ aSelector: Selector!, with object1: Any!, with object2: Any!) -> Unmanaged<AnyObject>! {
        <#code#>
    }
    
    func isProxy() -> Bool {
        <#code#>
    }
    
    func isKind(of aClass: AnyClass) -> Bool {
        <#code#>
    }
    
    func isMember(of aClass: AnyClass) -> Bool {
        <#code#>
    }
    
    func conforms(to aProtocol: Protocol) -> Bool {
        <#code#>
    }
    
    func responds(to aSelector: Selector!) -> Bool {
        <#code#>
    }
    
    var description: String
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            controller.dismiss(animated: true, completion: nil)
            return
        }
        switch result {
        case .cancelled:
            break
        case .failed:
            break
        case .saved:
            break
        case .sent:
            break
        @unknown default:
            <#fatalError()#>
        }
        controller.dismiss(animated: true, completion: nil)
    }
}


#Preview {
    AccessibiltyReportUI()
}
