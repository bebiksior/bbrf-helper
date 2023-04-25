## Usage
To run the script, use the following command:

```
./bbrf_helper.sh <type> <input>
```

`<type>` is the type of input you will be providing, currently only **domains** is supported.
`<input>` is the file path to the text file containing the list of subdomains.

## How it works
The script will take the list of domains provided, extract the apexes of each domain, create a new program on bbrf for each apex, and add subdomains to each program.
