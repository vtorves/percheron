shared_examples 'an Actions::Start' do
  it 'starts the unit' do
    expect(container).to receive(:start!)
    subject.execute!
  end

  it 'executes post start scripts' do
    expect(exec_action).to receive(:execute!)
    subject.execute!
  end
end
