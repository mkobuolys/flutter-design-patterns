import 'package:flutter/widgets.dart';

import 'design_patterns.dart';

class DesignPatternsFactoryException implements Exception {
  final String message;

  const DesignPatternsFactoryException(this.message);
}

class DesignPatternsFactory {
  const DesignPatternsFactory._();

  static Widget create(String id) => switch (id) {
        'abstract-factory' => const AbstractFactoryExample(),
        'adapter' => const AdapterExample(),
        'bridge' => const BridgeExample(),
        'builder' => const BuilderExample(),
        'chain-of-responsibility' => const ChainOfResponsibilityExample(),
        'command' => const CommandExample(),
        'composite' => const CompositeExample(),
        'decorator' => const DecoratorExample(),
        'facade' => const FacadeExample(),
        'factory-method' => const FactoryMethodExample(),
        'flyweight' => const FlyweightExample(),
        'interpreter' => const InterpreterExample(),
        'iterator' => const IteratorExample(),
        'mediator' => const MediatorExample(),
        'memento' => const MementoExample(),
        'observer' => const ObserverExample(),
        'prototype' => const PrototypeExample(),
        'proxy' => const ProxyExample(),
        'singleton' => const SingletonExample(),
        'state' => const StateExample(),
        'strategy' => const StrategyExample(),
        'template-method' => const TemplateMethodExample(),
        'visitor' => const VisitorExample(),
        _ => throw DesignPatternsFactoryException(
            "Design pattern example with id '$id' could not be created.",
          ),
      };
}
