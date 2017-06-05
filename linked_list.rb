class Node
  attr_accessor :val, :next

  def initialize(val)
    @val = val
  end

  def self.last(node)
    return node if node.next.nil?
    last node.next
  end

  def add_to_tail(val)
    n = Node.new(val)
    last = Node.last(node)
    last.next = n
  end

  def self.delete_node(head, val)
    n = head
    n.next if n.val == val

    while !n.next.nil?
      if n.next.val == val
        n.next = n.next.next
        retrun head
      end
      n = n.next
    end

    return head
  end
end

class LinkedList
  attr_accessor :head

  def add_node(val)
    if head.nil?
      @head = Node.new(val)
    else
      @head.add_to_tail(val)
    end
  end

  def add_after(node, new_node)
    new_node.next = node.next
    node.next = new_node
  end

  def add_at_beginning(node)
    node.next = @head
    @head = node
  end
end