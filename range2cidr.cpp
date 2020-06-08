    #include <string>
    #include <iostream>
    #include <netinet/in.h>
    #include <arpa/inet.h>
    #include <boost/utility/string_ref.hpp>
    #include <vector>
    #include <algorithm>
    #include <array>
    #include <cstdint>
    #include <unistd.h>
    #include <boost/range/algorithm/copy.hpp>
    #include <ciso646>
     
    namespace {
    	uint32_t ipv4_to_uint (boost::string_ref parIP) {
    		const auto max_ip_str_len = 3 * 4 + 3 + 1;
    		struct in_addr addr;
     
    		std::array<char, max_ip_str_len> ip_cpy;
    		std::copy(parIP.begin(), parIP.end(), ip_cpy.begin());
    		ip_cpy[parIP.size()] = '\0';
    		inet_aton(ip_cpy.data(), &addr);
    		return ntohl(addr.s_addr);
    	}
     
    	//see: http://stackoverflow.com/questions/28339094/calculating-list-of-subnets-that-make-a-given-ip-range
    	std::vector<std::string> subnets (uint32_t parStartIP, uint32_t parEndIP) {
    		std::vector<std::string> retval;
    		uint32_t host_bits = 0;
    		uint32_t tmp = parStartIP ^ parEndIP;
    		while(tmp != 0){
    			tmp = tmp >> 1;
    			host_bits++;
    		}
    		const uint32_t host_mask = static_cast<uint32_t>(-1) >> (32 - host_bits);
    		uint32_t network_addr = parStartIP & (-1 ^ host_mask);
    		uint32_t broadcast_addr = parStartIP | host_mask;
    		if(host_bits > 1){
    			const uint32_t split_low = (network_addr | host_mask >> 1);
    			const uint32_t split_high =(broadcast_addr & (-1 ^ host_mask >> 1));
    			if(parStartIP != network_addr || parEndIP != broadcast_addr){
    				retval = subnets(parStartIP, split_low);
    				auto temp_vec = subnets(split_high, parEndIP);
    				retval.insert(retval.end(), std::make_move_iterator(temp_vec.begin()), std::make_move_iterator(temp_vec.end()));
    			}
    			else {
    				struct in_addr ip_addr;
    				ip_addr.s_addr = htonl(parStartIP);
    				retval.push_back(std::string(inet_ntoa(ip_addr)) + "/" + std::to_string(32-host_bits));
    			}
    		}
    		else {
    			struct in_addr ip_addr;
    			ip_addr.s_addr = htonl(parStartIP);
    			retval.push_back(std::string(inet_ntoa(ip_addr)) + "/" + std::to_string(32-host_bits));
    		}
    		return retval;
    	}
     
    	std::vector<std::string> range_to_cidr (boost::string_ref parFrom, boost::string_ref parTo) {
    		const auto from = ipv4_to_uint(parFrom);
    		const auto to = ipv4_to_uint(parTo);
     
    		return subnets(from, to);
    	}
     
    	void print_range (boost::string_ref parRange) {
    		const auto hyphen_pos = parRange.find('-');
    		if (boost::string_ref::npos == hyphen_pos) {
    			std::cout << parRange << std::endl;
    		}
    		else {
    			boost::range::copy(
    				range_to_cidr(parRange.substr(0, hyphen_pos), parRange.substr(hyphen_pos + 1)),
    				std::ostream_iterator<std::string>(std::cout, "\n")
    			);
    		}
    	}
    } //unnamed namespace
     
    int main (int argc, char* argv[]) {
    	using std::string;
    	using boost::string_ref;
     
    	if (not isatty(STDIN_FILENO)) {
    		string curr_range;
    		while (std::cin >> curr_range) {
    			print_range(curr_range);
    		}
    	}
    	else {
    		for (int z = 1; z < argc; ++z) {
    			print_range(string_ref(argv[z]));
    		}
    	}
     
    	return 0;
    }
