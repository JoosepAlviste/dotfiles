; Highlight scripts as bash
(block_mapping_pair
  key: (_) @_script (#eq? @_script "script")
  value: (block_node
    (block_sequence
      (block_sequence_item
        (flow_node) @bash))))

(block_mapping_pair
  key: (_) @_script (#eq? @_script "before_script")
  value: (block_node
    (block_sequence
      (block_sequence_item
        (flow_node) @bash))))
