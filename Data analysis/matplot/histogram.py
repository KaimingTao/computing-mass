import matplotlib.pyplot as plt


def histogram(
        file_path, data, xlabel, ylabel, figsize=(10, 6), bins=50, config={}):
    plt.figure(figsize=figsize)
    _, bin_edges, _ = plt.hist(
        data,
        bins=bins,
        edgecolor='black',
        color='skyblue',
        alpha=0.7)

    if config.get('log_y'):
        plt.yscale('log')

    plt.xlim(min(data), max(data))
    # bin_edges = [
    #     int(i) for i in bin_edges
    # ]
    # plt.xticks(bin_edges, minor=False, rotation=90)
    plt.xlabel(xlabel)
    plt.ylabel(ylabel)
    # plt.grid(True, which='both', linestyle='--', linewidth=0.5)
    plt.savefig(file_path)
