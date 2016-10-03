# Elm + Routing + SASS Boilerplate

This is a folder structure to create an Elm app with routing working out of the box, as well as `.sass` and `.elm` files compilation **on save**, using a Bash script. It features a nice coloured output on your terminal to indicate whether your files were compiled or not.

## Requirements
- Mac OS X, Linux or any app capable of running a bash script (`*.sh` files)
- Python 2.x (used only to run a _one-line server"_)
- [NPM](https://docs.npmjs.com/getting-started/installing-node)
- Elm, of course. (Install instructions found here: https://guide.elm-lang.org/get_started.html)
- `node-sass`: Install it with npm using  `npm i -g node-sass`

## Folder structure
Most important folders are briefly described:
```
/
|-- index.html  <--- HTML file which will invoke all the necessary compiled and external files
|-- compile.sh  <--- Compiling script
|-- assets/  <--- Where assets such as images, etc. should be placed
|-- src/  <--- Where all of the .elm files should be placed
    |-- Main.elm  <--- Main Elm app file
    |-- Routing/
        |-- Routes.elm  <--- File where routes should be specified as a type
        |-- Middleware.elm  <-- File in charge of URL parsing
    |-- Store/
        |-- Messages.elm  <--- All of the app messages specified within a type that groups multiple types of messages
        |-- State.elm  <--- Describes the initial Model structure (as a record) and initializes it
        |-- Updates.elm  <--- Groups all of the modules/functions in charge of a specific set of updates.
                              Normally there should be a 1-to-1 relationship between Store/Updates/ modules and
                              types of Messages. i.e.: Store/Updates/Routing.elm and RoutingMsg type (on Store/Messages.elm)
        |-- Updaters/  <--- All modules in charge of the different types of Messages in the app
    |-- Util/  <--- A folder for handy functions from modules such as Html, Cmd, Array, Either, Tuple, Http, etc.
    |-- Views/  <--- Folder where all views of your app should be placed
        |-- Home.elm  <--- View matching the "/" route
|-- styles/  <--- Where all of the .sass files should be placed
    |-- main.sass  <--- File in which all SASS files' imports should be made
```

## Usage
After installing all of the aforementioned requirements, follow these steps:
1. Give execution permissions to `compile.sh` located on root. Simply do `chmod +x compile.sh` (use `sudo` only if necessary and with caution).
2. Execute the script: `./compile.sh` This will compile all the necessary files and run a web server on **http://localhost:1234**
3. Code!

Alternatively you can compile a _"base"_ file other than src/Main.elm, just specify it like: `./compile.sh OtherModule.elm`, it'll be placed under `js/dist/OtherModule.js`

## Deployment

As of now, for *deployment* purposes, a small npm script is used to copy all the necesary files to a `dist/` folder and upload it to www.surge.sh (which I highly recommend for quick front-end deployment). The script does the following

```bash
cp -f index.html dist/index.html && cp -f -r assets dist/assets && cp -f -r css dist/css && cp -f -r js/ dist/js && surge -p dist/
```
If you want to add your own custom `xxxxxx.surge.sh` subdomain, just add a `-d xxxxxx.surge.sh` flag to the end of the npm script.

