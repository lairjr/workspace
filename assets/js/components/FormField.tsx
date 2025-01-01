import React from 'react';
import debounce from '../debounce';

interface FormFieldProps {
  initialValue: string;
  onChange: (value: string) => void;
  render: (value: string, onChange: (value: string) => void) => React.ReactNode;
}

function FormField({ initialValue, onChange, render }: FormFieldProps) {
  const [value, setValue] = React.useState(initialValue || '');

  const debounceUpdate = debounce<(value: string) => void>((value: string) => {
    onChange(value);
  }, 500);

  const handleChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    setValue(event.target.value);
    debounceUpdate(event.target.value);
  };

  return <>{render(value, handleChange)}</>;
}

export default FormField;
