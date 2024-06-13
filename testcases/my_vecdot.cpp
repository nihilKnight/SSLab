// #define DEF_RAND

#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

#ifdef DEF_RAND
    #include <random>
#endif

#define NUMTHRDS 4
#define VECLEN 100000


typedef struct
{
    double *a;
    double *b;
    double sum;
    int veclen;
} DOTDATA;


DOTDATA dotstr;
pthread_t callThd[NUMTHRDS];
pthread_mutex_t mutexsum;


void *dotprod(void *arg)
{

    int i, start, end, len;
    long offset;
    double mysum, *x, *y;
    offset = (long) arg;

    len = dotstr.veclen;
    start = offset * len;
    end = start + len;
    x = dotstr.a;
    y = dotstr.b;

    mysum = 0;
    for (i = start; i < end; i++) {
        mysum += (x[i] * y[i]);
    }

    
    /** In fact, there's not need to add a lock. */
    // pthread_mutex_lock(&mutexsum);

    dotstr.sum += mysum;
    
    printf("Thread %ld did %d to %d: mysum=%f global sum=%f\n", offset, start, end, mysum, dotstr.sum);

    // pthread_mutex_unlock(&mutexsum);
    pthread_exit((void *) 0);
}


int main(int argc, char *argv[])
{
    long i;
    double *a, *b;
    void *status;
    pthread_attr_t attr;

#ifdef DEF_RAND
    std::random_device dev;
    std::mt19937 rng(dev());
    std::uniform_int_distribution<std::mt19937::result_type> dist(1, 1000);
#endif

    a = (double *) malloc(NUMTHRDS * VECLEN * sizeof(double));
    b = (double *) malloc(NUMTHRDS * VECLEN * sizeof(double));

    for (i = 0; i < VECLEN * NUMTHRDS; i++) {

#ifdef DEF_RAND
        a[i] = dist(rng) * 1.0 / 100;
        b[i] = dist(rng) * 1.0 / 100;
#else
        a[i] = 1;
        b[i] = 1;
#endif

    }

    dotstr.veclen = VECLEN;
    dotstr.a = a;
    dotstr.b = b;
    dotstr.sum = 0;

    pthread_mutex_init(&mutexsum, NULL);
    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);

    for (i = 0; i < NUMTHRDS; i++) {
        pthread_create(&callThd[i], &attr, dotprod, (void *) i);
    }

    pthread_attr_destroy(&attr);

    for (i = 0; i < NUMTHRDS; i++) {
        pthread_join(callThd[i], &status);
    }


    printf("Sum =  %f \n", dotstr.sum);
    free(a);
    free(b);
    pthread_mutex_destroy(&mutexsum);
    pthread_exit(NULL);


}
