#include <stdio.h>

typedef struct Table = {
	char *data[255],
	unsigned int cid = 0
} table;

table idTable = {[], [], 0};

char *getByID(int id) {
	return data[id];
}

unsigned int addData(char *newData) {
	if (sizeof(data) / sizeof(char *) > 255) {
		printf(stderr, "idTableException: Table is full.\n");
		return 0;
	}
	
	idTable.data[idTable.cid++] = newData;	
	return idTable.cid - 1;
}
