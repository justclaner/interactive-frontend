//
//  HomePage.swift
//  Interactive
//
//  Created by Sadia Rahman on 11/20/24.
//

import SwiftUI
import Network
import UIKit

// Color extensions
extension Color {
    static let interactiveYellow = Color(hex: "#FFDD1A")
    static let interactiveDarkGray = Color(hex: "#444444")
    static let interactiveLightGray = Color(hex: "#666666")
}

// Hex color helper
private extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

class DeviceStatusManager: ObservableObject {
    @Published var batteryLevel: Float = 0.0
    @Published var isCharging: Bool = false
    @Published var wifiConnected: Bool = false
    
    private var monitor: NWPathMonitor?
    
    init() {
        // Enable battery monitoring
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        // Initial battery status
        updateBatteryStatus()
        
        // Set up battery status notifications
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateBatteryStatus),
            name: UIDevice.batteryLevelDidChangeNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateBatteryStatus),
            name: UIDevice.batteryStateDidChangeNotification,
            object: nil
        )
        
        // Set up WiFi monitoring
        monitor = NWPathMonitor(requiredInterfaceType: .wifi)
        monitor?.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.wifiConnected = path.status == .satisfied
            }
        }
        monitor?.start(queue: DispatchQueue.global())
    }
    
    deinit {
        monitor?.cancel()
    }
    
    @objc private func updateBatteryStatus() {
        DispatchQueue.main.async {
            self.batteryLevel = UIDevice.current.batteryLevel
            self.isCharging = UIDevice.current.batteryState == .charging
        }
    }
}

struct StatusBar: View {
    @StateObject private var deviceStatus = DeviceStatusManager()
    
    var body: some View {
        TimelineView(.periodic(from: .now, by: 1.0)) { timeline in
            HStack {
                Text(Date.now, format: .dateTime.hour().minute())
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                Spacer()
                HStack(spacing: 5) {
                    // WiFi indicator
                    Image(systemName: deviceStatus.wifiConnected ? "wifi" : "wifi.slash")
                    
                    // Battery indicator
                    HStack(spacing: 2) {
                        let batteryLevel = Int((deviceStatus.batteryLevel * 100).rounded())
                        Image(systemName: getBatterySymbolName(
                            level: deviceStatus.batteryLevel,
                            isCharging: deviceStatus.isCharging
                        ))
                        if batteryLevel >= 0 {
                            Text("\(batteryLevel)%")
                                .font(.system(size: 12))
                        }
                    }
                }
                .foregroundColor(.black)
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
        }
    }
    
    private func getBatterySymbolName(level: Float, isCharging: Bool) -> String {
        if level < 0 {
            return "battery.100"
        }
        
        let percentage = Int((level * 100).rounded())
        let batteryLevel: Int
        
        switch percentage {
        case 0...24: batteryLevel = 0
        case 25...49: batteryLevel = 25
        case 50...74: batteryLevel = 50
        case 75...94: batteryLevel = 75
        default: batteryLevel = 100
        }
        
        let baseSymbol = "battery.\(batteryLevel)"
        return isCharging ? "\(baseSymbol).bolt" : baseSymbol
    }
}

struct CustomSegmentedControl: View {
    @Binding var selection: String
    let options: [String]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(options, id: \.self) { option in
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selection = option
                    }
                }) {
                    Text(option)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(selection == option ? .white : Color(hex: "#222222"))
                        .frame(height: 36)
                        .frame(maxWidth: .infinity)
                        .background(
                            Group {
                                if selection == option {
                                    RoundedRectangle(cornerRadius: 18)
                                        .fill(Color(hex: "#333333"))
                                        .matchedGeometryEffect(id: "tab", in: namespace)
                                }
                            }
                        )
                }
            }
        }
        .padding(4)
        .background(Color(hex: "#888888").opacity(0.9))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .frame(width: UIScreen.main.bounds.width * 0.6)
    }
    
    @Namespace private var namespace
}

struct BottomNavBar: View {
    var body: some View {
        HStack(spacing: 0) {
            // Home Icon
            Button(action: {}) {
                Image("btn_nav")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)

            // Community Icon
            Button(action: {}) {
                Image("btn_nav-1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)

            // Interactive Icon (selected)
            Button(action: {}) {
                Image("Group 26")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 58, height: 58)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .background(
                Circle()
                    .fill(Color.interactiveYellow)
                    .frame(width: 56, height: 56)
            )

            // Bell Icon
            Button(action: {}) {
                Image("btn_nav-2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)

            // Profile Icon
            Button(action: {}) {
                Image("btn_nav-3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 20)
        .padding(.bottom, 24)
        .background(
            ZStack {
                Color.black.opacity(0.5)
                    .background(.ultraThinMaterial)
                    .blur(radius: 3)
            }
        )
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ProfileCard: View {
    let title: String
    let subtitle: String
    let tags: [String]
    let socialLinks: [String]
    let backgroundColor: Color
    let width: CGFloat
    let height: CGFloat
    let image: String
    let useWhiteText: Bool
    let showContent: Bool
    let imageHeight: CGFloat
    
    init(title: String = "",
         subtitle: String = "",
         tags: [String] = [],
         socialLinks: [String] = [],
         backgroundColor: Color,
         width: CGFloat,
         height: CGFloat,
         image: String,
         useWhiteText: Bool = false,
         showContent: Bool = true,
         imageHeight: CGFloat? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.tags = tags
        self.socialLinks = socialLinks
        self.backgroundColor = backgroundColor
        self.width = width
        self.height = height
        self.image = image
        self.useWhiteText = useWhiteText
        self.showContent = showContent
        self.imageHeight = imageHeight ?? width - 16
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width - 16, height: imageHeight)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal, 8)
                .padding(.top, showContent ? 8 : 0)
            
            if showContent {
                VStack(alignment: .leading, spacing: subtitle.isEmpty ? 2 : 4) {
                    Text(title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(useWhiteText ? .white : .black)
                        .lineLimit(1)
                    
                    if !subtitle.isEmpty {
                        Text(subtitle)
                            .font(.system(size: 13))
                            .foregroundColor(useWhiteText ? .white.opacity(0.6) : .black.opacity(0.6))
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    if !socialLinks.isEmpty {
                        HStack(spacing: 8) {
                            ForEach(socialLinks, id: \.self) { link in
                                Image("social=\(link)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 32, height: 32)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.black.opacity(0.05))
                                            .frame(width: 32, height: 32)
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                            }
                        }
                        .padding(.top, subtitle.isEmpty ? 4 : 8)
                        .padding(.bottom, 8)
                    }
                    
                    if !tags.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 6) {
                                ForEach(tags, id: \.self) { tag in
                                    Text(tag)
                                        .font(.system(size: 11))
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 3)
                                        .background(Color.black.opacity(0.1))
                                        .clipShape(Capsule())
                                }
                                
                                Button(action: {}) {
                                    Image(systemName: "plus")
                                        .foregroundColor(.black)
                                        .frame(width: 18, height: 18)
                                        .background(Color.black.opacity(0.1))
                                        .clipShape(Circle())
                                }
                            }
                        }
                        .padding(.top, 2)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 12)
                .frame(maxWidth: width - 16)
            }
        }
        .frame(width: width, height: height)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(backgroundColor)
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
    }
}

struct HomePageOld: View {
    @Binding var path: [String]
    @State private var selectedTab: String = "People"
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            // Background Image
            Image("Background1")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            
            // Main Content
            VStack(spacing: 0) {
                // Status Bar
                StatusBar()
                
                // Top Navigation
                HStack(spacing: 4) {
                    // Custom Segmented Control
                    CustomSegmentedControl(
                        selection: $selectedTab,
                        options: ["People", "Posters"]
                    )
                    .frame(width: screenWidth * 0.6)
                    
                    Spacer()
                    
                    HStack(spacing: 8) {
                        Button(action: {}) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                                .background(Color.white.opacity(0.2))
                                .clipShape(Circle())
                        }
                        
                        Button(action: {}) {
                            Image(systemName: "slider.horizontal.3")
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                                .background(Color.white.opacity(0.2))
                                .clipShape(Circle())
                        }
                    }
                }
                .padding(.horizontal, 12)
                .padding(.trailing, 16)
                .padding(.top, 8)
                .padding(.bottom, 8)
                
                // Content
                ScrollView {
                    HStack(alignment: .top, spacing: 12) {
                        // Left Column
                        VStack(spacing: 12) {
                            ProfileCard(
                                title: "Les Votives",
                                subtitle: "Lorem Ipsum dolor sit amet",
                                tags: ["Music", "Social"],
                                socialLinks: ["instagram", "spotify"],
                                backgroundColor: .interactiveYellow,
                                width: screenWidth * 0.47,
                                height: 330,
                                image: "LesVotives"
                            )
                            
                            ProfileCard(
                                title: "Nicveltroni",
                                tags: ["Fashion", "Social"],
                                socialLinks: ["instagram", "spotify", "tiktok"],
                                backgroundColor: .interactiveLightGray,
                                width: screenWidth * 0.47,
                                height: 290,
                                image: "Nicveltroni"
                            )
                        }
                        
                        // Right Column
                        VStack(spacing: 12) {
                            ProfileCard(
                                title: "Theo Boettcher",
                                subtitle: "Interactive Co-founder",
                                tags: [],
                                socialLinks: ["instagram", "tiktok", "linkedin", "vinted"],
                                backgroundColor: .interactiveDarkGray,
                                width: screenWidth * 0.47,
                                height: 290,
                                image: "Theo",
                                useWhiteText: true
                            )
                            
                            ProfileCard(
                                backgroundColor: .clear,
                                width: screenWidth * 0.47,
                                height: screenWidth * 0.65,
                                image: "Maya",
                                showContent: false,
                                imageHeight: screenWidth * 0.65
                            )
                            
                            ProfileCard(
                                backgroundColor: .interactiveDarkGray,
                                width: screenWidth * 0.47,
                                height: 190,
                                image: "RandomGirl",
                                useWhiteText: true,
                                showContent: false
                            )
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.top, 8)
                }
                
                // Bottom Navigation
                BottomNavBar()
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePageOld(path: .constant([]))
    }
}
