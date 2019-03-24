Class {
	#name : #PtyInheritedActivationStrategy,
	#superclass : #PtyTaskActivationStrategy,
	#category : #'Presenty-Core'
}

{ #category : #accessing }
PtyInheritedActivationStrategy >> areaActivator [

	^parent areaActivator 
]

{ #category : #execution }
PtyInheritedActivationStrategy >> setUpNewViewArea [

	guide viewArea: parentViewArea 
]
