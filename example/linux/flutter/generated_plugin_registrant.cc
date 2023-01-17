//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <cyrel_updater/cyrel_updater_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) cyrel_updater_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "CyrelUpdaterPlugin");
  cyrel_updater_plugin_register_with_registrar(cyrel_updater_registrar);
}
