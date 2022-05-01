//
// Copyright © 2020 osy. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import SwiftUI

@available(iOS 14, macOS 11, *)
struct VMCommands: Commands {
    @Environment(\.openURL) private var openURL
    
    @CommandsBuilder
    var body: some Commands {
        CommandGroup(replacing: .newItem) {
            Button(action: { NotificationCenter.default.post(name: NSNotification.NewVirtualMachine, object: nil) }, label: {
                Text("New...")
            }).keyboardShortcut(KeyEquivalent("n"))
            Button(action: { NotificationCenter.default.post(name: NSNotification.NewVirtualMachineGroup, object: nil) }, label: {
                Text("New Group...")
            }).keyboardShortcut(KeyEquivalent("N"))
            Button(action: { NotificationCenter.default.post(name: NSNotification.OpenVirtualMachine, object: nil) }, label: {
                Text("Open...")
            }).keyboardShortcut(KeyEquivalent("o"))
        }
        SidebarCommands()
        ToolbarCommands()
        CommandGroup(replacing: .help) {
            Button(action: { openLink("https://mac.getutm.app/gallery/") }, label: {
                Text("Virtual Machine Gallery")
            })
            Button(action: { openLink("https://mac.getutm.app/support/") }, label: {
                Text("Support")
            })
            Button(action: { openLink("https://mac.getutm.app/licenses/") }, label: {
                Text("License")
            })
        }
    }
    
    private func openLink(_ url: String) {
        openURL(URL(string: url)!)
    }
}

extension NSNotification {
    static let NewVirtualMachine = NSNotification.Name("NewVirtualMachine")
    static let NewVirtualMachineGroup = NSNotification.Name("NewVirtualMachineGroup")
    static let OpenVirtualMachine = NSNotification.Name("OpenVirtualMachine")
}
