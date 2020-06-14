# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Description
# ==============================================================================
#
#     Wrapper to IOCTL calls.
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

@inline _ioctl(io::IOStream, args...) = _ioctl(fd(io), args...)

function _ioctl(fd::Integer, request::Integer, arg::T) where T <: Number
    ret = ccall(:ioctl, Cint, (Cint, Culong, T), fd, request, arg)
    ret < 0 && throw(SystemError("Error in IOCTL call", Libc.errno()))
    return ret
end

function _ioctl(fd::Integer, request::Integer, arg::Base.RefValue{T}) where T
    ret = ccall(:ioctl, Cint, (Cint, Culong, Ref{T}), fd, request, arg)
    ret < 0 && throw(SystemError("Error in IOCTL call", Libc.errno()))
    return ret
end

function _ioctl(fd::Integer, request::Integer, arg::AbstractVector{T}) where T
    ret = ccall(:ioctl, Cint, (Cint, Culong, Ref{T}), fd, request, arg)
    ret < 0 && throw(SystemError("Error in IOCTL call", Libc.errno()))
    return ret
end
