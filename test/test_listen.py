import mock
from listen import convert

@mock.patch('time.time')
@mock.patch('subprocess.call')
def test_convert_calls_time_once(mock_call, mock_time):

    mock_time_value = "123.123"
    mock_time.return_value = mock_time_value
    param_dict = {"source_dir": ["/source/dir"]}
    convert(param_dict)
    mock_time.assert_called_once()


@mock.patch('time.time')
@mock.patch('subprocess.call')
def test_convert_calls_subprocess_call_once(mock_call, mock_time):
    mock_time_value = "123.123"
    mock_time.return_value = mock_time_value
    param_dict = {"source_dir": "/source/dir"}
    convert(param_dict)
    mock_call.assert_called_once()


@mock.patch('time.time')
@mock.patch('subprocess.call')
def test_convert_send_success_true_if_subprocess_exits_with_zero(mock_call, mock_time):
    mock_time_value = "123.123"
    mock_time.return_value = mock_time_value

    mock_call.return_value = 0

    param_dict = {"source_dir": "/source/dir"}

    out_dict, success = convert(param_dict)

    assert success


@mock.patch('time.time')
@mock.patch('subprocess.call')
def test_convert_send_success_false_if_subprocess_exits_with_one(mock_call, mock_time):
    mock_time_value = "123.123"
    mock_time.return_value = mock_time_value

    mock_call.return_value = 1

    param_dict = {"source_dir": "/source/dir"}

    out_dict, success = convert(param_dict)

    assert not success

@mock.patch('time.time')
@mock.patch('subprocess.call')
def test_convert_result_dict_contains_filename(mock_call, mock_time):
    mock_time_value = "123.123"
    mock_time.return_value = mock_time_value

    mock_call.return_value = 0

    param_dict = {"source_dir": "/source/dir"}

    out_dict, success = convert(param_dict)

    assert "filename" in out_dict
