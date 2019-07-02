
import yaml
from yaml.composer import Composer

from .base import Base


class Source(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'yaml_outline'
        self.kind = 'file'
        self.sorters = ['sorter_line_number']

    def gather_candidates(self, context):
        path = self.vim.call('expand', '%:p')

        with open(path, 'r') as f:
            loader = yaml.Loader(f)

        candidates = []

        def compose_node(parent, index):
            line = loader.line
            node = Composer.compose_node(loader, parent, index)
            node.__line__ = line + 1
            return node

        loader.compose_node = compose_node

        def compose_mapping_node(anchor):
            node = Composer.compose_mapping_node(loader, anchor)
            for n in node.value:
                candidates.append(create(n))
            return node

        loader.compose_mapping_node = compose_mapping_node

        def create(node):
            return {
                'word': node[0].value,
                'action__path': path,
                'action__line': node[0].__line__,
            }

        loader.get_data()

        return candidates
