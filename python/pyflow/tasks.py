import abc
import graphlib
import logging
import inspect
import random
import re
import time
from typing import List

import pipeline as pipeline_module
import requests

OEIS_WEBCAM_URL = "https://oeis.org/webcam?fromjavascript=true&q=keyword:nice"
MAX_RETRIES = 3


class TaskMeta(abc.ABCMeta):
    """Metaclass for tasks"""

    registry: List["Task"] = []

    def __new__(mcs, name, bases, namespace) -> "Task":
        new_cls = super().__new__(mcs, name, bases, namespace)
        if not inspect.isabstract(new_cls) and len(new_cls.__mro__) > 2:
            mcs.check_attributes(new_cls)
            mcs.registry.append(new_cls)
        return new_cls

    @staticmethod
    def check_attributes(new_cls) -> None:
        """Check that the task has the required attributes"""
        input_keys = getattr(new_cls, "input_keys", None)
        output_keys = getattr(new_cls, "output_keys", None)
        if input_keys is None or output_keys is None:
            raise ValueError("Task must define input_keys and output_keys")
        if not isinstance(input_keys, tuple) or not isinstance(output_keys, tuple):
            raise ValueError("Task must define input_keys and output_keys as tuples")
        if not input_keys and not output_keys:
            raise ValueError("Task must have at least one input or output key")
        if len(set(output_keys)) > 1:
            raise ValueError("Task must have only one output key")
        if len(set(input_keys) & set(output_keys)) > 0:
            raise ValueError("Task input and output keys must be disjoint")

    @classmethod
    def get_tasks_in_static_order(mcs) -> List["Task"]:
        """Return all Tasks from the registry, sorted in topological order"""
        graph, input_keys_map, output_keys_map = {}, {}, {}
        for cls in mcs.registry:
            graph.setdefault(cls, set())
            for key in cls.input_keys:
                input_keys_map.setdefault(key, set()).add(cls)
            for key in cls.output_keys:
                output_keys_map.setdefault(key, set()).add(cls)
        for key, classes in input_keys_map.items():
            for cls in classes:
                graph[cls].update(output_keys_map.get(key, []))
        return list(graphlib.TopologicalSorter(graph).static_order())


class Task(metaclass=TaskMeta):
    """Base class for tasks"""

    def execute(self, pipeline: pipeline_module.Pipeline) -> pipeline_module.Pipeline:
        """Execute the task and return the updated pipeline"""
        raise NotImplementedError


class RetrieveOEISRandomSequence(Task):
    """Task to retrieve a random sequence from OEIS"""

    input_keys = ()
    output_keys = (pipeline_module.KEY_OEIS_RANDOM_SEQUENCE,)

    def execute(self, pipeline: pipeline_module.Pipeline) -> pipeline_module.Pipeline:
        """Retrieve a random sequence from OEIS and store it in the pipeline"""
        retries = 1
        while not (sequence := self.fetch_a_random_sequence()):
            if retries >= MAX_RETRIES:
                raise TimeoutError("Could not fetch a random sequence from OEIS")
            time.sleep(retries)
            retries += 1
        pipeline.oeis_random_sequence = sequence
        return pipeline

    def fetch_a_random_sequence(self) -> str:
        """Fetch a random sequence from OEIS"""
        resp = requests.get(self.get_url(), timeout=10)
        if resp.status_code != 200:
            logging.error("Failed to fetch sequence from OEIS (%s)", resp.status_code)
            return ""
        if matches := re.findall(r"(?<=tt>)\d, [\d ,]+", resp.text):
            return matches[0]
        return ""

    def get_url(self):
        """Return the URL to fetch a random sequence from OEIS"""
        return f"{OEIS_WEBCAM_URL}&random={random.random()}"


class ComputeListOfNumbers(Task):
    """Task to compute a list of numbers from the OEIS random sequence"""

    input_keys = (pipeline_module.KEY_OEIS_RANDOM_SEQUENCE,)
    output_keys = (pipeline_module.KEY_LIST_OF_NUMBERS,)

    def execute(self, pipeline: pipeline_module.Pipeline) -> pipeline_module.Pipeline:
        """Compute a list of numbers from the OEIS random sequence"""
        sequence = pipeline.oeis_random_sequence
        numbers = list(map(int, sequence.split(", ")))
        pipeline.list_of_numbers = numbers
        return pipeline


class CalculateSumOfNumbers(Task):
    """Task to calculate the sum of a list of numbers"""

    input_keys = (pipeline_module.KEY_LIST_OF_NUMBERS,)
    output_keys = (pipeline_module.KEY_SUM_OF_NUMBERS,)

    def execute(self, pipeline: pipeline_module.Pipeline) -> pipeline_module.Pipeline:
        """Sum a list of numbers and store the result in the pipeline"""
        numbers = pipeline.list_of_numbers
        pipeline.sum_of_numbers = sum(numbers)
        return pipeline


class CalculateMeanOfNumbers(Task):
    """Task to calculate the mean of a list of numbers"""

    input_keys = (
        pipeline_module.KEY_SUM_OF_NUMBERS,
        pipeline_module.KEY_LIST_OF_NUMBERS,
    )
    output_keys = (pipeline_module.KEY_MEAN_OF_NUMBERS,)

    def execute(self, pipeline: pipeline_module.Pipeline) -> pipeline_module.Pipeline:
        """Calculate the mean of a list of numbers and store the result in the pipeline"""
        the_sum, numbers = pipeline.sum_of_numbers, pipeline.list_of_numbers
        pipeline.mean_of_numbers = the_sum / len(numbers)
        return pipeline


class CalculateMedianOfNumbers(Task):
    """Task to calculate the median of a list of numbers"""

    input_keys = (pipeline_module.KEY_LIST_OF_NUMBERS,)
    output_keys = (pipeline_module.KEY_MEDIAN_OF_NUMBERS,)

    def execute(self, pipeline: pipeline_module.Pipeline) -> pipeline_module.Pipeline:
        """Calculate the median of a list of numbers and store the result in the pipeline"""
        numbers = sorted(pipeline.list_of_numbers)
        n = len(numbers)
        if n % 2 == 0:
            pipeline.median_of_numbers = (numbers[n // 2 - 1] + numbers[n // 2]) / 2
        else:
            pipeline.median_of_numbers = numbers[n // 2]
        return pipeline


class ComputeFinalResult(Task):
    """Task to compute the final result"""

    input_keys = (
        pipeline_module.KEY_SUM_OF_NUMBERS,
        pipeline_module.KEY_MEAN_OF_NUMBERS,
        pipeline_module.KEY_MEDIAN_OF_NUMBERS,
    )
    output_keys = (pipeline_module.KEY_FINAL_RESULT,)

    def execute(self, pipeline: pipeline_module.Pipeline) -> pipeline_module.Pipeline:
        """Compute the final result and store it in the pipeline"""
        pipeline.final_result = {
            "sum": pipeline.sum_of_numbers,
            "mean": pipeline.mean_of_numbers,
            "median": pipeline.median_of_numbers,
        }
        return pipeline
