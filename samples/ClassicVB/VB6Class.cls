VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "VB6Class"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
    ''' <summary>
    ''' VB6 class example
    ''' </summary>
    ''' \file VB6Class.cls
    ''' \remarks The original unfiltered source of this file: <A HREF="https://github.com/sevoku/doxygen-vb-filter/blob/master/samples/ClassicVB/VB6Class.cls">VB6Class.cls</A>
    
    Private Enum SampleEnum
        [_First] = 1
        enumItem1 = 1
        enumItem2 = 2
        enumItem3 = 3
        [_Last] = 3
    End Enum
    
    Private Type SampleType1
        typeItem1 As Long
        typeItem2 As Long
    End Type
    
    ''' Sample private type within a class
    Private Type SampleType2
        typeItem1 As Long
        typeItem2 As Long
    End Type
    
    Private Type SampleType3
        typeItem1 As Long
        typeItem2 As Long
    End Type
    
    Private someInteger As Integer ' simple private integer value
    Public someString As String    ' simple public string value
    Private someObject As Object   ' some object
    
    ''' <summary>
    ''' simple property
    ''' </summary>
    ''' <value>some string</value>
    ''' <returns>some string</returns>
    Public Property Let StringProperty(value As String)
        someString = value
    End Property
    Public Property Get StringProperty() As String
        StringProperty = someString
    End Property
    
    ''' <summary>
    ''' readonly property
    ''' </summary>
    ''' <value>integer value</value>
    ''' <returns>some interger value</returns>
    Public Property Get IntegerProperty() As Integer
        IntegerProperty = someInteger
    End Property
    
    ''' <summary>
    ''' reference property
    ''' </summary>
    ''' <value>some object</value>
    ''' <returns>some object</returns>
    Public Property Set ObjectProperty(value As Object)
        Set someObject = value
    End Property
    Public Property Get ObjectProperty() As Object
        ObjectProperty = someObject
    End Property
    
    ''' <summary>
    ''' not working property
    ''' </summary>
    ''' <remarks>
    ''' this property will be seen as ReadOnly by the Doxygen vbfilter
    ''' because Set does not preceed get!
    ''' </remarks>
    Public Property Get TestProperty() As Object
        ObjectProperty = someObject
    End Property
    Public Property Set TestProperty(value As Object)
        Set someObject = value
    End Property
    
    ''' <summary>
    ''' function with parameter
    ''' </summary>
    ''' <param name="pFirst">simple parameter</param>
    ''' <returns>some double value</returns>
    ''' <remarks></remarks>
    Public Function SampleFunction(ByVal pFirst As Double) As Double
        SampleFunction = pFirst
    End Function
    
    ''' <summary>
    ''' function with an array as parameter
    ''' </summary>
    ''' <param name="arg1">simple long parameter</param>
    ''' <param name="arg2">String array</param>
    ''' <returns>some long value</returns>
    ''' <remarks></remarks>
    Public Function SampleFunction2(arg1 As Long, arg2() As String) As Long
        
    End Function
    
    ''' <summary>
    ''' function with an array as result
    ''' </summary>
    ''' <param name="arg1">simple long parameter</param>
    ''' <returns>long array</returns>
    ''' <remarks></remarks>
    Public Function SampleFunction3(arg1 As Long) As Long()
        
    End Function
    
    ''' <summary>
    ''' simple method
    ''' </summary>
    ''' <remarks></remarks>
    Sub SampleMethod()
        
    End Sub
    
    ''' <summary>
    ''' method with parameters
    ''' </summary>
    ''' <param name="pFirst">simple param</param>
    ''' <param name="pPointer">pointer</param>
    ''' <remarks></remarks>
    Public Sub SampleMethodWithParams(ByVal pFirst As String, ByRef pPointer As Integer)
        Dim d As Long
        d = 2
        If d = 2 Then Exit Sub Else d = 3
    End Sub
    
    ''' <summary>
    ''' simple constructor
    ''' </summary>
    ''' <remarks></remarks>
    Private Sub Class_Initialize()
        Dim s As String
        s = "This is a Function as example"
    End Sub
    
    ''' <summary>
    ''' some event
    ''' </summary>
    ''' <param name="Sender">sender of object type</param>
    ''' <remarks></remarks>
    Public Event OnSomeEvent(ByVal Sender As Object)
    
    ''' <summary>
    ''' destruction event
    ''' </summary>
    Event Destroy()
    
    ''' <summary>
    ''' simple destructor
    ''' </summary>
    ''' <remarks>Raises Destroy event</remarks>
    Private Sub Class_Terminate()
        RaiseEvent Destroy
    End Sub
