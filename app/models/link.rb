class Link < ActiveRecord::Base
  attr_accessible :title, :url

  belongs_to :user
  has_many :comments

  searchable do 
  	text :title
  end

  def self.db_search(query) #pass in q parameter
  	where('title LIKE ?', "%#{query}%") #use this syntax when you are passing in a string parameter, use the question mark
  end


#We will use search engine Solr http://lucene.apache.org/solr, a Java application, open source, a web service that uses Lucene
#another one is elasticsearch www.elasticsearch.org, also built on Lucene
#We are using solar because there is a ruby gem, Sunspot


  def self.search(query,params={})
    solr_search do

      fulltext query do
        minimum_match 1
        paginate :page => params[:page], :per_page => params[:per_page]
      end
    end
  end
end
