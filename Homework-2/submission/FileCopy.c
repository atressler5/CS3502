//Andrew Tressler
//CS3502
//2 October 2025


#include <stdio.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sysexits.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>


// write n bytes to passed directory
static int write_all(int directory, const void *buf, size_t n) {
    const unsigned char *p = (const unsigned char *)buf;
    while (n > 0) {
        ssize_t w = write(directory, p, n);
        if (w < 0) {
            // retry if interrupted
            if (errno == EINTR) continue;
            return -1;
        }
        p += (size_t)w;
        n -= (size_t)w;
    }
    return 0;
}

int main() {
    // made strings large to avoid overflow
    char sourceFileName[100];
    char destFileName[100];

    //user input, open source file and make new destination
    printf("Enter source file name: ");
    fflush(stdout);
    if (!fgets(sourceFileName, sizeof(sourceFileName), stdin)) {
        fprintf(stderr, "Failed to read source file name.\n");
        return EX_USAGE;
    }
    // remove newline
    sourceFileName[strcspn(sourceFileName, "\n")] = '\0';

    printf("Enter destination file name: ");
    fflush(stdout);
    if (!fgets(destFileName, sizeof(destFileName), stdin)) {
        fprintf(stderr, "Failed to read destination file name.\n");
        return EX_USAGE;
    }
    destFileName[strcspn(destFileName, "\n")] = '\0';

    
    int sourceFile = open(sourceFileName, O_RDONLY);
    if (sourceFile == -1) {
        perror("Error opening source file");
        return EX_NOINPUT;
    }

    //make new file
    int destFile = open(destFileName, O_WRONLY | O_CREAT | O_EXCL, 0644);
    if (destFile == -1) {
        if (errno == EEXIST) {
            fprintf(stderr, "Error: destination file already exists: %s\n", destFileName);
        } else {
            perror("Error creating destination file");
        }
        close(sourceFile);
        return EX_CANTCREAT;
    }

    
    char buffer[8192];
    while(1) {
        ssize_t r = read(sourceFile, buffer, sizeof buffer);
        if (r > 0) {
            if (write_all(destFile, buffer, (size_t)r) == -1) {
                perror("Error writing to destination file");
                close(sourceFile);
                close(destFile);
                return EX_IOERR;
            }
        } else if (r == 0) {
            break;
        } else {
            //retry if interrupted
            if (errno == EINTR) continue;
            perror("Error reading source file");
            close(sourceFile);
            close(destFile);
            return EX_IOERR;
        }
    }


    // Cleanup
    if (close(sourceFile) == -1) {
        perror("Warning: close(source) failed");
    }
    if (close(destFile) == -1) {
        perror("Warning: close(dest) failed");
        return EX_IOERR;
    }

    //somehow worked
    return 0;
}
