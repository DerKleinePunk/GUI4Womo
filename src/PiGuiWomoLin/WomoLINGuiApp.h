#pragma once

#include "../../modules/SDL2GuiHelper/src/MiniKernel.h"
#include "../../modules/SDL2GuiHelper/src/gui/GUIElementManager.h"

class WomoLINGuiApp
{
private:
    MiniKernel* _kernel;
    GUIElementManager* _manager;
    void ApplicationEvent(AppEvent event, void* data1, void* data2);
    void KernelstateChanged(KernelState state);
public:
    WomoLINGuiApp(MiniKernel* kernel);
    virtual ~WomoLINGuiApp();

    void Startup();
    void Shutdown();
};


