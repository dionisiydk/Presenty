Class {
	#name : #PtySecreteEditDecoratorTests,
	#superclass : #PtyEditDecoratorTestCase,
	#category : #'PresentyTests-UI'
}

{ #category : #running }
PtySecreteEditDecoratorTests >> decoratorClass [
	^PtySecreteEditDecorator 
]

{ #category : #tests }
PtySecreteEditDecoratorTests >> testDecoratingValueWhenSpecialMaskExists [

	decorator secreteChar: $*.
	decorator secreteMask: 'x**xx'.
	decorator decoratedValue: '12345'.
	
	decorator decoratedValue should equal: '1**45'
	
]

{ #category : #tests }
PtySecreteEditDecoratorTests >> testDecoratingValueWhenSpecialMaskToBig [

	decorator secreteChar: $*.
	decorator secreteMask: 'x**xx****'.
	decorator decoratedValue: '12345'.
	
	decorator decoratedValue should equal: '1**45'
	
]

{ #category : #tests }
PtySecreteEditDecoratorTests >> testDecoratingValueWhenSpecialMaskToBig2 [

	decorator secreteChar: $*.
	decorator secreteMask: 'x**xx*xxxx*'.
	decorator decoratedValue: '12345'.
	
	decorator decoratedValue should equal: '1**45'
	
]

{ #category : #tests }
PtySecreteEditDecoratorTests >> testDecoratingValueWhenSpecialMaskToLittle [

	decorator secreteChar: $*.
	decorator secreteMask: 'x**'.
	decorator decoratedValue: '12345'.
	
	decorator decoratedValue should equal: '1****'
	
]

{ #category : #tests }
PtySecreteEditDecoratorTests >> testDecoratingValueWithoutSpecialMask [

	decorator secreteChar: $*.
	decorator decoratedValue: '12345'.
	
	decorator decoratedValue should equal: '*****'
	
]
