from itertools import chain

from .base import Base


class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)

        self.name = "gesture"
        self.kind = "word"
        self.matchers = ["matcher_substring"]
        self.sorters = []

    def gather_candidates(self, context):
        gestures = [
            [
                self._transform_gesture(x)
                for x in g["global"] + list(g["buffer"].values())
            ]
            for g in self.vim.call("gesture#get").values()
        ]

        return [
            {"word": self._format_word(g)}
            for g in sorted(list(chain.from_iterable(gestures)), key=lambda x: x["id"])
        ]

    def _transform_gesture(self, gesture):
        return {
            "inputs": map(
                lambda i: self._format_line(i)
                if i["kind"] == "direction"
                else self._format_text(i),
                gesture["inputs"],
            ),
            "rhs": gesture["rhs"],
            "id": gesture["id"],
        }

    def _format_word(self, gesture) -> str:
        return "{}: {} => {}".format(
            gesture["id"], ",".join(gesture["inputs"]), gesture["rhs"]
        )

    def _format_line(self, line) -> str:
        condition = "x"

        if line["min_length"] is not None:
            condition = "{} < x".format(line["min_length"])

        if line["max_length"] is not None:
            condition = "{} < {}".format(condition, line["max_length"])

        formatted = line["value"]
        if not condition == "x":
            formatted = "{}({})".format(formatted, condition)

        return formatted

    def _format_text(self, text) -> str:
        condition = "x"

        if text["min_count"] is not None:
            condition = "{} < x".format(text["min_count"])

        if text["max_count"] is not None:
            condition = "{} < {}".format(condition, text["max_count"])

        formatted = text["value"]
        if not condition == "x":
            formatted = "{}({})".format(formatted, condition)

        return formatted
