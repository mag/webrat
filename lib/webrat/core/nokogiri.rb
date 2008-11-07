require "webrat/core_extensions/meta_class"

module Webrat
  
  def self.nokogiri_document(stringlike) #:nodoc:
    return stringlike.dom if stringlike.respond_to?(:dom)
    
    if stringlike === Nokogiri::HTML::Document || stringlike === Nokogiri::XML::NodeSet
      stringlike
    elsif stringlike === StringIO
      Nokogiri::HTML(stringlike.string)
    elsif stringlike.respond_to?(:body)
      Nokogiri::HTML(stringlike.body.to_s)
    else
      Nokogiri::HTML(stringlike.to_s)
    end
  end
  
  def self.define_dom_method(object, dom) #:nodoc:
    object.meta_class.send(:define_method, :dom) do
      dom
    end
  end
  
end


module Nokogiri
  module CSS
    class XPathVisitor
      
      def visit_pseudo_class_text(node) #:nodoc:
        "@type='text'"
      end

      def visit_pseudo_class_password(node) #:nodoc:
        "@type='password'"
      end
      
    end
  end
end