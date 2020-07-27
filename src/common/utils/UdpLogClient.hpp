#pragma once

#include <SDL_net.h>
#include <string>

class UdpLogClient {
	UDPsocket ourSocket;
	IPaddress serverIP;
	UDPpacket *packet;

    bool OpenPort(int32_t port);
    bool SetIPAndPort( const std::string &ip, uint16_t port );
    bool CreatePacket( int32_t packetSize );
public:
    UdpLogClient();
    UdpLogClient(const std::string &ip, int32_t remotePort, int32_t localPort);
    ~UdpLogClient();

    bool Send( const std::string &msg );

};