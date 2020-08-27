#ifndef ELPP_DEFAULT_LOGGER
#define ELPP_DEFAULT_LOGGER "WomoLINGuiApp"
#endif
#ifndef ELPP_CURR_FILE_PERFORMANCE_LOGGER_ID
#define ELPP_CURR_FILE_PERFORMANCE_LOGGER_ID ELPP_DEFAULT_LOGGER
#endif

#include "WomoLINGuiApp.h"
#include "../../modules/SDL2GuiHelper/src/Elements.h"
#include <chrono>
#include <thread>

void WomoLINGuiApp::ApplicationEvent(AppEvent event, void* data1, void* data2)
{

}

void WomoLINGuiApp::KernelstateChanged(KernelState state)
{
    if (state == KernelState::Startup) {
        LOG(INFO) << "Kernel is up Create Screen";
    }
}

WomoLINGuiApp::WomoLINGuiApp(MiniKernel* kernel)
{
    el::Loggers::getLogger(ELPP_DEFAULT_LOGGER);
    _kernel = kernel;
}

WomoLINGuiApp::~WomoLINGuiApp()
{
}

void WomoLINGuiApp::Startup() {
    auto statedelegate = std::bind(&WomoLINGuiApp::KernelstateChanged, this, std::placeholders::_1);
    _kernel->SetStateCallBack(statedelegate);
    auto eventdelegate = std::bind(&WomoLINGuiApp::ApplicationEvent, this, std::placeholders::_1, std::placeholders::_2, std::placeholders::_3);
    _kernel->RegisterApplicationEvent(eventdelegate);
}

void WomoLINGuiApp::Shutdown() {

}