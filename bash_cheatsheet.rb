cheatsheet do
  title 'Bash'               # Will be displayed by Dash in the docset list
  docset_file_name 'Bash'    # Used for the filename of the docset
  keyword 'Bash'             # Used as the initial search keyword (listed in Preferences > Docsets)
  # resources 'resources_dir'  # An optional resources folder which can contain images or anything else
  
  introduction 'My *awesome* cheat sheet'  # Optional, can contain Markdown or HTML

  # A cheat sheet must consist of categories
  category do
    id 'Basics'  # Must be unique and is used as title of the category
    entry do
      name 'Example'
      notes <<-'END'
        ```bash
        #!/usr/bin/env bash
        NAME="John"
        echo "Hello $NAME!"
        ```
      END
    end
    entry do
      name 'Variables'
      notes <<-'END'
      ```bash
      NAME="John"
      echo $NAME
      echo "$NAME"
      echo "${NAME}!"
      ```
      END
    end

    entry do
	  name 'String Quotes'
	  notes <<-'END'
```bash
NAME="John"
echo "Hi $NAME"  #=> Hi John
echo 'Hi $NAME'  #=> Hi $NAME
```
	END
    end

    entry do
	  name 'Conditional exe'
	  notes <<-'END'
```bash
git commit && git push
git commit || echo "Commit failed"
```
	END
    end

    entry do
	  name 'Functions'
	  notes <<-'END'
```bash
get_name() {
  echo "John"
}
echo "You are $(get_name)"
```
	  END
    end

    entry do
	  name 'Shell execution'
	  notes <<-'END'
```bash
echo "I'm in $(pwd)"
echo "I'm in `pwd`"
```
	  END
    end

    entry do
	  name 'Conditionals'
	  notes <<-'END'
```bash
if [[ -z "$string" ]]; then
  echo "String is empty"
elif [[ -n "$string" ]]; then
  echo "String is not empty"
fi
```
	  END
    end

    entry do
	  name 'Brace expansion'
	  notes <<-'END'
```bash
echo {A,B}.js
{A,B} 	Same as A B
{A,B}.js 	Same as A.js B.js
{1..5} 	Same as 1 2 3 4 5
```
	END
    end

    entry do
	name 'Useful modes'
	notes <<-'END'
```bash
set -euo pipefail
IFS=$'\n\t'
set -x
```
	END
    end
  end

category do
	id 'Param Expansion'

    entry do
	  name 'Slicing'
	  notes <<-'END'
```bash
name="John"
echo ${name}
echo ${name/J/j}    #=> "john" (substitution)
echo ${name:0:2}    #=> "Jo" (slicing)
echo ${name::2}     #=> "Jo" (slicing)
echo ${name::-1}    #=> "Joh" (slicing)
echo ${name:(-1)}   #=> "n" (slicing from right)
echo ${name:(-2):1} #=> "h" (slicing from right)
echo ${food:-Cake}  #=> $food or "Cake"
length=2
echo ${name:0:length}  #=> "Jo"
```
    END
    end

    entry do
	  name 'Extension'
	  notes <<-'END'
```bash
STR="/path/to/foo.cpp"
echo ${STR%.cpp}    # /path/to/foo
echo ${STR%.cpp}.o  # /path/to/foo.o

echo ${STR##*.}     # cpp (extension)
echo ${STR##*/}     # foo.cpp (basepath)

echo ${STR#*/}      # path/to/foo.cpp
echo ${STR##*/}     # foo.cpp

echo ${STR/foo/bar} # /path/to/bar.cpp

STR="Hello world"
echo ${STR:6:5}   # "world"
echo ${STR:-5:5}  # "world"

SRC="/path/to/foo.cpp"
BASE=${SRC##*/}   #=> "foo.cpp" (basepath)
DIR=${SRC%$BASE}  #=> "/path/to/" (dirpath)
```
	END
    end

    entry do
	  name 'Substitution'
	  notes <<-'END'
```bash
${FOO%suffix} 	Remove suffix
${FOO#prefix} 	Remove prefix
${FOO%%suffix} 	Remove long suffix
${FOO##prefix} 	Remove long prefix
${FOO/from/to} 	Replace first match
${FOO//from/to} 	Replace all
${FOO/%from/to} 	Replace suffix
${FOO/#from/to} 	Replace prefix
```
	END
    end

    entry do
	  name 'Comments'
	  notes <<-'END'
```bash
# Single line comment
: '
This is a
multi line
comment
'
```
	END
    end

    entry do
	  name 'Length'
	  notes <<-'END'
```bash
${#FOO} 	Length of $FOO
```
	  END
      end

    entry do
	  name 'Default values'
	  notes <<-'END'
```bash
${FOO:-val} 	$FOO, or val if not set
${FOO:=val} 	Set $FOO to val if not set
${FOO:+val} 	val if $FOO is set
${FOO:?message} 	Show error message and exit if $FOO is not set
```
  	END
    end
    entry do
	  name 'Substrings'
	  notes <<-'END'
```bash
${FOO:0:3} 	Substring (position, length)
${FOO:-3:3} 	Substring from the right
```
	END
    end
    entry do
	  name 'Manipulation'
	  notes <<-'END'
```bash
STR="HELLO WORLD!"
echo ${STR,}   #=> "hELLO WORLD!" (lowercase 1st letter)
echo ${STR,,}  #=> "hello world!" (all lowercase)

STR="hello world!"
echo ${STR^}   #=> "Hello world!" (uppercase 1st letter)
echo ${STR^^}  #=> "HELLO WORLD!" (all uppercase)
```
	END
    end
end
category do
	id 'Loop'
    entry do
	  name 'basic'
	  notes <<-'END'
```bash
for i in /etc/rc.*; do
  echo $i
done

# on the commandline 
fir i in ./*; do echo $1; done
```
	  END
    end
    entry do
	  name 'c-loops'
	  notes <<-'END'
```bash
for ((i = 0 ; i < 100 ; i++)); do
  echo $i
done
```
	  END
   end
    entry do
	  name 'ranges'
	  notes <<-'END'
```bash
for i in {1..5}; do
    echo "Welcome $i"
done

With step size

for i in {5..50..5}; do
    echo "Welcome $i"
done
```
	  END
    end
    entry do
	  name 'read lines'
	  notes <<-'END'
```bash
< file.txt | while read line; do
  echo $line
done
```
	  END
    end
end

category do
	id 'Functions'
    entry do
	  name 'Basic'
	  notes <<-'END'
```bash
myfunc() {
    echo "hello $1"
}

# Same as above (alternate syntax)
function myfunc() {
    echo "hello $1"
}

myfunc "John"
```
      END
    end
    entry do
	  name 'Input'
	  notes <<-'END'
```bash
$# 	Number of arguments
$* 	All arguments
$@ 	All arguments, starting from first
$1 	First argument
```
	  END
    end
end

category do
	id 'Data Structures'

    entry do
	  name 'Array'
	  notes <<-'END'
```bash
Fruits=('Apple' 'Banana' 'Orange')

Fruits[0]="Apple"
Fruits[1]="Banana"
Fruits[2]="Orange"
```
      END
    end
    entry do
	  name 'Array functions'
	  notes <<-'END'
```bash
Fruits=("${Fruits[@]}" "Watermelon")    # Push
Fruits+=('Watermelon')                  # Also Push
Fruits=( ${Fruits[@]/Ap*/} )            # Remove by regex match
unset Fruits[2]                         # Remove one item
Fruits=("${Fruits[@]}")                 # Duplicate
Fruits=("${Fruits[@]}" "${Veggies[@]}") # Concatenate
lines=(`cat "logfile"`)                 # Read from file
```
	  END
    end
    entry do
	  name 'Array access'
	  notes <<-'END'
```bash
echo ${Fruits[0]}           # Element #0
echo ${Fruits[@]}           # All elements, space-separated
echo ${#Fruits[@]}          # Number of elements
echo ${#Fruits}             # String length of the 1st element
echo ${#Fruits[3]}          # String length of the Nth element
echo ${Fruits[@]:3:2}       # Range (from position 3, length 2)
```
	  END
    end
    entry do
	  name 'Iterate array'
	  notes <<-'END'
```bash
for i in "${arrayName[@]}"; do
  echo $i
done
```
	  END
    end
    entry do
	  name 'Dictionaries'
	  notes <<-'END'
```bash
declare -A sounds

sounds[dog]="bark"
sounds[cow]="moo"
sounds[bird]="tweet"
sounds[wolf]="howl"
```
	  END
    end
    entry do
	  name 'Dict access'
	  notes <<-'END'
```bash
echo ${sounds[dog]} # Dog's sound
echo ${sounds[@]}   # All values
echo ${!sounds[@]}  # All keys
echo ${#sounds[@]}  # Number of elements
unset sounds[dog]   # Delete dog
```
	  END
    end
    entry do
	  name '<name>'
	  notes <<-'END'
```bash
for val in "${sounds[@]}"; do
  echo $val
done

Iterate over keys

for key in "${!sounds[@]}"; do
  echo $key
done
```
	  END
    end
  end

category do
	id 'Misc'
    entry do
  	  name 'casse'
	  notes <<-'END'
```bash
case "$1" in
start | up)
  vagrant up
  ;;
  *)
  echo "Usage: $0 {start|stop|ssh}"
    ;;
esac
```
      END
    end
    entry do
	  name 'Print'
	  notes <<-'END'
```bash
printf "Hello %s, I'm %s" Sven Olga
#=> "Hello Sven, I'm Olga

printf "1 + 1 = %d" 2
#=> "1 + 1 = 2"

printf "This is how you print a float: %f" 2
#=> "This is how you print a float: 2.000000"
```
	END
 end
end
end
	

	
