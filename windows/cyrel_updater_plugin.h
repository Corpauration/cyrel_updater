#ifndef FLUTTER_PLUGIN_CYREL_UPDATER_PLUGIN_H_
#define FLUTTER_PLUGIN_CYREL_UPDATER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace cyrel_updater {

class CyrelUpdaterPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  CyrelUpdaterPlugin();

  virtual ~CyrelUpdaterPlugin();

  // Disallow copy and assign.
  CyrelUpdaterPlugin(const CyrelUpdaterPlugin&) = delete;
  CyrelUpdaterPlugin& operator=(const CyrelUpdaterPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace cyrel_updater

#endif  // FLUTTER_PLUGIN_CYREL_UPDATER_PLUGIN_H_
