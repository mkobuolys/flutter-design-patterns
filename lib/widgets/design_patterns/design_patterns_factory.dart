import 'package:flutter/widgets.dart';

import 'design_patterns.dart';

class DesignPatternsFactoryException implements Exception {
  final String message;

  const DesignPatternsFactoryException(this.message);
}

class DesignPatternsFactory {
  const DesignPatternsFactory._();

  static Widget create(String id) {
    switch (id) {
      case 'abstract-factory':
        return const AbstractFactoryExample();
      case 'adapter':
        return const AdapterExample();
      case 'bridge':
        return const BridgeExample();
      case 'builder':
        return const BuilderExample();
      case 'chain-of-responsibility':
        return const ChainOfResponsibilityExample();
      case 'command':
        return const CommandExample();
      case 'composite':
        return const CompositeExample();
      case 'decorator':
        return const DecoratorExample();
      case 'facade':
        return const FacadeExample();
      case 'factory-method':
        return const FactoryMethodExample();
      case 'flyweight':
        return const FlyweightExample();
      case 'interpreter':
        return const InterpreterExample();
      case 'iterator':
        return const IteratorExample();
      case 'mediator':
        return const MediatorExample();
      case 'memento':
        return const MementoExample();
      case 'observer':
        return const ObserverExample();
      case 'prototype':
        return const PrototypeExample();
      case 'proxy':
        return const ProxyExample();
      case 'singleton':
        return const SingletonExample();
      case 'state':
        return const StateExample();
      case 'strategy':
        return const StrategyExample();
      case 'template-method':
        return const TemplateMethodExample();
      case 'visitor':
        return const VisitorExample();
      default:
        throw DesignPatternsFactoryException(
          "Design pattern example with id '$id' could not be created.",
        );
    }
  }
}
