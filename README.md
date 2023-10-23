# S10-U3-QZ-01  Gallery Images  in Flutter

Simple image gallery reading device storage

## Quentions
- **What is the advantage of using a Grid component in an image gallery compared to a linear layout, especially when dealing with displaying a large number of images?**
  With a gridview We can see the content of the image better than in a list allowing us to decide quick wich element are we searching for.
- **What are some of the key properties that can be configured in a Grid component to customize the appearance and layout of an image gallery?**
  **gridDelegate**:  allows us to set to the grid the number of columns with **crossAxisCount** , space between elements, with **crossAxisCount** and **mainAxisSpacing**, and theb **padding** to add space to all container
- **How can you implement the functionality to click on an image in the Grid gallery to view it in full size, and how could this interaction be achieved in a Flutter application?**
  Warapping the image component in a button, Gesture detector or any other component that has oin its properties a detector and a callback function with an action. and navigate to a screen component where only will be the image alone.

## App Running

<img width="551" alt="image" src="https://github.com/Noel-S/S10-U3-QZ-01-/assets/30371531/aa2205f8-5201-4888-a975-1ccdf73a3622">

<img width="551" alt="image" src="https://github.com/Noel-S/S10-U3-QZ-01-/assets/30371531/7ebe25ef-350c-485d-bcb4-60783a054f41">

<img width="366" alt="image" src="https://github.com/Noel-S/S10-U3-QZ-01-/assets/30371531/ed7724c8-784b-40c2-8c00-60fa89821610">

