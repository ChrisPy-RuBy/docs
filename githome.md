#### **settign up new git repo**

```bash
mkdir <your new thing>
cd <your new thing>
git init
touch firstfile.py
git add .
git commit -m "tahdah"

# set up remote repo i.e. github / gitlab etc
git remote add origin <whereever you hosts>:<username>/<repo>
git push -u origin master
```
