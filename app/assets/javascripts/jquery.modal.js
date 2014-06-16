var modalWindow=new Object();
var currentModalSettings={};
this.modalWindow.create = function(settings)
{
    // 2011.5.24 faqWindow.destroy({});
    $('#modalMainContainer').remove();
 
	settings = jQuery.extend(true,{
        'function'          :   "_getModal",
        'effects'           :   {'type':'show','speed':''},
        'type'              :   'normal',   //normal, review, alert
        'enforceRequired'   :   true,
        'draggable'         :   false,
        'position'          :   'center',
        'backCover'         :   true,
        'backCoverOp'       :   '',
        'onClose'           :   '',
        'staticButton'      :   {
                                    'display'   :   true,
                                    'color'     :   'aqua',
                                    'text'      :   {
                                                        'navElement'    :   'Continue',
                                                        'reviewElement' :   'Save'
                                                    },
                                    'onClick'   :   {
                                                        'navOverride'   :   false,
                                                        'navElement'    :   '',
                                                        'reviewElement' :   ''
                                                    }
                                }
    }, settings);
    currentModalSettings=settings;

	var datalist={'function':settings['function'],'modal_nav':settings.modal_nav,'type':settings['type'],'enforceRequired':settings['enforceRequired']};
	$.ajax({
		type: "POST",
		url: BASE_URL+'indatusLibraries/',
		data: datalist,
		success: function(returnData)
		{
            if(settings.backCover)
            {
                $('#coverDiv').width($(document).width());
	            $('#coverDiv').height($(document).height());

                if(settings.backCoverOp)
                    $('#coverDiv').css({opacity:settings.backCoverOp});

                $('#coverDiv').show();
            }

	        $("body").append(returnData);

            //more options will be added later.
            switch(settings.position)
            {
                case 'center':
                    var modalTop=$(window).scrollTop()+($(window).height()/2-$('#modalMainContainer').height()/2);
                    modalTop=modalTop<0?0:modalTop;
                    $('#modalMainContainer').css('top', modalTop);
	                $('#modalMainContainer').css('left', $(window).width()/2-$('#modalMainContainer').width()/2);
	                $('#modalMainContainer').css('min-height','450px' );
	                $('#modalMainContainer').css('height','auto' );
                    var top=$('#modalMainContainer').css('top').replace(/px/gi,'');
                    if(top<0)
                        $('#modalMainContainer').css('top','0px');
                break;
            }

            if(settings.draggable)
            {
                $(".js_modal_main").mousedown(function(e)
	            {
		            yOffset = e.pageX-$('#modalMainContainer').offset().left;
		            xOffset = e.pageY-$('#modalMainContainer').offset().top;

		            $("body").mousemove(
			            function(e)
			            {
                            
				            $('#modalMainContainer')
					            .css("top",(e.pageY - xOffset) + "px")
					            .css("left",(e.pageX - yOffset) +  "px");
					
			            return false;
			            }	
		            );			
                });
    
                $(".js_modal_main").mouseup(function(e)
	            {
		            $("body").unbind('mousemove');		
                });
            }

            $("#modalCloseButton").click(
		        function()
		        {
			        modalWindow.destroy(settings);
		        }
	        );
            
            if(settings.effects.type=='fadein')
                $('#modalMainContainer').fadeIn(settings.effects.speed);
            else
            if(settings.effects.type=='show')
                $('#modalMainContainer').show();

		},
		error: function (returnData)
		{
			alert('Internal server error');
		}
	});
	
};

this.modalWindow.loadNavElement = function(passedObj)
{
    if(currentModalSettings.type=='normal'||currentModalSettings.type=='review'){
	    $('.core_modal_nav_pointer_ON').each(
		    function ()
		    {
			    $(this).removeClass('core_modal_nav_pointer_ON')	
		    }
	    );
	    $('.core_modal_nav_button_ON').each(
		    function ()
		    {
			    $(this).removeClass('core_modal_nav_button_ON')	
		    }
	    );

	    $(passedObj).parent().addClass('core_modal_nav_pointer_ON');
	    $(passedObj).addClass('core_modal_nav_button_ON');
    }
			
	var id=$(passedObj).attr('id').split('_')[1];
	navAction=jQuery.parseJSON($('#navMenuAction_'+id).val());

	var datalist='';
	if(navAction['subcontrol'].length>0)
		datalist+='function='+navAction['subcontrol'];

	if(navAction['variables'].length>0)
		datalist+='&'+navAction['variables'];
	else
		datalist+=navAction['variables'];

	$.ajax({
		type:	"POST",
		url	:	navAction['controller'],
		data:	datalist,
        async:  false,
		success:
			function(returnData)
			{
				$('#modal_title_area').html(navAction['title']);
                
                if(navAction['FAQ'])
                {
                    $('#modalMainContainer .js_FAQ').show();
                    /* 2011.5.24
                    faqWindow.attach({
                     'faqclass':'#modalMainContainer .js_FAQ',
                     'arrowPos'  :   'right',
                     'FAQ'  :   navAction['FAQ']
                    });*/
                }
                else
                    $('#modalMainContainer .js_FAQ').hide();

				$('#modal_content_area').html(returnData);


                if($('#modalType').val()=='review' && currentModalSettings.staticButton.display){
                    var currentNavID=$('.core_modal_nav_button_ON').first().attr('id').split('_')[1];
                    var totalNavElements=$('.js_modalNavMenus').size();
                    var currentNavCount=parseInt(currentNavID)+1;
                    
                    if(totalNavElements==currentNavCount)
                        var ButtonText=currentModalSettings.staticButton.text.reviewElement;
                    else
                        var ButtonText=currentModalSettings.staticButton.text.navElement;

                    var button=''+
               	    '<div class="core_modal_button_constant">'+
		                '<div class="xxxcore_component_item">'+
			                '<div id="reviewStaticButton">'+ButtonText+'</div>'+
		                '</div>'+
	                '</div>';

                    $('#modal_content_area').append(button);
                   /*$('.core_modal_inner_component').append(button);*/
                    
                    $('#reviewStaticButton').indatusButtonPress({
	                    'color'		:	currentModalSettings.staticButton.color,
	                    'onClick'   :   function(){

                                            if(totalNavElements>currentNavCount){
                                                if(currentModalSettings.staticButton.onClick.navElement && typeof(currentModalSettings.staticButton.onClick.navElement)=='function')
                                                    currentModalSettings.staticButton.onClick.navElement.call(this);

                                                if(!currentModalSettings.staticButton.onClick.navOverride)
                                                    loadModalNavElementFunc($('#navMenu_'+currentNavCount));
                                            }else{
                                                if(currentModalSettings.staticButton.onClick.reviewElement && typeof(currentModalSettings.staticButton.onClick.reviewElement)=='function')
                                                    currentModalSettings.staticButton.onClick.reviewElement.call(this);
                                            }
                                        }
                    });
                }
			},
		error:
            function()
		    {
			    alert("failure");
		    }
	});
}


this.modalWindow.destroy=function(settings)
{
	settings = jQuery.extend({
        'onClose'   :   ''
    }, settings);
	
    if(settings.onClose && typeof(settings.onClose)=='function')
        settings.onClose.call(this);


    currentModalSettings={};
    if(settings.type=='review'){
	    var modalFormData={};
    }

    // 2011.5.24 faqWindow.destroy({});
    $('#modalMainContainer').remove();
    $('#coverDiv').hide();
}