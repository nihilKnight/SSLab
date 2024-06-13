#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <iostream>

namespace p18_datarace {

int global_data = 5;

struct device {
    pthread_mutex_t lock;
    int data;
    int *ptr;
};

void *ThreadFunc1(void *arg) {
    struct device *dev = (struct device *)arg;

    pthread_mutex_lock(&dev->lock);
    dev->data ++;
    pthread_mutex_unlock(&dev->lock);

    pthread_exit(NULL);
}

void *ThreadFunc2(void *arg) {
    struct device *dev = (struct device *)arg;

    dev->ptr = &global_data;
    dev->data ++;
    // free(dev->ptr);

    pthread_exit(NULL);
}

void Run() {

    pthread_t thread1, thread2;
    pthread_mutex_t lock;
    struct device dev;
    int local_data = 10;
    int rc;

    dev.lock = lock;
    dev.data = local_data;
    dev.ptr = &local_data;

    std::cout << "Initializing..." << std::endl;
    std::cout << "local_data: " << std::dec << local_data << std::endl;
    std::cout << "&local_data: " << std::hex << &local_data << std::endl;
    std::cout << "global_data: " << std::dec << global_data << std::endl;
    std::cout << "&global_data: " << std::hex << &global_data << std::endl;
    std::cout << "dev.data: " << std::dec << dev.data << std::endl;
    std::cout << "dev.ptr: " << std::hex << dev.ptr << std::endl;

    if ( (rc = pthread_create(&thread1, NULL, ThreadFunc1, (void *)&dev)) ) {
        fprintf(stderr, "Failed to create new thread, debug: rc=%d.\n", rc);
        exit(1);
    }

    if ( (rc = pthread_create(&thread2, NULL, ThreadFunc2, (void *)&dev)) ) {
        fprintf(stderr, "Failed to create new thread, debug: rc=%d.\n", rc);
        exit(1);
    }

    if (pthread_join(thread1, NULL)) {
        fprintf(stderr, "Failed to join thread 1.\n");
        exit(1);
    }

    if (pthread_join(thread2, NULL)) {
        fprintf(stderr, "Failed to join thread 2.\n");
        exit(1);
    }

    std::cout << std::endl << "Results:" << std::endl;
    std::cout << "dev.data: " << std::dec << dev.data << std::endl;
    std::cout << "dev.ptr: " << std::hex << dev.ptr << std::endl;

    pthread_exit(NULL);

}

};

int main() {

    p18_datarace::Run();

}


