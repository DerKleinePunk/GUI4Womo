#pragma once

#include "../../../modules/SDL2GuiHelper/common/easylogging/easylogging++.h"
#include "UdpLogClient.hpp"

class LogNetDispatcher : public el::LogDispatchCallback
{
public:
    void updateServer(const std::string& host, int32_t remotePort, int32_t localPort ) {
        _logclient = std::unique_ptr<UdpLogClient>(new UdpLogClient(host, remotePort, localPort));
    }
protected:
  void handle(const el::LogDispatchData* data) noexcept override {
      m_data = data;
      // Dispatch using default log builder of logger
      dispatch(m_data->logMessage()->logger()->logBuilder()->build(m_data->logMessage(),
                 m_data->dispatchAction() == el::base::DispatchAction::NormalLog));
  }
private:
  const el::LogDispatchData* m_data;
  std::unique_ptr<UdpLogClient> _logclient;
  
  void dispatch(el::base::type::string_t&& logLine) noexcept {
      _logclient->Send(logLine);
  }

};