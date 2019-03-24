Extension { #name : #Date }

{ #category : #'*Presenty-Presenters' }
Date >> isFilled [
	^true
]

{ #category : #'*Presenty-Core' }
Date class >> monthNames [
	^MonthNames
]

{ #category : #'*Presenty-Presenters' }
Date >> ptyPrintMonthAndYearBy: aTranslator [ 
	
	| monthName |
	monthName := aTranslator translate: (Date nameOfMonth: self monthIndex).	
	
	^monthName, ' ', self year asString.
]

{ #category : #'*Presenty-Presenters' }
Date >> ptyPrintValueStringBy: aTranslator [ 

	^self dayOfMonth asString, ' ', (self ptyPrintMonthAndYearBy: aTranslator) 
]

{ #category : #'*Presenty-Core' }
Date >> withDay: aNumber [
	^Date year: self year month: self monthIndex day: aNumber 
]

{ #category : #'*Presenty-Core' }
Date >> withMonth: aNumber [
	^Date year: self year month: aNumber day: self dayOfMonth
]

{ #category : #'*Presenty-Core' }
Date >> withYear: aNumber [
	^Date year: aNumber month: self monthIndex day: self dayOfMonth
]
