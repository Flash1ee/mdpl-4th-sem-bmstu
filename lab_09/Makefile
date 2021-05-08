CC=gcc
SRC=./src
INC=./inc
OUT=./out
SOURCES=$(wildcard $(SRC)/*.c)
OBJS=$(SOURCES:$(SRC)/%.c=$(OUT)/%.o)
INCS=$(wildcard $(INC)/*.h)
CFLAGS=-std=c99 -I$(INC)/

FPU_INST_FRST=-M80387
FPU_INST_SEC=-MNO-80387

TARGET=$(OUT)/main.out
TARGET_MNO_80387=main_mno-80387.out
TARGET_M_80387=main_m80387.out

.PHONY: build clean run

run: build
	$(TARGET)

build: $(OBJS) $(INCS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS)


$(OUT)/%.o: $(SRC)/%.c $(OUT)
	$(CC) $(CFLAGS) -c $< -o $@

$(OUT):
	mkdir -p $(OUT)


clean:
	rm -f *.o
	rm -f *.out
	rm -rf $(OUT)