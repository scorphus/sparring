require 'rspec'
require_relative '../calculator'

describe Calculator do
  before { @calc = Calculator.new('Simple Calculator') }

  it 'should add two numbers correctly' do
    expect(@calc.add(3, 3)).to eq 6
  end

  it 'should multiply two numbers correctly' do
    expect(@calc.multiply(3, 3)).to eq 9
  end

  it 'should subtract two numbers correctly' do
    expect(@calc.subtract(3, 3)).to eq 0
  end

  it 'should divide two numbers correctly' do
    expect(@calc.divide(3, 3)).to eq 1
  end

  it 'should fail when dividing a number by zero' do
    expect{@calc.divide(3, 0)}.to raise_error(ZeroDivisionError)
  end

end
