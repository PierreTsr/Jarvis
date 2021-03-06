/*!
* Start Bootstrap - Grayscale v7.0.4 (https://startbootstrap.com/theme/grayscale)
* Copyright 2013-2021 Start Bootstrap
* Licensed under MIT (https://github.com/StartBootstrap/startbootstrap-grayscale/blob/master/LICENSE)
*/
//
// Scripts
// 
window.addEventListener('turbolinks:load', event => {
    const pageWrapper = $('.page-content');
    if(window.location.pathname == '/' || window.location.pathname == '/users/sign_in' || window.location.pathname == '/users/sign_up'|| window.location.pathname == '/users/questions') {
        pageWrapper.removeClass('page-content')
    } else {
        pageWrapper.addClass('page-content')
    }
    if(window.location.pathname != '/') {
        const navbarCollapsible = document.body.querySelector('#mainNav');
        navbarCollapsible.classList.add('navbar-shrink')
        return;
    }
    // Navbar shrink function
    var navbarShrink = function () {
        if(window.location.pathname != '/') {
            return;
        }
        const navbarCollapsible = document.body.querySelector('#mainNav');
        if (!navbarCollapsible) {
            return;
        }
        if (window.scrollY === 0) {
            navbarCollapsible.classList.remove('navbar-shrink')
        } else {
            navbarCollapsible.classList.add('navbar-shrink')
        }
    };

    // Shrink the navbar 
    navbarShrink();

    // Shrink the navbar when page is scrolled
    document.addEventListener('scroll', navbarShrink);

    // Activate Bootstrap scrollspy on the main nav element
    const mainNav = document.body.querySelector('#mainNav');
    if (mainNav) {
        new bootstrap.ScrollSpy(document.body, {
            target: '#mainNav',
            offset: 74,
        });
    };

    // Collapse responsive navbar when toggler is visible
    const navbarToggler = document.body.querySelector('.navbar-toggler');
    const responsiveNavItems = [].slice.call(
        document.querySelectorAll('#navbarResponsive .nav-link')
    );
    responsiveNavItems.map(function (responsiveNavItem) {
        responsiveNavItem.addEventListener('click', () => {
            if (window.getComputedStyle(navbarToggler).display !== 'none') {
                navbarToggler.click();
            }
        });
    });

});