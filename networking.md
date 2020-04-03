title: networking
summary: a guide to the tools and concepts of how information is passed around the internet
- - - 

# ping

useful for testing if you have any internet at all
```bash
ping www.bbc.co.uk
```

would return something if you are hitting that website.

# ifconfig

# ipconfig

easiest way to get an ip address that you are ssh into 

```
ipconfig getifaddr en0
```

# traceroute

similar to ping but shows the route that your packet took along the way
```bash
traceroute bbc.co.uk
```
output format is 
```
Hop Domain Name [IP Address] RTT1 RTT2 RTT3
1  eehub (192.168.1.254)  2.581 ms  5.016 ms  1.930 ms
2  172.16.19.154 (172.16.19.154)  9.871 ms  11.824 ms  10.069 ms
```
Hop: Whenever a packet is passed between a router, this is referred to as a “hop.” For example, in the output above, we can see that it takes 14 hops to reach How-To Geek’s servers from my current location.
RTT1, RTT2, RTT3: This is the round-trip time that it takes for a packet to get to a hop and back to your computer (in milliseconds). This is often referred to as latency, and is the same number you see when using ping. Traceroute sends three packets to each hop and displays each time, so you have some idea of how consistent (or inconsistent) the latency is. If you see a * in some columns, you didn’t receive a response – which could indicate packet loss.
Domain Name [IP Address]: The domain name, if available, can often help you see the location of a router. If this isn’t available, only the IP address of the router is displayed.



# netstat

# nslookup

# dig

similar to nslookup. gives a bunch of info about dnserver etc

```bash
dig collector-1.tvsquared.com
```

# whois

# finger

# nmap
