// SPDX-License-Identifier: GPL-2.0
/*
 * Hidraw Userspace Example
 *
 * Copyright (c) 2010 Alan Ott <alan@signal11.us>
 * Copyright (c) 2010 Signal 11 Software
 *
 * The code may be used by anyone for any purpose,
 * and can serve as a starting point for developing
 * applications using hidraw.
 */

/* Linux */
#include <linux/types.h>
#include <linux/input.h>
#include <linux/hidraw.h>

/*
 * Ugly hack to work around failing compilation on systems that don't
 * yet populate new version of hidraw.h to userspace.
 */
#ifndef HIDIOCSFEATURE
#warning Please have your distro update the userspace kernel headers
#define HIDIOCSFEATURE(len)    _IOC(_IOC_WRITE|_IOC_READ, 'H', 0x06, len)
#define HIDIOCGFEATURE(len)    _IOC(_IOC_WRITE|_IOC_READ, 'H', 0x07, len)
#endif

/* Unix */
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

/* C */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>

#include <unistd.h>

const char *bus_str(int bus);

int main(int argc, char **argv)
{
	int FirmwareVers = 0;
	int fd;
	int i, res, desc_size = 0;
	char buf[256];
	struct hidraw_report_descriptor rpt_desc;
	struct hidraw_devinfo info;
	char *device = "/dev/hidraw1";

	if (argc > 1)
		device = argv[1];

	/* Open the Device with non-blocking reads. In real life,
	   don't use a hard coded path; use libudev instead. */
	fd = open(device, O_RDWR|O_NONBLOCK);

	if (fd < 0) {
		perror("Unable to open device");
		return 1;
	}

	memset(&rpt_desc, 0x0, sizeof(rpt_desc));
	memset(&info, 0x0, sizeof(info));
	memset(buf, 0x0, sizeof(buf));

	/* Get Report Descriptor Size */
	res = ioctl(fd, HIDIOCGRDESCSIZE, &desc_size);
	if (res < 0)
		perror("HIDIOCGRDESCSIZE");
	else
		printf("Report Descriptor Size: %d\n", desc_size);

	/* Get Report Descriptor */
	rpt_desc.size = desc_size;
	res = ioctl(fd, HIDIOCGRDESC, &rpt_desc);
	if (res < 0) {
		perror("HIDIOCGRDESC");
	} else {
		printf("Report Descriptor:\n");
		for (i = 0; i < rpt_desc.size; i++)
			printf("%hhx ", rpt_desc.value[i]);
		puts("\n");
	}

	/* Get Raw Name */
	res = ioctl(fd, HIDIOCGRAWNAME(256), buf);
	if (res < 0)
		perror("HIDIOCGRAWNAME");
	else
		printf("Raw Name: %s\n", buf);

	/* Get Physical Location */
	res = ioctl(fd, HIDIOCGRAWPHYS(256), buf);
	if (res < 0)
		perror("HIDIOCGRAWPHYS");
	else
		printf("Raw Phys: %s\n", buf);

	/* Get Raw Info */
	res = ioctl(fd, HIDIOCGRAWINFO, &info);
	if (res < 0) {
		perror("HIDIOCGRAWINFO");
	} else {
		printf("Raw Info:\n");
		printf("\tbustype: %d (%s)\n",
			info.bustype, bus_str(info.bustype));
		printf("\tvendor: 0x%04hx\n", info.vendor);
		printf("\tproduct: 0x%04hx\n", info.product);
	}

	/* Set Feature */
	buf[0] = 0x9; /* Report Number */
	buf[1] = 0xff;
	buf[2] = 0xff;
	buf[3] = 0xff;
  unsigned char txData[] = {\
    0xff,0x96,0x10,0xbe,0x5b,0x32,0x54,0x11,0xcf,0x83,0x75,0x53,0x8a,0x08,0x6a,0x53,\
    0x58,0xd0,0xb1,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,\
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,\
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00 \
  };

	res = ioctl(fd, HIDIOCSFEATURE(0x40), txData);
	if (res < 0)
		perror("HIDIOCSFEATURE");
	else
		printf("ioctl HIDIOCSFEATURE returned: %d\n", res);

  int j;
  //get the firmwar version of the vive dongle
  //this sometimes takes ages ... not sure why though

  for(j = 0; j < 90; j++){
	   /* Get Feature */
	    buf[0] = 0x5; /* Report Number */
	    res = ioctl(fd, HIDIOCGFEATURE(0x41), buf);
	    if (res < 0) {
		        //perror("HIDIOCGFEATURE");
						;
	    } else {
	          printf("ioctl HIDIOCGFEATURE returned: %d\n", res);
            printf("Sucess ... after %d\n", j);
		        for (i = 0; i < res; i++)
			         printf("%hhx ", buf[i]);


						for (i = 0; i < 4; i++){
							FirmwareVers = (FirmwareVers<<8) | (buf[4-i] & 0x00ff);
						}

						printf("\n\n=========\nFirmware Version: %d",FirmwareVers);

						printf(" ");


						for (i = 8*1; i < 8*2; i++)
							printf("%c", buf[i]);

						printf("@");

						for (i = 8*2; i < res-(2*8)-4; i++)
							printf("%c", buf[i]);

						printf("\n\n");

            break;

		        puts("\n");
	    }
  }


  unsigned char txData2[] = {\
    0xff,0x87,0x06,0x01,0x00,0x00,0x02,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,\
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,\
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,\
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00 \
  };

  res = -1;
  while(res < 0){
	   res = ioctl(fd, HIDIOCSFEATURE(0x40), txData2);
  }
	//if (res < 0)
	//	perror("HIDIOCSFEATURE");
	//else
	//	printf("ioctl HIDIOCSFEATURE returned: %d\n", res);


  unsigned char txData3[] = {\
    0xff,0x83,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,\
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,\
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,\
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00 \
  };
  res = -1;
  while(res < 0){
	   res = ioctl(fd, HIDIOCSFEATURE(0x40), txData3);
  }

  //res = ioctl(fd, HIDIOCSFEATURE(0x40), txData3);
	//if (res < 0)
	//	perror("HIDIOCSFEATURE");
	//else
	//	printf("ioctl HIDIOCSFEATURE returned: %d\n", res);

  buf[0] = 0xff; /* Report Number */
  //res = ioctl(fd, HIDIOCGFEATURE(0x41), buf);

  res = -1;
  while(res < 0){
	   res = ioctl(fd, HIDIOCGFEATURE(0x41), buf); //Should also return Firmware Version
  }

  buf[0] = 0x05; /* Report Number */
  //res = ioctl(fd, HIDIOCGFEATURE(0x41), buf);

  res = -1;
  while(res < 0){
	   res = ioctl(fd, HIDIOCGFEATURE(0x41), buf);
  }



	//=======

	unsigned char txData4[] = {\
    0xff,0x87,0x03,0x00,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,\
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,\
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,\
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00 \
  };
	res = -1;
  while(res < 0){
	   res = ioctl(fd, HIDIOCSFEATURE(0x40), txData4);
  }

	//=======

	buf[0] = 0x01; /* Report Number */
  //res = ioctl(fd, HIDIOCGFEATURE(0x41), buf);

  res = -1;
  while(res < 0){
	   res = ioctl(fd, HIDIOCGFEATURE(0x41), buf);
  }

	//=======

	buf[0] = 0x10; /* Report Number */
  //res = ioctl(fd, HIDIOCGFEATURE(0x41), buf);

  res = -1;
  while(res < 0){
	   res = ioctl(fd, HIDIOCGFEATURE(0x41), buf);
		 usleep(100);
		 //asm("nop");
  }

  //TODO: ONE SET Feature
  // and one get feature

	/* Send a Report to the Device */
  /*
	buf[0] = 0x1; // Report Number
	buf[1] = 0x77;
	res = write(fd, buf, 2);
	if (res < 0) {
		printf("Error: %d\n", errno);
		perror("write");
	} else {
		printf("write() wrote %d bytes\n", res);
	}*/

	/* Get a report from the device */
	//===========================================
	//  NOW we can proberly read the Interrupt data from the dongle
	//===========================================
	for(int j = 0; j < 3000; j++){
		res = read(fd, buf, 32);
		if (res < 0) {
			perror("read");
			usleep(1000);
		} else {
			printf("read() read %d bytes:\n\t", res);
			for (i = 0; i < res; i++)
				printf("%hhx ", buf[i]);
			puts("\n");
		}

	}

	close(fd);
	return 0;
}

const char *
bus_str(int bus)
{
	switch (bus) {
	case BUS_USB:
		return "USB";
		break;
	case BUS_HIL:
		return "HIL";
		break;
	case BUS_BLUETOOTH:
		return "Bluetooth";
		break;
	case BUS_VIRTUAL:
		return "Virtual";
		break;
	default:
		return "Other";
		break;
	}
}
