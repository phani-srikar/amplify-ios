module AmplifyPods
  @@pods = [
    {
      spec: "Amplify.podspec",
      push: true,
      constants: [],
      plist_paths: [
        "Amplify/Info.plist",
        "AmplifyTests/Info.plist",
        "AmplifyFunctionalTests/Info.plist",
        "AmplifyTestApp/Info.plist",
        "AmplifyTestCommon/Info.plist"
      ]
    },
    {
      spec: "AWSPluginsCore.podspec",
      push: true,
      constants: ['AMPLIFY_VERSION'],
      plist_paths: [
        "AmplifyPlugins/Core/AWSPluginsCore/Info.plist",
        "AmplifyPlugins/Core/AWSPluginsCoreTests/Info.plist",
        "AmplifyPlugins/Core/AWSPluginsTestCommon/Info.plist"
      ]
    },
    {
      spec: "CoreMLPredictionsPlugin.podspec",
      push: true,
      constants: ['AMPLIFY_VERSION'],
      plist_paths: [
        "AmplifyPlugins/Predictions/CoreMLPredictionsPlugin/Resources/Info.plist"
      ]
    },
    {
      spec: "AWSPredictionsPlugin.podspec",
      push: true,
      constants: ['AMPLIFY_VERSION'],
      plist_paths: [
        "AmplifyPlugins/Predictions/AWSPredictionsPlugin/Resources/Info.plist"
      ]
    },
    {
      spec: "AmplifyPlugins.podspec",
      push: true,
      constants: ['AMPLIFY_VERSION'],
      plist_paths: [
        "AmplifyPlugins/Analytics/AWSPinpointAnalyticsPlugin/Resources/Info.plist",
        "AmplifyPlugins/API/AWSAPICategoryPlugin/Info.plist",
        "AmplifyPlugins/Storage/AWSS3StoragePlugin/Resources/Info.plist"
      ]
    },
    {
      spec: "AmplifyTestCommon.podspec",
      push: false,
      constants: ['AMPLIFY_VERSION', 'AMPLIFY_PLUGINS_CORE_VERSION'],
      plist_paths: [
        "AmplifyTestCommon/Info.plist"
      ]
    }
  ]
  def self.pods
    @@pods
  end
end