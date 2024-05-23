KEY_OEIS_RANDOM_SEQUENCE = "oeis_random_sequence"
KEY_LIST_OF_NUMBERS = "list_of_numbers"
KEY_SUM_OF_NUMBERS = "sum_of_numbers"
KEY_MEAN_OF_NUMBERS = "mean_of_numbers"
KEY_MEDIAN_OF_NUMBERS = "median_of_numbers"
KEY_FINAL_RESULT = "final_result"


class Pipeline:
    """Pipeline class to store data between steps of the pipeline"""

    def __init__(self):
        self.data = {}

    @property
    def oeis_random_sequence(self):
        return self.data[KEY_OEIS_RANDOM_SEQUENCE]

    @oeis_random_sequence.setter
    def oeis_random_sequence(self, value):
        self.data[KEY_OEIS_RANDOM_SEQUENCE] = value

    @property
    def list_of_numbers(self):
        return self.data[KEY_LIST_OF_NUMBERS]

    @list_of_numbers.setter
    def list_of_numbers(self, value):
        self.data[KEY_LIST_OF_NUMBERS] = value

    @property
    def sum_of_numbers(self):
        return self.data[KEY_SUM_OF_NUMBERS]

    @sum_of_numbers.setter
    def sum_of_numbers(self, value):
        self.data[KEY_SUM_OF_NUMBERS] = value

    @property
    def mean_of_numbers(self):
        return self.data[KEY_MEAN_OF_NUMBERS]

    @mean_of_numbers.setter
    def mean_of_numbers(self, value):
        self.data[KEY_MEAN_OF_NUMBERS] = value

    @property
    def median_of_numbers(self):
        return self.data[KEY_MEDIAN_OF_NUMBERS]

    @median_of_numbers.setter
    def median_of_numbers(self, value):
        self.data[KEY_MEDIAN_OF_NUMBERS] = value

    @property
    def final_result(self):
        return self.data[KEY_FINAL_RESULT]

    @final_result.setter
    def final_result(self, value):
        self.data[KEY_FINAL_RESULT] = value
