require 'rails_helper'

RSpec.describe Post, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe "validation" do
    it "requires a title" do
      p = Post.new ({body: "test"})
      p.title = 'test_title'
      validation_outcome = p.valid?
      expect(validation_outcome).to eq(true)
    end

    it "The post title require a minimum length of 7 characters" do
      p = Post.new ({body: "test"})
      p.title = "testing"
      expect(p.title.length).to eq(7)
      validation_outcome = p.valid?
      expect(validation_outcome).to eq(true)
    end

    it "requires body to be present" do
      p = Post.new ({title: "test"})
      p.body = "testa"
      validation_outcome = p.valid?
      expect(validation_outcome).to eq(true)
    end
  end
end
