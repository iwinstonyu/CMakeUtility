macro(m_source_group_recurse _sources)
	file(GLOB_RECURSE _sources
	"./*.cpp"
	"./*.h"
	)

	foreach(temp_source ${_sources})
	file(RELATIVE_PATH temp_path ${CMAKE_CURRENT_SOURCE_DIR} ${temp_source})
	get_filename_component(temp_file_name ${temp_path} NAME)
	string(REPLACE ${temp_file_name} "" temp_path ${temp_path})
	if(NOT temp_path STREQUAL "")
	  string(REGEX REPLACE "/+$" "" temp_path ${temp_path})
	  string(REPLACE "/" "\\" temp_path ${temp_path})
	  source_group("${temp_path}" FILES ${temp_source})
	endif()
	endforeach()
endmacro()


macro(m_set_vs_runtime_mt)
	if(MSVC)
		foreach(flag_var
		CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE
		CMAKE_CXX_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_RELWITHDEBINFO)
			if(${flag_var} MATCHES "/MD")
				string(REGEX REPLACE "/MD" "/MT" ${flag_var} "${${flag_var}}")
			endif()
		endforeach()
	endif()
endmacro()


macro(m_set_proj_pch _pch_name)
	set_target_properties(${PROJECT_NAME} PROPERTIES COMPILE_FLAGS "/Yu${_pch_name}.h")
	set_source_files_properties(${_pch_name}.cpp PROPERTIES COMPILE_FLAGS "/Yc${_pch_name}.h")
endmacro()


macro(m_set_proj_prefix _pre)
	set_target_properties(${PROJECT_NAME} PROPERTIES PREFIX "${_pre}")
endmacro()


macro(m_set_vs_debugger_working_directory _dir)
	set_target_properties(${PROJECT_NAME} PROPERTIES VS_DEBUGGER_WORKING_DIRECTORY ${_dir})
endmacro()