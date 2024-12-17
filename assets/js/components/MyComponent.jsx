import React from 'react';

function MyComponent(props) {
    console.log(props);
    return (
        <div>
            Component react {props.name}
        </div>
    )
}

export default MyComponent;
