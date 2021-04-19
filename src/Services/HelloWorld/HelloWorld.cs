using System;
using NLog;
using NWN.API;
using NWN.Services;

namespace YourModuleName {
    [ServiceBinding(typeof(HelloWorld))]
    public class HelloWorld {
        private static readonly Logger Log = LogManager.GetCurrentClassLogger();
        public HelloWorld(NativeEventService nativeEventService, ScriptEventService scriptEventService) {
            NwModule.Instance.OnPlayerChat += onChat => {
                Log.Debug(onChat.Message);
            };

            NwModule.Instance.OnModuleLoad += onLoad => {
                Log.Debug("Module booted at : " + DateTime.Now);
            };
        }
    }
}