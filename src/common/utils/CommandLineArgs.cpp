#ifndef ELPP_DEFAULT_LOGGER
#   define ELPP_DEFAULT_LOGGER "CommandLineArgs"
#endif
#ifndef ELPP_CURR_FILE_PERFORMANCE_LOGGER_ID
#   define ELPP_CURR_FILE_PERFORMANCE_LOGGER_ID ELPP_DEFAULT_LOGGER
#endif

#include "../../../modules/SDL2GuiHelper/common/easylogging/easylogging++.h"
#include "CommandLineArgs.h"

namespace utils {

    CommandLineArgs::CommandLineArgs()
    {
        el::Loggers::getLogger(ELPP_DEFAULT_LOGGER);
        _parameterWithValue.clear();
        _parameter.clear();
    }

    CommandLineArgs::~CommandLineArgs()
    {
        _parameterWithValue.clear();
        _parameter.clear();
    }

    void CommandLineArgs::Pharse(int argc, char **argv) {
        if (argc == 0 || argv == nullptr) {
            return;
        }

        std::string argv_str(argv[0]);
        basePath = argv_str.substr(0, argv_str.find_last_of("/"));

        if (argc == 1) {
            return;
        }

        for (int i = 1; i < argc; ++i) {
            const char* v = (strstr(argv[i], "="));
            if (v != nullptr && strlen(v) > 0) {
                std::string key = std::string(argv[i]);
                key = key.substr(0, key.find_first_of('='));
                if (HasParamWithValue(key)) {
                    LOG(INFO) << "Skipping [" << key << "] arg since it already has value [" << GetParamValue(key) << "]";
                } else {
                    _parameterWithValue.insert(std::make_pair(key, std::string(v + 1)));
                }
            }
            if (v == nullptr) {
                std::string key = std::string(argv[i]);
                if(key.size() > 0) {
                    if (HasParam(key)) {
                        LOG(INFO) << "Skipping [" << key << "] arg since it already exists";
                    } else {
                        _parameter.push_back(std::string(key));
                    }
                }
            }
        }
    }

    bool CommandLineArgs::HasParamWithValue(const std::string& key) {
        const auto it = _parameterWithValue.find(key);
        if(it == _parameterWithValue.end()){
            return false;
        }
        return true;
    }

    bool CommandLineArgs::HasParam(const std::string& key) {
        return std::find(_parameter.begin(), _parameter.end(), key) != _parameter.end();
    }

    std::string CommandLineArgs::GetParamValue(const std::string& key) {
        const auto it = _parameterWithValue.find(key);
        if(it != _parameterWithValue.end()){
            return it->second;
        }
        return std::string("");
    }

}//Namespace