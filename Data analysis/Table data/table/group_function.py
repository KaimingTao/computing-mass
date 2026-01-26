# group function using the same parameter and functioning very similar behavior
# like initialization

# executor is the acually function that run all sub functions
# it should be a class

class FunctionGroupExecutor:

    def __init__(self, exec):
        if not exec:
            raise Exception("Executor is null")
        self.executor = exec
        self.func_list = []

    def append(self, func):
        # No priority
        if not func:
            return
        self.func_list.append(func)

    def __call__(self, *args, **kwargs):
        for func in self.func_list:
            func(*args, **kwargs)


def registor_to_executor(function):
    def wrapper(executor):
        executor.append(function)
    return wrapper
