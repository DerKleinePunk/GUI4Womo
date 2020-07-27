#include "UdpLogClient.hpp"

#include <iostream>
#include <sstream>

bool UdpLogClient::OpenPort(int32_t port) {
    ourSocket = SDLNet_UDP_Open( port );

    if ( ourSocket == nullptr )
    {
        std::cout << "\tSDLNet_UDP_Open failed : " << SDLNet_GetError() << std::endl;
        return false; 
    }

    std::cout << "\tSuccess!\n\n";
    return true;
}

bool UdpLogClient::SetIPAndPort( const std::string &ip, uint16_t port )
{
    std::cout << "Setting IP ( " << ip << " ) " << "and port ( " << port << " )\n";

    // Set IP and port number with correct endianess
    if ( SDLNet_ResolveHost( &serverIP, ip.c_str(), port )  == -1 )
    {
        std::cout << "\tSDLNet_ResolveHost failed : " << SDLNet_GetError() << std::endl;
        return false; 
    }

    std::cout << "\tSuccess!\n\n";
    return true; 
}

bool UdpLogClient::CreatePacket( int32_t packetSize )
{
    std::cout << "Creating packet with size " << packetSize << "...\n";

    // Allocate memory for the packet
    packet = SDLNet_AllocPacket( packetSize );

    if ( packet == nullptr )
    {
        std::cout << "\tSDLNet_AllocPacket failed : " << SDLNet_GetError() << std::endl;
        return false; 
    }

    // Set the destination host and port
    // We got these from calling SetIPAndPort()
    packet->address.host = serverIP.host; 
    packet->address.port = serverIP.port;

    std::cout << "\tSuccess!\n\n";
    return true;
}

UdpLogClient::UdpLogClient() {
    packet = nullptr;
}

UdpLogClient::UdpLogClient(const std::string &ip, int32_t remotePort, int32_t localPort) {
    packet = nullptr;
    if ( !OpenPort(localPort) ) {
		//return false;
    }

	if ( !SetIPAndPort(ip,remotePort)){
        //return false;
    }
		

    if ( !CreatePacket(1024) ) {
		//return false;
    }
}

UdpLogClient::~UdpLogClient() {
    SDLNet_FreePacket(packet);
    packet = nullptr;
}

bool UdpLogClient::Send( const std::string &msg ) {
    
    if(packet == nullptr) return false;

    memcpy(packet->data, msg.c_str(), msg.length() );
	packet->len = msg.length();

    if ( SDLNet_UDP_Send(ourSocket, -1, packet) == 0 )
    {
        std::cout << "\tSDLNet_UDP_Send failed : " << SDLNet_GetError() << std::endl;
        return false; 
    }

    std::cout << "\tSuccess!" << std::endl;
    return true;
}