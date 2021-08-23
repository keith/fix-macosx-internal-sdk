import XcodeProj

private func update(configuration: XCBuildConfiguration) -> XCBuildConfiguration {
  if configuration.buildSettings["SDKROOT"] as? String == "macosx.internal" {
    configuration.buildSettings["SDKROOT"] = "macosx"
  }

  return configuration
}

protocol BuildConfigurationUpdateable {
  var configurationList: XCConfigurationList? { get set }
}

extension BuildConfigurationUpdateable {
  func update() {
    configurationList?.buildConfigurations =
      configurationList?.buildConfigurations.map(update(configuration:)) ?? []
  }
}

extension PBXTarget: BuildConfigurationUpdateable {
  var configurationList: XCConfigurationList? {
    get { self.buildConfigurationList }
    set { self.buildConfigurationList = newValue }
  }
}

extension PBXProject: BuildConfigurationUpdateable {
  var configurationList: XCConfigurationList? {
    get { self.buildConfigurationList }
    set { self.buildConfigurationList = newValue }
  }
}
