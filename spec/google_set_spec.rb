require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "GoogleSet" do
  it "should return related terms for the specified term" do
    GoogleSet.for("apple", "orange").should include("banana")
  end

  it "should return nothing if no elements are specified" do
    GoogleSet.for().should be_empty
  end
end
