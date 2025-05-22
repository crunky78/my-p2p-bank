import Foundation

class ConfigManager {
    static let shared = ConfigManager()

    private(set) var config: AppConfig?

    private init() {
        loadConfig()
    }

    private func loadConfig() {
        guard let url = Bundle.main.url(forResource: "config", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode(AppConfig.self, from: data) else {
            print("❌ config.json 불러오기 실패")
            return
        }
        config = decoded
    }
}
