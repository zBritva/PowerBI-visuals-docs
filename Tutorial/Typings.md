# Installing Typings for d3
Installing typings will give you access to d3 types so you can utilize typescript types.
See [commit](https://github.com/Microsoft/PowerBI-visuals-sampleBarChart/commit/2bb0f64718864a27e7d4b9c5b1d35d267bba6202) for what was added at this step.

For a more indepth details about typings, visit their repo. [Typings Documentation](https://github.com/typings/typings)

## Install Typings CLI
In order to use typings in your project, you must first install typings to your computer. This is a one time installation.
```
// install typings globally
npm install typings -g
```
## Add Typings to your Project
To have types for a specific library, run the following command.

* **save** - Persists the types within this project.
* **global** - Tells typings that we want this dependency to be globally available.

```
// install d3 typings 
typings install --save --global dt~d3
```

You should now have a typings directory in your visual project.

![](images/InstallTypings.png)

## Adding Typings to your PowerBI Visual
Open your `tsconfig.json` file and add your `index.d.ts` to your list of files

![](images/AddTypings.png)

## Adding Typings for d3 by npm (Recommended)

Another way to include typings is to use npm
Open your `package.json` file and add `"@types/d3": "3.5.36"` in `devDependencies` section.

You must execute `npm install` again to install defined typings for project. Typings will be installed into `node_modules/@types/d3` folder.

In this case you don't need to install `typings` package to manage your typings. And you can remove `typings` package from dependencies, `typings.json` file and `typings` folder from the root of the project.

If typings of some package isn't located in npm repository you can continue to use `typings` package for manage typings for the project.

[There is commit with changes in sampleBarChart visual](https://github.com/Microsoft/PowerBI-visuals-sampleBarChart/commit/e955f676dadcc06c2cbad90c61e70a09fc05da03)

## Utilize Types in your Visual
Now you should be able to use types within your code.

![](images/UsingTypings.png)