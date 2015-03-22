//
//  main.swift
//  LinearAlgebra
//
//  Created by Jean Blignaut on 2015/03/21.
//  Copyright (c) 2015 Jean Blignaut. All rights reserved.
//

import Foundation
import Accelerate

let a: Array<Double> = [1,2,3,4]
let b: Array<Double> = [1,2,3]
var A = la_object_t()
var B = la_object_t()

a.withUnsafeBufferPointer{ (buffer: UnsafeBufferPointer<Double>) -> Void in
    //should have been short hand for below but some how doesn't work in swift
    //A = la_vector_from_double_buffer(buffer.baseAddress, la_count_t(4), la_count_t(1), la_attribute_t(LA_DEFAULT_ATTRIBUTES))
    A = la_matrix_from_double_buffer(buffer.baseAddress, la_count_t(a.count), la_count_t(1), la_count_t(1), la_hint_t(LA_NO_HINT), la_attribute_t(LA_DEFAULT_ATTRIBUTES))
}

b.withUnsafeBufferPointer { (buffer: UnsafeBufferPointer<Double>) -> Void in
    //should have been short hand for below but some how doesn't work in swift
    //B = la_vector_from_double_buffer(buffer.baseAddress, la_count_t(4), la_count_t(1), la_attribute_t(LA_DEFAULT_ATTRIBUTES))
    //I would have expected that the transpose would be required but seems oiptional
    B = //la_transpose(
        la_matrix_from_double_buffer(buffer.baseAddress, la_count_t(b.count), la_count_t(1), la_count_t(1), la_hint_t(LA_NO_HINT), la_attribute_t(LA_DEFAULT_ATTRIBUTES))//)
}

let res = la_solve(A,B)

let mult = la_outer_product(A, B)

var buf: Array<Double> = [0,0,0
                         ,0,0,0
                         ,0,0,0
                         ,0,0,0]

buf.withUnsafeMutableBufferPointer {
    (inout buffer: UnsafeMutableBufferPointer<Double>) -> Void in
    la_matrix_to_double_buffer(buffer.baseAddress, la_count_t(3), mult)
}

//contents of a
println(a)
//contents of b
println(b)
//seems to be the dimensions of the vector in A
print(A)
//seems to be the dimensions of the vector in B
print(B)
//seems to be the dimensions of the resultant matrix
print(mult)
//result
println(buf)


