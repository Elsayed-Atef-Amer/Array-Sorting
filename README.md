**Our Names Are:**

  1. Abdelrahman Mostafa.
  2. Amir Nabil.
  3. Aya Ashraf.
  4. El-sayed Atef.
  5. Shereen Gamal.

**Introduction:**

  Sorting algorithms are ways to reorganize a large number of items in a specific order like high to low, vice versa, or even in some alphabetical order.
  These algorithms take an input list, process it (i.e. perform some operations on it) and produce the sorted list.
  Types of Sorting Algorithms:
      
      1-Quick Sort
      2-Bubble Sort
      3-Merge Sort
      4-Insertion Sort
      5-Selection Sort
      6-Heap Sort
      7-Radix Sort
      8-Bucket Sort
  The complexity of sorting algorithm calculates the running time of a function in which 'n' number of items are to be sorted. The choice for which sorting method is suitable
  for a problem depends on several dependency configurations for different problems. The most noteworthy of these considerations are:
  
      1-The length of time spent by the programmer in programming a specific sorting program
      2-Amount of machine time necessary for running the program
      3-The amount of memory necessary for running the program
      
   so, to get the amount of time required to sort an array of 'n' elements by a particular method, the normal approach is to analyze the method to find the number of comparisons
   (or exchanges) required by it. Most of the sorting techniques are data sensitive, and so the metrics for them depends on the order in which they appear in an input array.
      
   Various sorting techniques are analyzed in various cases and named these cases as follows:

      Best case
      Worst case
      Average case
  Hence, the result of these cases is often a formula giving the average time required for a particular sort of size 'n.' Most of the sort methods have time requirements that
  range from O(nlog n) to O(n2).
  
**Project:**
  Our project is array sorting using two techniques (Bubble sort , Quick sort).
    with UI which PROMPT the user  
    
      1- first to enter the size of array.
      
      2- next ask to enter the array element by element.
      
      3- then ask to make choice between two techniques.
      
    
**Content of data segment:**
  1. Array with length of 100.
  2. Two variables one for array size and the other for making choice.
    
**Steps of  coding :**
  1. Taking the first input 'ARRAY_size' from the user.
  2. Making a function to convert the input from ASKI to its decimal value, that is called 'INDECIMAL', we will call this function for every input we would take from user.
  3. Taking the second input 'ARRAY' element by element from the user using 'READ_ARRAY' function in our code.
  4. Condition code.
  6. Bubble sort code.
  7. Quick sort code.
  
**Bubble Sort Algorithm**


  -It is a simple algorithm which is used to sort a given set of n elements provided in form of an array with n number of elements. Bubble Sort compares all the element one by   one and sort them based on their values.
  
  -If the given array has to be sorted in ascending order, then bubble sort will start by comparing the first element of the array with the second element, if the first element
   is greater than the second element, it will swap both the elements, and then move on to compare the second and the third element, and so on.
   
   -If we have total n elements, then we need to repeat this process for n-1 times.
   
   -It is known as bubble sort, because with every complete iteration the largest element in the given array, bubbles up towards the last place or the highest index, just like a water bubble rises up to the water surface.
   
  -Sorting takes place by stepping through all the elements one-by-one and comparing it with the adjacent element and swapping them if required.
  
  -An example shown in figure below
  
  ![](Images/Bubble-sort-example.gif)

**QuickSort Algorithm**


Like Merge Sort, QuickSort is a Divide and Conquer algorithm. It picks an element as pivot and partitions the given array around the picked pivot. There are many different versions of quickSort that pick pivot in different ways.   

1-  Always pick first element as pivot.

2-Always pick last element as pivot (implemented below)

3-Pick a random element as pivot.

4-Pick median as pivot
 
The key process in quickSort is partition(). Target of partitions is, given an array and an element x of array as pivot, put x at its correct position in sorted array and put all smaller elements (smaller than x) before x, and put all greater elements (greater than x) after x. All this should be done in linear time
 
 -An example shown in figure below
 
 
![Quicksort-example](https://user-images.githubusercontent.com/76921794/104107197-5d97a980-526f-11eb-93d6-a98e8372d04b.gif)


  
**C++ code :**

     
     
        //Swap function
    void swap(int *xp, int *yp) 
    { 
    int temp = *xp; 
    *xp = *yp; 
    *yp = temp; 
    }
    
       // BUBBLE_SORT Function code 
       
    void BUBBLE_SORT(int arr[], int n)  
    {  
    for (int i = 0; i < n-1; i++)      
    
    for (int j = 0; j < n-i-1; j++)                                 // "j < n-i-1" Because Last i elements are already in place  
        if (arr[j] > arr[j+1])  
            swap(&arr[j], &arr[j+1]);  
    }  
  
      // QUICK_SORT Function code
      
    /* This function takes last element as pivot, places 
    the pivot element at its correct position in sorted 
    array, and places all smaller (smaller than pivot) 
    to left of pivot and all greater elements to right 
    of pivot */
    
    int partition (int arr[], int low, int high) 
    { 
    int pivot = arr[high];    // pivot 
    int i = (low - 1);                                                // Index of smaller element 
  
    for (int j = low; j <= high- 1; j++) 
    { 

        if (arr[j] <= pivot)                                          // If current element is smaller than or equal to pivot 
        { 
            i++;                                                      // increment index of smaller element 
            swap(&arr[i], &arr[j]); 
        } 
    } 
    swap(&arr[i + 1], &arr[high]); 
    return (i + 1); 
    } 
  
    /* The main function that implements QuickSort 
    arr[] --> Array to be sorted, 
    low  --> Starting index, 
    high  --> Ending index */
    
    void QUICK_SORT(int arr[], int low, int high) 
    { 
    if (low < high) 
    { 
        int pi = partition(arr, low, high);                          //pi is partitioning index, arr[p] is now at right place 
       QUICK_SORT(arr, low, pi - 1);                                 // Separately sort elements before partition...
       QUICK_SORT(arr, pi + 1, high);                                //and after partition 
    } 

    
    main(){
  
      //define variables and take inputs from user code 
      int length,choice;
      int starting_index =0;
      cout<<"please enter the length of array";
      cin >>length;
      int array[length];
      cout <<"please enter elements of array";
      for(int i=0;i<length;i++)
      {
      cin >> array[i];
      }
      cout <<"please enter 1 for Bubble sort OR 2 for Quick sort";
      cin >> choice;
      //condition code
      if(choice == 1){
      BUBBLE_SORT(array,length);
      }
      else if (choice == 2){ 
      QUICK_SORT(array,starting_index,length-1);
      }
      else{
          cout <<"Error invaild input";
      }
  
  
  
      }
  
  
  

