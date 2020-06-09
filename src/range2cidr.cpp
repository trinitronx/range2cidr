#include "config.h"
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
#ifdef HAVE_POPT_H
#include <popt.h>
#endif
#include <stdbool.h>
#include "verbose.h"

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
#ifdef HAVE_LIBPOPT
    printf("(%s:%d) whee...we have popt.h\n",__FILE__,__LINE__);
    /* option parsing variables */
    char ch;
    poptContext opt_con;   /* context for parsing command-line options */
    char *extra_arg;
    static const char *f="";

    static struct poptOption options_table[] = {
        { "file", 'f', POPT_ARG_STRING, &f, 'f', "read IP range input from file", "STRING" },
        { "verbose", 'v', POPT_ARG_NONE, NULL, 'v', "enable verbose", "" },
        POPT_AUTOHELP
        { NULL, 0, 0, NULL, 0 } /* end-of-list terminator */
    };

    opt_con = poptGetContext(NULL, argc, (const char **)argv, options_table, 0);

    verbose("Verbose is off\n");
    /* Now do options processing */
    while ((ch = poptGetNextOpt(opt_con)) >= 0) {
        printf("between while & switch: ch = %c\n", ch);
        switch (ch) {
            case 'f':
                    printf("handling 'f' option.\n");
                    break;
            case 'v':
                    printf("handling 'v' option.\n");
                    setVerbose(true);
                    verbose("Verbose is on\n");
                    break;
            default:
                    printf("unknown option '%c'.\n",ch);
                    exit(EXIT_FAILURE);
                    break;
        }
    }

    if (ch < -1) {
        // the user specified an invalid option, tell them
        poptPrintHelp(opt_con, stderr, 0);
    }

    /* non-option args */
    while ((extra_arg = (char *)poptGetArg(opt_con))) {
        printf("extra arg: %s\n", extra_arg);
        exit(1);
    }


    /* cleanup */
    poptFreeContext(opt_con);

    printf("(%s:%d) s = '%s'\n",__FILE__,__LINE__,f);
    printf("(%s:%d) v = %d\n",__FILE__,__LINE__,getVerbose());
#else
	printf("(%s:%d) rats...we don't have popt.h\n",__FILE__,__LINE__);
#endif

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
