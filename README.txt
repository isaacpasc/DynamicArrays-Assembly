This is the C program translated to mips:

//The readArray procedure reads integers from user input and store them in the array
void readArray(int array[], int arraysize)
{
    int num, i;
    
    printf("Enter 11 integers.\n");

    i = 0;
    while (i < arraysize)
    {
        printf("Enter an integer: \n");

        //read an integer from a user input and store it in num1
        scanf("%d", &num);
        array[i] = num;

        i++;
    }

    return;
}

//The printArray function prints integers of the array
void printArray(int array[], int arraysize)
{
    int i;

    i = 0;
    while (i < arraysize)
    {
        printf("%d\n", array[i]);
        i++;
    }
    
    return;
}


//The findTheNthSmallest calls the readArray and printArray functions.
//Then it should look for the "index"-th smallest integer inthe array, 
//print the result array, and return the "index"-th smallest integer
int findTheNthSmallest(int numbers[], int arraysize, int index)
 {
     int i, j, smallIndex, temp;

     readArray(numbers, arraysize);
     printf("\nOriginal Array Content:\n");
     printArray(numbers, arraysize);

     //It goes through each element of array
     //and find the smallest, second smallest and so on.
     i = 0;
     for (i = 0; i < index; i++)
      {
          j = 0;
          smallIndex = i;
          for (j = i+1; j < arraysize; j++)
          {
            if (numbers[smallIndex] > numbers[j])
            {
                smallIndex = j;
            }
          }
          //swap two elements
          temp = numbers[i];
          numbers[i] = numbers[smallIndex];
          numbers[smallIndex] = temp;
      }

     printf("\nResult Array Content:\n");
     printArray(numbers, arraysize);

     return numbers[index-1];
 }


//The main asks a user how many time to repeat
//the operation, then call the fundTheNthSmallest for that
//many times

// The main calls the exchangeElements
void main()
{
    int arraysize = 11;
    int numbers[arraysize];
    int howMany, theNthSmallest, index, i;
    
    printf("Specify how many times to repeat:\n");
    scanf("%d", &howMany);

    printf("Enter an integer for the Nth smallest:\n");
     
     //read an integer from a user input
     scanf("%d", &index);

     //if the index is not within the range, 
     //and if it is smaller, set it to 1, if it is larger,  
     //set it to the size of the array.
     if (index < 1)
     {
        index = 1;   
     }
     else if (index > arraysize)
     {
        index = arraysize;       
     }

    i=0;
    while (i < howMany)
    {
        theNthSmallest = findTheNthSmallest(numbers, arraysize, index);  
        printf("The %d(-th) smallest number is %d\n\n", index, theNthSmallest);         
        i++;
    }
  }
 

Sample Output:

Specify how many times to repeat:
2
Enter an integer for the Nth smallest:
3
Enter 11 integers.
Enter an integer:
-12
Enter an integer:
53
Enter an integer:
-4
Enter an integer:
5
Enter an integer:
32
Enter an integer:
1
Enter an integer:
7
Enter an integer:
-5
Enter an integer:
3
Enter an integer:
4
Enter an integer:
7

Original Array Content:
-12
53
-4
5
32
1
7
-5
3
4
7

Result Array Content:
-12
-5
-4
5
32
1
7
53
3
4
7
The 3(-th) smallest number is -4

Enter 11 integers.
Enter an integer:
2
Enter an integer:
0
Enter an integer:
-4
Enter an integer:
6
Enter an integer:
7
Enter an integer:
6
Enter an integer:
4
Enter an integer:
2
Enter an integer:
8
Enter an integer:
-10
Enter an integer:
45

Original Array Content:
2
0
-4
6
7
6
4
2
8
-10
45

Result Array Content:
-10
-4
0
6
7
6
4
2
8
2
45
The 3(-th) smallest number is 0

----------------

Here is another sample output:

---------------

Specify how many times to repeat:
1
Enter an integer for the Nth smallest:
-5
Enter 11 integers.
Enter an integer:
-15
Enter an integer:
24
Enter an integer:
32
Enter an integer:
50
Enter an integer:
25
Enter an integer:
0
Enter an integer:
2
Enter an integer:
33
Enter an integer:
-21
Enter an integer:
15
Enter an integer:
-17

Original Array Content:
-15
24
32
50
25
0
2
33
-21
15
-17

Result Array Content:
-21
24
32
50
25
0
2
33
-15
15
-17
The 1(-th) smallest number is -21