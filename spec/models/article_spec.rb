require 'rails_helper'

# RSpec.describe Article, type: :model do
#   it "should test that factory is valid" do 
#     # article = Article.create(title: "Sample article", content: "Sample content", slug: "sample-slug") ===> thid will create the object manually but we can use it with factorybot gem as next line
#     # article = FactoryBot.create(:article) # it can be with out FactoryBot declaration in the rails helper (config.include FactoryBot::Syntax::Methods) too as the next line
#     # article = create(:article) # and so as to not to touch the database cuz it is just validation test we can use build instead of create as next line
#     article = build(:article)

#     # expect(article.title).to eq("Sample article")
#     expect(article).to be_valid # article.valid? == true
#   end

#   it "has invalid title" do 
#     article = build(:article, title: '')

#     expect(article).not_to be_valid
#     expect(article.errors[:title]).to include("can not be blank")
#   end
  
# end All last RSpec can be refacored to the next line for DRY purpuses

RSpec.describe Article, type: :model do

  describe '#validation' do
    let(:article) { build(:article) }
   # article.valid? == true
    it 'should test that factory is valid' do 
      expect(article).to be_valid                 
    end
   # article.title.valid? == true
    it 'should has a valid title' do   
      article.title = ''
      expect(article).not_to be_valid             
      expect(article.errors[:title]).to include("can't be blank")
    end
   # article.content.valid? == true
    it 'should has a has valid content' do 
      article.content = ''
      expect(article).not_to be_valid              
      expect(article.errors[:content]).to include("can't be blank")
    end
   # article.slug.valid? == true
    it 'should has a has valid slug' do 
      article.slug = ''
      expect(article).not_to be_valid               
      expect(article.errors[:slug]).to include("can't be blank")
    end
   # article.slug.uniq? == true
    # it { should validate_uniqueness_of(:slug) }    #or   test uniqueness
    
    # it { is_expected.to validate_uniqueness_of :slug }    #or  test uniqueness

    it "should validates uniqueness of slug" do
      
      should validate_uniqueness_of(:slug)
    end
   
  end

  describe '.recent' do 
    it 'returns articles in the correct order' do 
      older_article = create(:article, created_at: 1.hour.ago)
      recent_article = create(:article)

      expect(described_class.recent).to eq([recent_article, older_article])

      recent_article.update_column(:created_at, 2.hours.ago)

      expect(described_class.recent).to eq([older_article, recent_article])
    end
  end
end

#Assignment uniquness test solution by instructor
#--------------------------------------------------
# # spec/models/article_spec.rb

# RSpec.describe Article, type: :model do
#   describe '#validations' do
#     let(:article) { build(:article) }

#     it 'tests that factory is valid' do
#       expect(article).to be_valid # article.valid? == true
#       article.save!
#       another_article = build(:article)
#       expect(another_article).to be_valid
#     end

#     it 'has an invalid title' do
#       article.title = ''
#       expect(article).not_to be_valid
#       expect(article.errors[:title]).to include("can't be blank")
#     end

#     it 'has an invalid content' do
#       article.content = ''
#       expect(article).not_to be_valid
#       expect(article.errors[:content]).to include("can't be blank")
#     end

#     it 'has an invalid slug' do
#       article.slug = ''
#       expect(article).not_to be_valid
#       expect(article.errors[:slug]).to include("can't be blank")
#     end

#     it 'validates the uniqueness of the slug' do
#       article1 = create(:article)
#       expect(article1).to be_valid
#       article2 = build(:article, slug: article1.slug)
#       expect(article2).not_to be_valid
#       expect(article2.errors[:slug]).to include('has already been taken')
#     end
#   end
# end
