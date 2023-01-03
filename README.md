# nvim-testing

## Description

This repo contains two instances of vim for comparing handling of multiple dotnet test projects.

nvim.sh will download and run the latest main of neotest and neotest-dotnet

nvim-dev.sh will download my forks of neotest and neotest-dotnet with some small changes.

## Build instructions

1. Ensure you have docker set up and running on your machine.
2. Clone this repo
3. cd into the root of the repo and run the build.sh script located there.

## Initial configuration

The built docker images will contain instances of vim that have not yet completed their initial setup. From the root of the repo, run each of nvim.sh and nvim-dev.sh and allow packer and mason to complete download and installation of packages.
I have noticed that some downloads will fail the first time so may need to be retried in packer. If packer succeeds but mason fails then restarting nvim should fix it. Once everything is set up, close both instances of vim.

## Comparison

I would like to be able to open a c# repo with multiple test projects, view all of those tests in the neotest summary and run some or all of them easily

### neotest / neotest-dotnet main branch

Opening the sample repo (running ./nvim.sh) and opening the test summary shows only "Parsing tests"
<img width="367" alt="image" src="https://user-images.githubusercontent.com/4611157/210377487-ce93071f-e071-4740-9665-88c7f8909fdd.png">

Run 
```
!dotnet build
``` 

To get any tests to show up I can open nvim tree (<leader>e) and browse to a file containing a test. This will show all tests from that project in the summary
<img width="759" alt="image" src="https://user-images.githubusercontent.com/4611157/210377756-eec574b4-9221-4935-85ed-aec97721a24b.png">

I can run all tests from that project by running the test suite (<leader>ta) and the results show as expected 
<img width="340" alt="image" src="https://user-images.githubusercontent.com/4611157/210378607-4b277783-5fd8-4f35-8c98-292bfa722794.png">

To view tests from another test project I must navigate to each test project in turn -
<img width="788" alt="image" src="https://user-images.githubusercontent.com/4611157/210378792-b6ae8f06-fe05-48ac-a85c-83142dddd316.png">

There is no way I can see to run all currently open tests. Running the suite seems to just run the latest opened test project.

### neotest / neotest-dotnet dev branch

Opening the sample repo (running ./nvim-dev.sh) and opening the test summary shows all tests subfolders of the current project.
<img width="204" alt="image" src="https://user-images.githubusercontent.com/4611157/210380164-2bde6c2c-adfd-4b7a-92e4-8adb0b078494.png">

Run 
```
!dotnet build
```

I can run all tests from all projects by running the suite (<leader>ta) and the results show as expected
<img width="387" alt="image" src="https://user-images.githubusercontent.com/4611157/210382662-ab609dc3-2afd-44b7-959a-749888ac31cb.png">

Running at each level in the summary view works as expected

### Notes

Changes were required in the neotest repo to support both partial updates to the summary tree and tagging nodes in the tree as classes rather than namespaces.
The dev version can also handle nested test classes (issues 26 and 27).
