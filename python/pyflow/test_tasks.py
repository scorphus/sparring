import statistics

import pytest
import pipeline as pipeline_module
import tasks


OEM_RANDOM_SEQUENCE = "1, 2, 3, 4, 5"
LIST_OF_NUMBERS = [1, 2, 3, 4, 5]


@pytest.fixture(name="pipeline")
def fixture_pipeline(requests_mock):
    requests_mock.get(tasks.OEIS_WEBCAM_URL, text=f"<tt>{OEM_RANDOM_SEQUENCE}</tt>")
    return pipeline_module.Pipeline()


@pytest.fixture(name="pipeline_with_sequence")
def fixture_pipeline_with_sequence(pipeline):
    return tasks.RetrieveOEISRandomSequence().execute(pipeline)


@pytest.fixture(name="pipeline_with_list")
def fixture_pipeline_with_list(pipeline_with_sequence):
    return tasks.ComputeListOfNumbers().execute(pipeline_with_sequence)


@pytest.fixture(name="pipeline_with_sum")
def fixture_pipeline_with_sum(pipeline_with_list):
    return tasks.CalculateSumOfNumbers().execute(pipeline_with_list)


@pytest.fixture(name="pipeline_complete")
def fixture_pipeline_complete(pipeline_with_sum):
    pipeline = tasks.CalculateMeanOfNumbers().execute(pipeline_with_sum)
    return tasks.CalculateMedianOfNumbers().execute(pipeline)


def test_retrieve_oeis_random_sequence(pipeline):
    task = tasks.RetrieveOEISRandomSequence()
    pipeline = task.execute(pipeline)
    assert pipeline.oeis_random_sequence is not None
    assert isinstance(pipeline.oeis_random_sequence, str)
    assert len(pipeline.oeis_random_sequence) > 0
    assert pipeline.oeis_random_sequence == OEM_RANDOM_SEQUENCE


def test_compute_list_of_numbers(pipeline_with_sequence):
    task = tasks.ComputeListOfNumbers()
    pipeline = task.execute(pipeline_with_sequence)
    assert pipeline.list_of_numbers is not None
    assert isinstance(pipeline.list_of_numbers, list)
    assert len(pipeline.list_of_numbers) > 0
    assert all(isinstance(x, int) for x in pipeline.list_of_numbers)
    assert pipeline.list_of_numbers == LIST_OF_NUMBERS


def test_calculate_sum_of_numbers(pipeline_with_list):
    task = tasks.CalculateSumOfNumbers()
    pipeline = task.execute(pipeline_with_list)
    assert pipeline.sum_of_numbers is not None
    assert isinstance(pipeline.sum_of_numbers, int)
    assert pipeline.sum_of_numbers == sum(LIST_OF_NUMBERS)


def test_calculate_mean_of_numbers(pipeline_with_sum):
    task = tasks.CalculateMeanOfNumbers()
    pipeline = task.execute(pipeline_with_sum)
    assert pipeline.mean_of_numbers is not None
    assert isinstance(pipeline.mean_of_numbers, float)
    assert pipeline.mean_of_numbers == sum(LIST_OF_NUMBERS) / len(LIST_OF_NUMBERS)


def test_calculate_median_of_numbers(pipeline_with_list):
    task = tasks.CalculateMedianOfNumbers()
    pipeline = task.execute(pipeline_with_list)
    assert pipeline.median_of_numbers is not None
    assert isinstance(pipeline.median_of_numbers, float) or isinstance(
        pipeline.median_of_numbers, int
    )
    assert pipeline.median_of_numbers == statistics.median(LIST_OF_NUMBERS)


def test_compute_final_result(pipeline_complete):
    task = tasks.ComputeFinalResult()
    pipeline = task.execute(pipeline_complete)
    assert pipeline.final_result is not None
    assert isinstance(pipeline.final_result, dict)
    assert pipeline.final_result == {
        "sum": sum(LIST_OF_NUMBERS),
        "mean": sum(LIST_OF_NUMBERS) / len(LIST_OF_NUMBERS),
        "median": statistics.median(LIST_OF_NUMBERS),
    }


def test_task_get_tasks_in_static_order():
    expected = [
        tasks.RetrieveOEISRandomSequence,
        tasks.ComputeListOfNumbers,
        tasks.CalculateSumOfNumbers,
        tasks.CalculateMedianOfNumbers,
        tasks.CalculateMeanOfNumbers,
        tasks.ComputeFinalResult,
    ]
    actual = list(tasks.Task.get_tasks_in_static_order())
    assert actual == expected


def test_task_get_tasks_in_parallelizable_order():
    expected = [
        (tasks.RetrieveOEISRandomSequence,),
        (tasks.ComputeListOfNumbers,),
        (
            tasks.CalculateSumOfNumbers,
            tasks.CalculateMedianOfNumbers,
        ),
        (tasks.CalculateMeanOfNumbers,),
        (tasks.ComputeFinalResult,),
    ]
    actual = list(tasks.Task.get_tasks_in_parallelizable_order())
    assert actual == expected
