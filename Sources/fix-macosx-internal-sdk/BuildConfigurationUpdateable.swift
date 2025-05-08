import XcodeProj

private func update(configuration: XCBuildConfiguration) -> XCBuildConfiguration {
  if case let .string(value) = configuration.buildSettings["SDKROOT"], value == "macosx.internal" {
    configuration.buildSettings["SDKROOT"] = .string("macosx")
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
