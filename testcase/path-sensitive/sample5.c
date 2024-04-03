#include <stdio.h>
#include <string.h>
#include <stddef.h>

#define XLS_RECORD_BOF 0x0809
#define XLS_RECORD_CODEPAGE 0x0042
#define XLS_RECORD_WINDOW1 0x003D
#define XLS_RECORD_SST 0x00FC
#define XLS_RECORD_BOUNDSHEET 0x0085
#define XLS_RECORD_XF 0x00E0
#define XLS_RECORD_FONT 0x0031
#define XLS_RECORD_FONT_ALT 0x0032
#define XLS_RECORD_FORMAT 0x041E
#define XLS_RECORD_STYLE 0x0293
#define XLS_RECORD_1904 0x0022
typedef unsigned char BYTE;
typedef unsigned short WORD;

typedef struct _bof {
    unsigned short id;
    unsigned short size;
} BOF;

typedef struct _xlsWorkBook {
    char is5ver;
} xlsWorkBook;

typedef struct {
    int strings; 
} SST;

typedef struct {
    int name;  
} BOUNDSHEET;

typedef struct {
    int name; 
} FONT;

typedef struct {
    int value;  
} FORMAT;

typedef struct {} WIND1, XF5, XF8;
int xls_isRecordTooSmall(xlsWorkBook *pWB, BOF *bof1, const BYTE* buf) {
    switch (bof1->id) {
        case XLS_RECORD_BOF:	// BIFF5-8
            return (bof1->size < 2 * sizeof(WORD));
        case XLS_RECORD_CODEPAGE:
            return (bof1->size < sizeof(WORD));
		case XLS_RECORD_WINDOW1:
            return (bof1->size < sizeof(WIND1));
        case XLS_RECORD_SST:
            return (bof1->size < offsetof(SST, strings));
        case XLS_RECORD_BOUNDSHEET:
            return (bof1->size < offsetof(BOUNDSHEET, name));
        case XLS_RECORD_XF:
			if(pWB->is5ver) {
                return (bof1->size < sizeof(XF5));
            }
            return (bof1->size < sizeof(XF8));
        case XLS_RECORD_FONT:
        case XLS_RECORD_FONT_ALT:
            return (bof1->size < offsetof(FONT, name));
        case XLS_RECORD_FORMAT:
            return (bof1->size < offsetof(FORMAT, value));
        case XLS_RECORD_STYLE:
            {
                struct {
                    unsigned short idx;
                    unsigned char ident;
                    unsigned char lvl;
                } *styl;
                styl = (void *)buf;
                if(bof1->size < 2) {
                    return 1;
                }
                if(styl->idx & 0x8000) {
                    return bof1->size < 4;
                } else {
                    if(bof1->size < 3) return 1;
                    return bof1->size < 3 + styl->ident;
                }
            }
		case XLS_RECORD_1904:
            return (bof1->size < sizeof(BYTE));
        default:
            break;
    }
    return 0;
}