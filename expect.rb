require 'tryit'

class Expect
  def initialize(value)
    @value = value
  end

  def to(comparison)
    comparison.compare(@value) ? "Test passes! :)" : "Test fails! D:"
  end
end

class Allow
  def initialize(object)
    @object = object
  end

  def to(method)
    method.compare(@object)
  end
end

class Equal
  def initialize(value)
    @value = value
  end

  def compare(var)
    @value == var
  end
end

class Includes
  def initialize(value)
    @value = value
  end

  def compare(value)
    value.include?(@value)
  end
end

class RespondTo
  def initialize(method)
    @method = method
  end

  def compare(object)
      met = @method.to_s
      object.tryit(@method.to_s)
  end
end

class BeA
  def initialize(name)
    @name = name
  end

  def compare(object)
    object.is_a?(@name)
  end
end

class Receive
  def initialize(method)
    @method = method
  end

  def compare(obj)
    obj.define_singleton_method(@method) { obj }
  end
end

def expect(value)
  Expect.new(value)
end

def eq(value)
  Equal.new(value)
end

def includes(value)
  Includes.new(value)
end

def respond_to(method)
  RespondTo.new(method)
end

def be_a(name)
  BeA.new(name)
end

def receive(method)
  Receive.new(method)
end

def allow(object)
  Allow.new(object)
end

class Obj
end

a = Obj.new

p expect(true).to eq false

p expect([1, 2, 3]).to includes 2

p expect(Obj.new).to respond_to :meth

p expect(Obj.new).to be_a Obj

allow(a).to receive(:meth)

p expect(a).to respond_to :meth
p expect(a).to respond_to :meths
