## Goal

_data analysis tool_

an object model in computer memory for easily process data or data with same schema.

The table model is commonly used in data analysis because it's easy to understand the data.

## TODO

- passing parameters between functions. Passing object, not a list of parameters. (json object?)
- csv load object, not a dict list
- force table header to string
- a merge. table
    - condi 1, two headers, first header merged
    - condi 2, column merge, 1 to some column are shared by a lot of records.
- Should csv or excel dump program provide any suggestions of formatting?
- use bash command to process table
- 合并和分割表格
- to compare diff of big table, should sort them first.

- Table 自动拆分，按照一个column 来拆，存储到目录中，一个value 一个文件
- Table 合并，有多种情况
- 1. 合并同一个column
- 2. 不同表，column 有部分重合，需要一个column 映射的表
- 3. 将文件append

-  json 比较适合查看 cell value 过长的数据
- TODO: 自动删除空 row, column



## 数据处理

拿到原始数据后修改表头，统一化


## Table processor

- table processor is an object that process data and save results
- the parameter contains
    - the record file
    - the save file
    - the save type is always csv with BOM
    - process function
- using this method I don't have to write dump_csv all the time
- the return value is the processed table for other usage
