PIC_LD=ld

ARCHIVE_OBJS=
ARCHIVE_OBJS += _27097_archive_1.so
_27097_archive_1.so : archive.0/_27097_archive_1.a
	@$(AR) -s $<
	@$(PIC_LD) -shared  -o .//../conv_mac.daidir//_27097_archive_1.so --whole-archive $< --no-whole-archive
	@rm -f $@
	@ln -sf .//../conv_mac.daidir//_27097_archive_1.so $@






%.o: %.c
	$(CC_CG) $(CFLAGS_CG) -c -o $@ $<
CU_UDP_OBJS = \


CU_LVL_OBJS = \
SIM_l.o 

MAIN_OBJS = \
amcQwB.o objs/amcQw_d.o 

CU_OBJS = $(MAIN_OBJS) $(ARCHIVE_OBJS) $(CU_UDP_OBJS) $(CU_LVL_OBJS)

