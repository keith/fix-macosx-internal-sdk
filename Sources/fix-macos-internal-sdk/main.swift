import ArgumentParser
import Foundation
import PathKit
import XcodeProj

private func fail(_ message: String) -> Never {
  fputs("error: \(message)\n", stderr)
  exit(EXIT_FAILURE)
}

struct FixMacosInternalSDK: ParsableCommand {
  @Argument(
    help: "The xcodeproj file(s) to update.",
    transform: Path.init(_:))
  var project: [Path]

  mutating func run() throws {
    let loadedProjects = project.map { (projectPath: Path) -> (Path, XcodeProj) in
      do {
        return (projectPath, try XcodeProj(path: projectPath))
      } catch let error as XCodeProjError {
        switch error {
        case .notFound(let path):
          fail("xcodeproj not found: \(path)")
        case .pbxprojNotFound(let path), .xcworkspaceNotFound(let path):
          fail("malformed xcodeproj: \(path)")
        }
      } catch let error {
        fail("failed to load xcodeproj: \(error)")
      }
    }

    for (projectPath, project) in loadedProjects {
      let updateables: [BuildConfigurationUpdateable] =
        project.pbxproj.nativeTargets + project.pbxproj.legacyTargets
        + project.pbxproj.aggregateTargets + project.pbxproj.projects
      for updateable in updateables {
        updateable.update()
      }

      try project.writePBXProj(
        path: projectPath, override: true, outputSettings: PBXOutputSettings())
    }
  }
}

FixMacosInternalSDK.main()
