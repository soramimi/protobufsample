#include <iostream>
#include "person.pb.h"

int main()
{
	Person person;
	person.set_name("John Doe");
	person.set_id(1234);
	person.set_email("john@example.com");

	std::string serialized;
	person.SerializeToString(&serialized);

//		std::cout << serialized << std::endl;

	Person new_person;
	new_person.ParseFromString(serialized);

	std::cout << new_person.name() << std::endl;
	std::cout << new_person.id() << std::endl;
	std::cout << new_person.email() << std::endl;

	return 0;
}

