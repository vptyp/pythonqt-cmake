add_definitions(-DPYTHONQT_EXPORTS)

target_compile_options(${PROJECT_NAME} PRIVATE
  $<$<CXX_COMPILER_ID:MSVC>:/bigobj>
  $<$<CXX_COMPILER_ID:GNU>:-Wa,-mbig-obj>
)

set(HEADERS
    PythonQt.h                  
    PythonQtStdDecorators.h     
    PythonQtClassInfo.h         
    PythonQtImporter.h          
    PythonQtObjectPtr.h         
    PythonQtProperty.h          
    PythonQtSignal.h            
    PythonQtSlot.h              
    PythonQtSlotDecorator.h     
    PythonQtStdIn.h             
    PythonQtStdOut.h            
    PythonQtMisc.h              
    PythonQtMethodInfo.h        
    PythonQtImportFileInterface.h 
    PythonQtConversion.h        
    PythonQtSignalReceiver.h   
    PythonQtInstanceWrapper.h   
    PythonQtClassWrapper.h 
    PythonQtCppWrapperFactory.h 
    PythonQtQFileImporter.h     
    PythonQtQFileImporter.h     
    PythonQtVariants.h          
    gui/PythonQtScriptingConsole.h    
    PythonQtSystem.h 
    PythonQtUtils.h 
    PythonQtBoolResult.h 
    PythonQtThreadSupport.h 
)

set(SOURCES 
    PythonQtStdDecorators.cpp   
    PythonQt.cpp                
    PythonQtClassInfo.cpp       
    PythonQtImporter.cpp        
    PythonQtObjectPtr.cpp       
    PythonQtProperty.cpp        
    PythonQtStdIn.cpp           
    PythonQtStdOut.cpp          
    PythonQtSignal.cpp          
    PythonQtSlot.cpp            
    PythonQtSlotDecorator.cpp   
    PythonQtMisc.cpp            
    PythonQtMethodInfo.cpp      
    PythonQtConversion.cpp      
    PythonQtSignalReceiver.cpp  
    PythonQtInstanceWrapper.cpp 
    PythonQtQFileImporter.cpp   
    PythonQtClassWrapper.cpp    
    PythonQtBoolResult.cpp      
    gui/PythonQtScriptingConsole.cpp 
    PythonQtThreadSupport.cpp 
)

## Force linker to complain on undefined references for dll/so/dylib build when possible
#QMAKE_LFLAGS_SHLIB += $$QMAKE_LFLAGS_NOUNDEF

#gcc:!no_warn:!clang:QMAKE_CXXFLAGS += -Wno-error=missing-field-initializers
#*-clang*:!no_warn:QMAKE_CXXFLAGS += -Wno-error=sometimes-uninitialized