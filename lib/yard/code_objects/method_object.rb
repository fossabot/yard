module YARD::CodeObjects
  class MethodObject < Base
    attr_accessor :visibility, :scope, :signature
    
    def initialize(namespace, name, scope = :instance) 
      self.visibility = :public
      self.scope = scope

      super
    end
    
    def scope=(v) @scope = v.to_sym end
    def visibility=(v) @visibility = v.to_sym end
      
    def is_alias?
      return false if namespace.is_a?(Proxy)
      namespace.aliases.has_key? self
    end
    
    def aliases
      list = []
      namespace.aliases.each do |o, aname| 
        list << o if aname == name && o.scope == scope 
      end
      list
    end
    
    protected
    
    def sep; scope == :class ? super : ISEP end
  end
end