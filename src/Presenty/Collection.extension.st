Extension { #name : #Collection }

{ #category : #'*Presenty-Core' }
Collection >> divideForPagesWithSize: itemsPerPage [

	| pages currentPage |
	pages := OrderedCollection new.
	
	currentPage := PtyItemsPage number: 1.
	pages add: currentPage.
	
	self withIndexDo: [:each :i | 
		
		currentPage itemsCount = itemsPerPage 
			ifTrue: [	currentPage := PtyItemsPage number: pages size + 1.
					pages add: currentPage].
				
		currentPage add: each].
	
	^pages	



]
