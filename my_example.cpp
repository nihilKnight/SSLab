#include <iostream>
#include <pthread.h>

#define MAX_THREADS 5
#define MAX_BUF_LEN 100


namespace my_example {

struct Data {
    int id;
    char *msg;
};

pthread_mutex_t mutex_x = PTHREAD_MUTEX_INITIALIZER;
int shared_x = 0;

void *Task(void *data) {

    struct Data *thread_data = (struct Data *)data;

    pthread_mutex_lock(&mutex_x);
    std::cout << "Thread " << thread_data->id << ": Get mutex x." << std::endl;

    shared_x ++;

    std::cout << "Thread " << thread_data->id << ": Return mutex x." << std::endl;
    pthread_mutex_unlock(&mutex_x);

    std::cout << "Thread " << thread_data->id << ": " << thread_data->msg << " x is " << shared_x << "." << std::endl;

    pthread_exit(NULL);

}


void MultiThreadRun() {

    pthread_t threads[MAX_THREADS];
    struct Data thread_datas[MAX_THREADS];

    for (int i = 0; i < MAX_THREADS; i ++) {
        thread_datas[i].id = i;
        thread_datas[i].msg = (char *)malloc(sizeof(char) * MAX_BUF_LEN);
        snprintf(thread_datas[i].msg, MAX_BUF_LEN, "Hello, No.%d!", i * 5 + i * i);
    }

    for (int i = 0;i < MAX_THREADS; i ++) {
        if ( pthread_create(&threads[i], NULL, Task, &thread_datas[i]) ) {
            fprintf(stderr, "Failed to create a new thread.");
            exit(-1);
        }
    }

    pthread_exit(NULL);

}

};


int main() {

    my_example::MultiThreadRun();

}

