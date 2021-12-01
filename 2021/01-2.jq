[inputs | tonumber]
| [., .[1:], .[2:]] | transpose[:-2]
| map(add)
| [., .[1:]] | transpose[:-1]
| map(select(last > first)) | length
