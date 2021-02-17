title: networking
summary: a guide to the tools and concepts of how information is passed around the internet
- - - 

# networking

## networking concepts

### vpn

vpn are used to login to a private network from outside. 

### switch

a switch con-ordinates communication around a local network, allowing devices to speak to one another.


### router

directions information within a local network and connects to a larger network
hides the private network from the internet.


### proxies

works at the application layer at act as a man in the middle to redirect internet traffic on. 
it accepts a request from a client, creates a connection to the destination returns the 
response back to the client.

### foward proxy

machine that formward traffic to the internet on behalf f the browser.
common in business where they want to monitor or restrict the websites or applications you use.

### back proxy

### how browses and web-severs work

- web servers run a tcp socket on a port
- web browser specifies a url
- wweb browser initiates TCP connection
- DNS lookup for ip 
- server ACKs browser connection
- http request sent via network routers
- server sends back response 

### what is localhost?

it is a loopback address for the current machine you are using.
It typically starts with 127

### firewalls



## networking tools

### curl 

tool for transfer data about the internet
#### basic website test

```bash
curl -v http://localhost:888
```


### ping

useful for testing if you have any internet at all
```bash
ping www.bbc.co.uk
```

would return something if you are hitting that website.

### ifconfig
**get ip address on mac**
```
ifconfig | grep "inet" | grep -v 127.0.0.1
```

### ipconfig

### arp 

gives all the devices on a local network with their name, MAC address and IP.
Basically gives you the lookup table for the local subnet.

```bash 
arp -a 
```
easiest way to get an ip address that you are ssh into 

```
ipconfig getifaddr en0
```

### traceroute

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

### netcat

#### smaller server to send and recieve

```
# now listening on 4444
nc -d 4444 -l

# connect other side
nc localhost 4444
```

#### can fire http requests straight to a port

```
echo "GET / HTTP/1.1\r\nHost:example.com\r\n\r\n" | nc example.com 80
```
gives back the http request you sent.

or 

```
nc localhost 8888 <<< GET /hello HTTP/1.1
```



#### send a file quickly over a local network
on linux
```bash 
# on target
hostname -I <some ip> 
nc -l 9931 > bigfile

# on source
cat bigfile | nc <some ip>
```

### netstat

### nslookup

### dig

similar to nslookup. gives a bunch of info about dnserver etc

```bash
dig collector-1.tvsquared.com
```

### whois

### finger

### nmap

super power but incomprehensible

#### check if a port is open

```
nmap -p 8080 backend.preprev.tvsquared.private
```

#### **get all hosts on a LAN**

```
nmap -sP <subnet cidr>
nmap -sP 192.168.1.1/24
```

#### **scan all ports within range**

```
nmap localhost -p 31000-32000 -A
```


### nc

netcat: useful tool for debuging network connections

example
```
# listen on a port
nc - l 2003

# send something to the port
echo "test" | nc localhost 2003
```

### tcpdump

#### what dns queries is my laptop send

```
tcpdump -i any port 53
```

#### do I have any packets coming onto port 1337

```
tcpdump -i any port 1337
```

#### what packets are coming onto my from a specific

```
tcpdump port 1337 and host <ip>
```

#### see dns queries that fail
```
tcpdump udp[11]&0xf==3
```

measures and outputs network traffic

```
sudo tcpdump -i any port 53
```
go to a website and then see all the network info

# to learn
- wireshark ``to_learn
what vpns and networks do to your public ip addess
- what vpns and networks do to your public ip addess ``to_learn
- what vpns and networks do to your public ip addess xxto_learn
