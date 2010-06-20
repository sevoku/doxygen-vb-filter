VERSION 5.00
Begin VB.Form VB6Form 
   Caption         =   "Form1"
   ClientHeight    =   1965
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   4125
   LinkTopic       =   "Form1"
   ScaleHeight     =   1965
   ScaleWidth      =   4125
   StartUpPosition =   3  'Windows-Standard
   Begin VB.TextBox Text1 
      Height          =   375
      Left            =   1800
      TabIndex        =   1
      Text            =   "Text1"
      Top             =   240
      Width           =   1455
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   735
      Left            =   1200
      TabIndex        =   0
      Top             =   840
      Width           =   1455
   End
   Begin VB.Label Label1 
      Caption         =   "Label1"
      Height          =   375
      Left            =   360
      TabIndex        =   2
      Top             =   240
      Width           =   975
   End
End
Attribute VB_Name = "VB6Form"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' \brief VB6 Form Example
' \file VB6Form.frm
' \remarks The original unfiltered source of this file: <A HREF="http://trac.sevo.org/projects/doxyvb/browser/trunk/samples/ClassicVB/VB6Form.frm">VB6Form.frm</A>

' \brief Button Click handler
Private Sub Command1_Click()

End Sub

' \brief Form OnLoad handler
' \remarks Is called when the form is loading
Private Sub Form_Load()

End Sub

' \brief Text Change handler
' \remarks Is called when the text of Text1 is changed
Private Sub Text1_Change()

End Sub
