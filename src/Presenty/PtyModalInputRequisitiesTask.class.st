Class {
	#name : #PtyModalInputRequisitiesTask,
	#superclass : #PtyItemsListTask,
	#category : #'Presenty-Editor-Tasks'
}

{ #category : #accessing }
PtyModalInputRequisitiesTask class >> defaultItemsName [

	^'DataField'
]

{ #category : #execution }
PtyModalInputRequisitiesTask >> body [
	items do: [ :dataField | guide requestUserFor: (PtyInputRequisiteTask on: dataField) ]
]