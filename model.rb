class Artifact
  attr_accessor :id
  
  class Id
    @@default_id_sequence = 0

    attr_reader :canonicalString

    def initialize(s)

      # generate a default id if necessary
      if s.nil? 
        s = @@default_id_sequence.to_s
        @@default_id_sequence += 1
      end

      @canonicalString = s
    end

    def url
      @canonicalString  # TODO shorten to a url later
    end
  end


  # TODO is it a good idea to have a reference to the owning plot despite a circular dependency?


  def initialize(i=nil)
    @id = Id.new(i)
  end
  
  def to_s
    super.to_s + "(id=" + @id.canonicalString + ")"
  end
end


class Plot < Artifact
  attr_reader :children
  
  class ArtifactContainer
    attr_accessor :position  # ok for visual stuff to creep in like this?
    
    def initialize(a)
      @artifact = a
    end
    
    def to_s
      @artifact.to_s
    end
  end
  
  def add(child) #@ pre: child.class.eql? Artifact
    @children ||= Array.new
    
    throw :childAlreadyExists if @children.include? child
    
    children << ArtifactContainer.new(child)
  end
  
  def remove(child)
    throw :childDoesntExist unless @childrean.include? child
    
    children.delete ArtifactContainer.new(child)
  end
  
  def to_s
    "#{super.to_s} children=[#{ @children.nil? ? "empty" : @children.join(',') }]"
  end
end


class Stroke < Artifact
  attr_reader :coordinateMatrix  # list of x,y coordinates that make up the stroke
  
  def initialize(c)
    super(nil)
    @coordinateMatrix = c
  end
  
  def to_s
    "#{super.to_s} coordinates=#{@coordinateMatrix.inspect}"
  end
end
