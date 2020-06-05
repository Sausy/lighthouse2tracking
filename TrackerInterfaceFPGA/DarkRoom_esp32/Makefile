# Include the nanopb provided Makefile rules
include nanopb/extra/nanopb.mk

# Build rule for the protocol
lighthouse_sensor.pb.c: lighthouse.proto
	$(PROTOC) $(PROTOC_OPTS) --nanopb_out=. lighthouse.proto

