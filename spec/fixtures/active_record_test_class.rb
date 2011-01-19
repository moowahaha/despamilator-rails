class SomeActiveRecordModel < SomeActiveRecordModelBase

  validate_with_despamilator :attributes => [:some_field]

end
