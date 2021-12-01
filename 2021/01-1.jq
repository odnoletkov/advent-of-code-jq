[inputs | tonumber]
| [.[:-1], .[1:]] | transpose
| map(select(last > first)) | length
