def cui_counter(generator):
    BATCH = 50

    def wrapper():
        nonlocal BATCH
        counter = 0
        for i in generator():
            counter += 1
            if counter % BATCH == 0:
                print('----', counter)
            yield i

    return wrapper


def cui_counter(prompt_str):
    def cui_counter(generator):
        BATCH = 50

        def wrapper():
            nonlocal BATCH
            counter = 0
            for i in generator():
                counter += 1
                if counter % BATCH == 0:
                    print('----', counter)
                yield i

        return wrapper
    return cui_counter
