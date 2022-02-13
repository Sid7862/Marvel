 # A Simple app to demostrate the characters in Marvel Universe

The purpose of this project is to develop a non-trivial app using MVVM.

The app uses the Marvel API to display list of characters in the Marvel Universe and a detail screen to view their details

# Technical details

### Architecture

The app is developed using the MVVM architectural pattern which indeed means Model View ViewModel.

**Bond** is use to achieve binding between View and View-Model

### Folder Structure

#### Common
It contain common models and classes
#### Module 
- Each folder inside the module represent a screen
- Each module has a View and ViewModel and a Model if necessaray
- View handle the presentaion layer
- ViewModel handle the data and domain layer
#### Extention
-  Contains some extention over the Foundation Framwork
#### NetworkLayer 
- Contains classes for Network releated task

# Download and run

Clone: First, clone the repository with the 'clone' command.

$ git clone git@github.com/Sid7862/Marvel.git.

### Marvel API keys

Get your Marvel keys from developer.marvel.com

Replace with your public and private key inside API+Enum.Swift file



