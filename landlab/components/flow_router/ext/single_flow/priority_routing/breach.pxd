# distutils: language = c++
import numpy as np

cimport cython
cimport numpy as cnp
from libcpp cimport bool
from libcpp.pair cimport pair


cdef extern from "_priority_queue.hpp" nogil:
    cdef cppclass _priority_queue:
        _priority_queue(...) except +
        void push(pair[cnp.int64_t, cnp.float_t])
        pair[cnp.int64_t, cnp.float_t] top() except +
        void pop()
        bool empty()
        cnp.int64_t size()


cdef bool _compare_second(pair[int, double] a, pair[int, double] b) nogil


cdef void _init_flow_direction_queues(
    const cnp.int64_t [:] base_level_nodes,
    const cnp.int64_t [:] closed_nodes,
    cnp.float_t [:] z,
    _priority_queue& to_do,
    cnp.int64_t [:] receivers,
    cnp.int64_t [:] outlet_nodes,
    cnp.int64_t [:] done, cnp.int64_t* done_n_ptr
) nogil


cdef void _set_flooded_and_outlet(
    cnp.int64_t donor_id,
    cnp.float_t [:] z,
    cnp.int64_t [:] receivers,
    cnp.int64_t [:] outlet_nodes,
    cnp.int64_t [:] depression_outlet_nodes,
    cnp.int64_t [:] flooded_nodes,
    cnp.float_t [:] depression_depths,
    cnp.float_t [:] depression_free_elevations,
    cnp.int64_t flooded_status,
    cnp.int64_t bad_index,
    cnp.float_t min_elevation_relative_diff
) nogil


cdef void _set_receiver(
    cnp.int64_t donor_id,
    cnp.int64_t receiver_id,
    cnp.int64_t [:] receivers,
    cnp.int64_t [:] done,
    cnp.int64_t* done_n_ptr,
) nogil


cdef void _set_donor_properties(
    cnp.int64_t donor_id,
    cnp.int64_t receiver_id,
    cnp.int64_t [:] sorted_pseudo_tails,
    const cnp.int64_t [:, :] head_start_end_indexes,
    const cnp.int64_t [:] sorted_dupli_links,
    cnp.float_t [:] sorted_dupli_gradients,
    cnp.float_t [:] z,
    cnp.float_t [:] steepest_slopes,
    cnp.int64_t [:] links_to_receivers,
) nogil


cdef void _direct_flow_c(
    cnp.int64_t nodes_n,
    const cnp.int64_t[:] base_level_nodes,
    const cnp.int64_t[:] closed_nodes,
    cnp.int64_t[:] sorted_pseudo_tails,
    cnp.float_t[:] sorted_dupli_gradients,
    const cnp.int64_t[:] sorted_dupli_links,
    const cnp.int64_t[:, :] head_start_end_indexes,
    cnp.int64_t [:] outlet_nodes,
    cnp.int64_t [:] depression_outlet_nodes,
    cnp.int64_t[:] flooded_nodes,
    cnp.float_t[:] depression_depths,
    cnp.float_t [:] depression_free_elevations,
    cnp.int64_t[:] links_to_receivers,
    cnp.int64_t[:] receivers,
    cnp.float_t[:] steepest_slopes,
    cnp.float_t[:] z,
    cnp.int64_t flooded_status,
    cnp.int64_t bad_index,
    cnp.int64_t neighbors_max_number,
    cnp.float_t min_elevation_relative_diff,
)
