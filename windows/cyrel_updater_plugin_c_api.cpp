#include "include/cyrel_updater/cyrel_updater_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "cyrel_updater_plugin.h"

void CyrelUpdaterPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  cyrel_updater::CyrelUpdaterPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
