function toast({title='', message='', type='info', duration = 3000}){
    const main = document.getElementById('toast');
    if(main){
        const toast = document.createElement('div');

        //auto close
        const autoRemoveId = setTimeout(() => {
            main.removeChild(toast);
        },duration + 1000);

        //close when clicked
        toast.onclick = function(e){
            if(e.target.closest('.toast__close')){
                main.removeChild(toast);
                clearTimeout(autoRemoveId);
            }
        }

        const icons = {
            success: 'fa-solid fa-circle-check',
            info: 'fa-solid fa-circle-info',
            warning: 'fa-solid fa-circle-exclamation',
            error:'fa-solid fa-circle-exclamation'
        };
        const icon = icons[type];
        const delay = (duration/1000).toFixed(2);
        console.log(delay);
        toast.classList.add('toast', `toast--${type}`);
//        toast.style.animation= 'fadeIn linear 3s, sideInLeft linear 1s 4s forwards
        toast.style.animation= 'fadeInOut 4s linear 0.3s forwards';
        toast.innerHTML = `
            <div class="toast__icon">
                <i class="${icon}"></i>
            </div>
    
            <div class="toast__body">
                <h3 class="toast__title">${title}</h3>
                <p class="toast__message">${message}</p>
            </div>
    
            <div class="toast__close">   
                <i class="fa-solid fa-xmark"></i>
            </div>
        `;
        main.appendChild(toast);
        
    }
}

function showSuccessRegister(){
    toast({
        title: 'Success',
        message: 'Register Successfully!',
        type: 'success',
        duration: 3000
    });
}

function showSuccessLogin(){
    toast({
        title: 'Success',
        message: 'Login Successfully!',
        type: 'success',
        duration: 3000
    });
}

function showInfo(){
    toast({
        title: 'Info',
        message: 'Chào mừng bạn đến với chúng tôi :v',
        type: 'info',
        duration: 3000
    });
}

function showWarningRegister(){
    toast({
        title: 'Warning',
        message: 'Please enter all field.',
        type: 'warning',
        duration: 3000
    });
}

function showErrorRegister(){
    toast({
        title: 'Error',
        message: 'User already exists!',
        type: 'error',
        duration: 3000
    });
}

function showErrorLogin(){
    toast({
        title: 'Error',
        message: 'Username or Password is wrong!',
        type: 'error',
        duration: 3000
    });
}

function showWarningForget(){
    toast({
        title: 'Warning',
        message: 'Wrong username or phonenumber',
        type: 'warning',
        duration: 3000
    });
}

function showErrorForget(){
    toast({
        title: 'Error',
        message: 'Don\'t have this account!',
        type: 'error',
        duration: 3000
    });
}