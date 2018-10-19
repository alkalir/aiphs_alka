import babeltrace.writer as btw
import tempfile

# temporary directory holding the CTF trace
trace_path = tempfile.mkdtemp()

print('trace path: {}'.format(trace_path))

# our writer
writer = btw.Writer(trace_path)
writer.byte_order = 2 #setto modalità big endian, info trovata su babeltrace.h

# create one default clock and register it to the writer
# the default frequency is 1 Ghz, that increments clock each nanosecond
clock = btw.Clock('my_clock')
clock.description = 'this is my clock'
#clock.offset_seconds = 18
#clock.time = 18
writer.add_clock(clock)

# create stream_profiler_1 stream class and assign our clock to it
stream_class = btw.StreamClass('stream_profiler_1')
stream_class.clock = clock


# create response_time event class, that stores all the response times collected by profiler_1
event_class = btw.EventClass('response_time')

# create one 8-bit unsigned integer field. This will be used for code ID.
int8_field_decl = btw.IntegerFieldDeclaration(8)
int8_field_decl.signed = False
# add this field declaration to response_time event class
event_class.add_field(int8_field_decl, 'ID_field')

# create one 32-bit signed integer field. This will be used for timestamp.
int32_field_decl = btw.IntegerFieldDeclaration(32)
int32_field_decl.signed = False
# add this field declaration to response_time event class
event_class.add_field(int32_field_decl, 'timestamp_field')

# create one 32-bit signed integer field. This will be used for timestamp
# int32_field_decl = btw.IntegerFieldDeclaration(32)
# int32_field_decl.signed = True
# add this field declaration to our event class
#event_class.add_field(int32_field_decl, 'timestamp_field')

# register response_time event class to stream_profiler_1 stream class
stream_class.add_event_class(event_class)

# create a single event1, event2, event3, event4, event5, based on response_time event class
event1 = btw.Event(event_class)
event2 = btw.Event(event_class)
event3 = btw.Event(event_class)
event4 = btw.Event(event_class)
event5 = btw.Event(event_class)

# assign an integer value to our single field of event1, event2, event3, event4, event5
event1.payload('ID_field').value = 1
event1.payload('timestamp_field').value = 780000
event2.payload('ID_field').value = 45
event2.payload('timestamp_field').value = 781000
event3.payload('ID_field').value = 48
event3.payload('timestamp_field').value = 782000
event4.payload('ID_field').value = 49
event4.payload('timestamp_field').value = 783000
event5.payload('ID_field').value = 50
event5.payload('timestamp_field').value = 784000

# create stream_profiler_1 stream
stream = writer.create_stream(stream_class)

# append our single event1, event2, event3, event4, event5 to stream_profiler_1 stream
stream.append_event(event1)
stream.append_event(event2)
stream.append_event(event3)
stream.append_event(event4)
stream.append_event(event5)

# flush the stream
stream.flush()
