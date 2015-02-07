require 'spec_helper'
require 'rollout'
require 'rollout_postgres_store'

ROLLOUT = Rollout.new(RolloutPostgresStore.new(FeatureFlag, 'data'))

describe RolloutPostgresStore, '.new' do
  it 'assigns the model instance variable' do
    store = RolloutPostgresStore.new(FeatureFlag, 'data')
    expect(store.instance_variable_get(:@model)).to be FeatureFlag
  end

  it 'assigns the attribute instance variable' do
    store = RolloutPostgresStore.new(FeatureFlag, 'data')
    expect(store.instance_variable_get(:@attribute)).to eql 'data'
  end
end

describe RolloutPostgresStore, '#get' do
  it 'returns nil for not having found a FeatureFlag with the given key' do
    store = RolloutPostgresStore.new(FeatureFlag, 'data')
    expect(store.get('test_key')).to be nil
  end

  it 'returns the value for a given key when a FeatureFlag is found' do
    ROLLOUT.activate_percentage(:search, 20)

    store = RolloutPostgresStore.new(FeatureFlag, 'data')
    expect(store.get('feature:search')).to eql '20||'
  end
end

describe RolloutPostgresStore, '#set' do
  it 'receives the create_feature_flag message for not having found a flag' do
    expect_any_instance_of(RolloutPostgresStore).to receive(:create_feature_flag).at_most(:once)

    RolloutPostgresStore.new(FeatureFlag, 'data').set('search', '20||')
  end

  it 'receives the update_flag message for having found a flag' do
    ROLLOUT.activate_percentage(:search, 20)

    expect_any_instance_of(RolloutPostgresStore).to receive(:update_flag).at_most(:once)

    RolloutPostgresStore.new(FeatureFlag, 'data').set('feature:search', '20||123')
  end
end

describe RolloutPostgresStore, '#del' do
  it 'returns the object deleted for finding the key to delete' do
    ROLLOUT.activate_percentage(:search, 30)

    # There is only one feature flag per the activation above
    feature_flag = FeatureFlag.first
    store = RolloutPostgresStore.new(FeatureFlag, 'data')
    expect(store.del('feature:search')).to eq feature_flag
  end

  it 'returns nil for not being able to find the key to delete' do
    expect(RolloutPostgresStore.new(FeatureFlag, 'data').del('feature:test')).to be nil
  end
end
