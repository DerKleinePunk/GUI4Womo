#pragma once
#include "string"
#include "map"
#include "vector"

namespace utils
{
    class CommandLineArgs
    {
    private:
        std::map<std::string,std::string> _parameterWithValue;
        std::vector<std::string> _parameter;
        std::string basePath;
    public:
        CommandLineArgs();
        ~CommandLineArgs();

        void Pharse(int argc, char **argv);
        bool HasParamWithValue(const std::string& key);
        bool HasParam(const std::string& key);
        std::string GetParamValue(const std::string& key);
    };

}

