/**
* @file main.cpp
* @author Michael Nenninger
* @brief Mainentry
*/

#define SDL_MAIN_HANDLED
#include <iostream>
#include "../../modules/SDL2GuiHelper/common/easylogging/easylogging++.h"
#include "../../modules/SDL2GuiHelper/common/utils/commonutils.h"
#include "../../modules/SDL2GuiHelper/src/MiniKernel.h"

INITIALIZE_EASYLOGGINGPP
int main(int argc, char **argv)
{
    std::cout << "Starting Test App" << std::endl;
    START_EASYLOGGINGPP(argc, argv);
    if(utils::FileExists("logger.conf")) {
        // Load configuration from file
        el::Configurations conf("logger.conf");
        // Now all the loggers will use configuration from file and new loggers
        el::Loggers::setDefaultConfigurations(conf, true);
    }

    el::Helpers::setThreadName("Main");

    auto returncode = 0;

    return returncode;
}