
#pragma GCC diagnostic ignored "-Wunused-local-typedefs"

#include <string>
#include <iostream>

#include <boost/bimap.hpp>

template< class MapType >
void print_map(const MapType & map,
               const std::string & separator,
               std::ostream & os )
{
    typedef typename MapType::const_iterator const_iterator;

    for( const_iterator i = map.begin(), iend = map.end(); i != iend; ++i )
    {
        os << i->first << separator << i->second << std::endl;
    }
}

int main()
{
	boost::bimap<int, int> mapping
			{1, 1}
	;

	return 0;
    // Soccer World cup

    typedef boost::bimap< std::string, int > results_bimap;
    typedef results_bimap::value_type position;

    results_bimap results;
    results.insert( position("Argentina"    ,1) );
    results.insert( position("Spain"        ,2) );
    results.insert( position("Germany"      ,3) );
    results.insert( position("France"       ,4) );

    std::cout << "The number of countries is " << results.size()
              << std::endl;

    std::cout << "The winner is " << results.right.at(1)
              << std::endl
              << std::endl;

    std::cout << "Countries names ordered by their final position:"
              << std::endl;

    // results.right works like a std::map< int, std::string >

    print_map( results.right, ") ", std::cout );

    std::cout << std::endl
              << "Countries names ordered alphabetically along with"
                    "their final position:"
              << std::endl;

    // results.left works like a std::map< std::string, int >

    print_map( results.left, " ends in position ", std::cout );

    return 0;
}
//]
