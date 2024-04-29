#include <stddef.h>

#define XLS_RECORD_FORMULA 0x0006
#define XLS_RECORD_FORMULA_ALT 0x000A
#define XLS_RECORD_MULRK 0x00BD
#define XLS_RECORD_MULBLANK 0x00BE
#define XLS_RECORD_LABELSST 0x00FC
#define XLS_RECORD_LABEL 0x0204
#define XLS_RECORD_RSTRING 0x00D6
#define XLS_RECORD_RK 0x0007
#define XLS_RECORD_NUMBER 0x0203
#define XLS_RECORD_BOOLERR 0x0205
typedef unsigned char BYTE;

typedef struct BOF {
    unsigned short id;       
    unsigned short size;    
} BOF;

typedef struct COL {
    unsigned short val;
} COL;

typedef struct FORMULA {
    unsigned short val;
} FORMULA;

typedef struct MULRK {
    unsigned short val;
    unsigned short rk;
} MULRK;

typedef struct MULBLANK {
    unsigned short val;
    unsigned short xf;
} MULBLANK;

typedef struct LABEL {
    unsigned short value[3];
} LABEL;

typedef struct RK {
    unsigned short val;
    unsigned short xf;
} RK;

typedef struct BR_NUMBER {
    unsigned short val;
} BR_NUMBER;

typedef struct BOOLERR {
    unsigned short val;
} BOOLERR;

typedef struct xlsWorkBook {
    int is5ver;
} xlsWorkBook;

int xls_isCellTooSmall(xlsWorkBook* pWB, BOF* bof, BYTE* buf) {
    if (bof->size < sizeof(COL))
        return 1;

    if (bof->id == XLS_RECORD_FORMULA || bof->id == XLS_RECORD_FORMULA_ALT)
        return (bof->size < sizeof(FORMULA));

    if (bof->id == XLS_RECORD_MULRK)
        return (bof->size < offsetof(MULRK, rk));

    if (bof->id == XLS_RECORD_MULBLANK)
        return (bof->size < offsetof(MULBLANK, xf));

    if (bof->id == XLS_RECORD_LABELSST)
        return (bof->size < offsetof(LABEL, value) + (pWB->is5ver ? 2 : 4));

    if (bof->id == XLS_RECORD_LABEL || bof->id == XLS_RECORD_RSTRING) {
        if (bof->size < offsetof(LABEL, value) + 2)
            return 1;

        size_t label_len = ((LABEL*)buf)->value[0] + (((LABEL*)buf)->value[1] << 8);
        if (pWB->is5ver) {
            return (bof->size < offsetof(LABEL, value) + 2 + label_len);
        }

        if (bof->size < offsetof(LABEL, value) + 3)
            return 1;

        if ((((LABEL*)buf)->value[2] & 0x01) == 0) {
            return (bof->size < offsetof(LABEL, value) + 3 + label_len);
        }
        return (bof->size < offsetof(LABEL, value) + 3 + 2 * label_len);
    }

    if (bof->id == XLS_RECORD_RK)
        return (bof->size < sizeof(RK));

    if (bof->id == XLS_RECORD_NUMBER)
        return (bof->size < sizeof(BR_NUMBER));

    if (bof->id == XLS_RECORD_BOOLERR)
        return (bof->size < sizeof(BOOLERR));

    return 0;
}

