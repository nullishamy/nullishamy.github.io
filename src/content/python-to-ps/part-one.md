In this part, we will explore the very basics of PowerShell, and link them to their Python counterparts.

For those more experienced with programming in general, this may be all intuitive enough, but I urge you
to explore the sections further down as we lay the groundwork for the more power user (heh) features present in PS.

## let's get going

To start, let's look at basic IO operations with PS, with Python on the side:
```powershell
$myString = "hello"
Write-Host $myString
<#
PS /> $myString = "hello"                     # myString = 'hello'
PS /> Write-Host $myString                    # print(myString)
hello
#>

$name = Read-Host "What is your username?"    # name = input('What is your username?')
Write-Host $name                              # print(name)
<#
PS /> $name = Read-Host "What is your username?"
What is your username?: amy
PS /> Write-host $name
amy
#>
```

Just this simple example can explain a lot of what makes up PS, let's go through them

### variables

Variables in PS always start with a `$`, much like PHP. Variables are weakly typed, the type can change
as the program progresses.

### verbs

PS functions are based on verbs (see `Get-Verb`), which describe the kind of action being performed:
```powershell
# Verb  Prefix Group   Description
# ----  ------ ------  -----------
  Add   a      Common  Adds a resource to a container, or attaches an item to another item
  Clear cl     Common  Removes all the resources from a container but does not delete the container
  Copy  cp     Common  Copies a resource to another name or to another container
  ....
```

This is not strictly enforced, but is best practice when e.g designing library functions in PS.

### output

Outputs in PS are different to lots of other systems, so deserve their own section.
In our example above, we use `Write-Host` to write our output, this is similar to `print` in Python, but this
is not the only form of output.

| Output function   | Description                                         |
| ----------------- | --------------------------------------------------- |
| Write-Verbose     | Logger: verbose logging                             |
| Write-Debug       | Logger: debug logging                               |
| Write-Information | Logger: informational logging                       |
| Write-Host        | Write direct to the console                         |
| Write-Warning     | Show warnings to the console                        |
| Write-Error       | Show errors to the console                          |
| Write-Progress    | Show a progress bar for an operation in the console |
| Write-Output      | Write to the output pipe                            |

To start, we have 3 logging functions, for opt-in logs that are more verbose than most users need.

We also have our familiar `Write-Host`, which simply outputs to the terminal with no additional filtering
or rendering.

There are 2 outputs for warnings / errors, which will appear yellow / red respectively in the console.

`Write-Progress` is unique, showing a live progress bar for e.g download operations.
If you terminal does not support ANSI escapes, it will render line-by-line.

Finally, we have `Write-Output`, which writes to the special output pipe. This allows for output to be streamed out of cmdlets in order to create chains of commands. This is best shown with an example:
```powershell
PS /> function CreateOutputStream {
>>      for ($i = 0; $i -lt 10; $i++ ) {
>>        $value = [PSCustomObject]@{
>>          Value = $i
>>          Doubled = $i * 2
>>        }
>>
>>        Write-Output $value
>>      }
>>    }
>>
PS /> CreateOutputStream | Format-Table
Value Doubled
----- -------
    0       0
    1       2
    2       4
    3       6
    4       8
    5      10
    6      12
    7      14
    8      16
    9      18
```

Roughly, the above translates to:
```python
def create_output_stream():
  output = []
  
  for i in range(10):
    output.append({ value: i, doubled: i * 2 })
  
  return output

print(create_output_stream())
```

The syntax regarding `[PSCustomObject]` is only formulating a simple object to hold our outputs, akin to a 
`dict` in this context.

We can see that each set of values is output into the table, using the keys we gave it as the headings.

### cmdlets
Building on our previous example, we could then start to chain cmdlets together to build a pipeline.
For our simple examples here, all of our cmdlets will be functions, but you can also call files directly as
if they were functions, passing parameters and reading outputs as you'd expect.
```powershell
PS /> CreateOutputStream
  | ForEach-Object { [PSCustomObject]@{ Old = $_; Trippled = $_.Value * 3 } } 
  | Format-Table
Old                    Trippled
---                    --------
@{Value=0; Doubled=0}         0
@{Value=1; Doubled=2}         3
@{Value=2; Doubled=4}         6
@{Value=3; Doubled=6}         9
@{Value=4; Doubled=8}        12
@{Value=5; Doubled=10}       15
@{Value=6; Doubled=12}       18
@{Value=7; Doubled=14}       21
@{Value=8; Doubled=16}       24
@{Value=9; Doubled=18}       27
```

As you script more with PS, you will build a repertoire of common cmdlets that you use to iterate, filter, sort, etc:
| Cmdlet            | Description                                         |
| ----------------- | --------------------------------------------------- |
| ForEach-Object    | Iterate a pipeline, acting as a map                 |
| Where-Object      | Filter a pipeline based on a predicate              |
| Select-Object     | Select a subset of keys from objects in a pipeline  |
| Sort-Object       | Sort a pipeline based on an object key              |

In our example, we use `ForEach-Object` combined with the `$_` magic value to get the current pipeline object
to create a mapper producing the trippled value!

### to conclude

With just these basic examples, you can see how similarly powerful PS is comapred to other scripting solutions.

This power will only evolve as we start to explore the vast PS library collection, and investigate how
we can build powerful automations, all without a single dependency! 

Stay tuned for more.