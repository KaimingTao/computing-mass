ax.set_xlabel(
    "Year",
    labelpad=15,
    fontsize=15)

ax.tick_params(
    axis='both',
    which='major',
    labelsize=12)

## legend
ax.legend(title="title")


## layout use default best

plt.tight_layout()

## save image or show
plt.show()
plt.savefig('1.png')
