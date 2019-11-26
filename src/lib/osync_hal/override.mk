UNIT_SRC_TOP := $(OVERRIDE_DIR)/src/osync_hal.c
UNIT_CFLAGS  += -I$(OVERRIDE_DIR)/inc
UNIT_DEPS    += src/lib/schema
UNIT_EXPORT_CFLAGS := ${UNIT_CFLAGS}
