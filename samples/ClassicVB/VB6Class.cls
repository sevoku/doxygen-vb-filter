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
    ''' VB6 class example'
    ''' </summary>
	''' \file VB6Class.cls
	''' \remarks The original unfiltered source of this file: <A HREF="http://trac.sevo.org/projects/doxyvb/browser/trunk/samples/ClassicVB/VB6Class.cls">VB6Class.cls</A>
    
    Private someInteger As Integer ' simple private integer value
    Public someString As String    ' simple public string value

    ''' <summary>
    ''' simple property
    ''' </summary>
    ''' <value>some string</value>
    ''' <returns>some string</returns>
    Public Property Get StringProperty() As String
            StringProperty = someString
    End Property
    Public Property Set StringProperty(ByVal value As String)
            someString = value
    End Property

    ''' <summary>
    ''' readonly property
    ''' </summary>
    ''' <value>integer value</value>
    ''' <returns>same interger value</returns>
    Public Property Get IntegerProperty() As String
            IntegerProperty = someString
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
    ''' simple method
    ''' </summary>
    ''' <remarks></remarks>
    Sub SampleMethod()
    
    End Sub

    ''' <summary>
    ''' method with parameters
    ''' </summary>
    ''' <param name="pFirst">simple param</param>
    ''' <param name="pPointer">pinter</param>
    ''' <remarks></remarks>
    Public Sub SampleMethodWithParams(ByVal pFirst As String, ByRef pPointer As Integer)

    End Sub
    
    ''' <summary>
    ''' simple constructor
    ''' </summary>
    ''' <param name="pSomeString">simple param</param>
    ''' <remarks></remarks>
    Private Sub Class_Initialize(ByVal pSomeString As String)
     someString = pSomeString
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

