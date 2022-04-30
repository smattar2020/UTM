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

struct CompatibleUTMTemplates: View {
    var body: some View {
        if #available(macOS 12.0, *) {
            MainView()
        }
        else {
            Text("Please upgrade to macOS 12.0 Monterey to use UTM Templates")
        }
    }
}

@available(iOS 14, macOS 11, *)
struct VMPlaceholderView: View {
    @EnvironmentObject private var data: UTMData
    @Environment(\.openURL) private var openURL
    
    @State var browsingTemplates = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Welcome to UTM").font(.title)
            }
            HStack {
                TileButton(titleKey: "Create a New Virtual Machine", systemImage: "plus.circle") {
                    data.newVM()
                }
                TileButton(titleKey: "Browse UTM Gallery", systemImage: "arrow.down.circle") {
                    openURL(URL(string: "https://mac.getutm.app/gallery/")!)
                }
                
//                NavigationLink(destination: CompatibleUTMTemplates()) {
//                    Tile(titleKey: "Browse UTM Templates", systemImage: "arrow.down.app")
//                }
//                .buttonStyle(BigButtonStyle(width: 150, height: 150))
//                .sheet(isPresented: $browsingTemplates) {
//                    CompatibleUTMTemplates()
//                }
            }
            HStack {
                /// Link to Mac sites on all platforms because they are more up to date
                TileButton(titleKey: "User Guide", systemImage: "book.circle") {
                    openURL(URL(string: "https://mac.getutm.app/guide/")!)
                }
                TileButton(titleKey: "Support", systemImage: "questionmark.circle") {
                    openURL(URL(string: "https://mac.getutm.app/support/")!)
                }
            }
        }
    }
}

@available(iOS 14, macOS 11, *)
struct Tile: View {
    let titleKey: LocalizedStringKey
    let systemImage: String
    
    var body: some View {
        Label(titleKey, systemImage: systemImage)
            .labelStyle(TileLabelStyle())
    }
}

@available(iOS 14, macOS 11, *)
struct TileButton: View {
    let titleKey: LocalizedStringKey
    let systemImage: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Label(titleKey, systemImage: systemImage)
                .labelStyle(TileLabelStyle())
        }).buttonStyle(BigButtonStyle(width: 150, height: 150))
    }
}


@available(iOS 14, macOS 11, *)
struct TileLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.icon
                .font(.system(size: 48.0, weight: .medium))
                .padding(.bottom)
            configuration.title
                .multilineTextAlignment(.center)
        }
    }
}

@available(iOS 14, macOS 11, *)
struct VMPlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        VMPlaceholderView()
    }
}
