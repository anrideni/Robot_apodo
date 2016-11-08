function varargout = GUI(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- PRIMERA FUNCION INICIADA DEL PROGAMA
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for GUI
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

%variables globales
global rad  ;
global grad;
global d ; % longitud
global do;
global M; % cantidad de modulos
global l;
global k;% siclos
global angini; %angulo iicial
global fase; %fase inicial
global velocidad; %velocidad
global puerto; %PUERTO SERIAL
global trama; %TRAMA DE DATOS
global atras_sp;
global adelante_sp;
global conectar;
%CONVERSIONES
rad= pi/180;
grad= 180/pi;
do=d/2;
l=M*d;
velocidad = 1.0;
adelante_sp=1;
conectar=0;
global sis3D;

%timer
t=timer('TimerFcn',{@user_timercallback,hObject},...
                    'ExecutionMode','fixedRate',...
                    'Period',velocidad);
                
 %ESTAS LINEAS DE CODIGO SON LAS QUE PERMITEN INTRODUCIR UNA IMAGEN 
%DENTRO DE UNA INTERFAZ GRAFICA
axes(handles.logo);
background = imread('udi.jpg');
%axis off;
imshow(background);

%  %GRAFICA              
%     axes(handles.pantalla);
%    % axes([-2 (l+5) -2 6])
%     xlabel('EJE X(m)')
%     ylabel('EJE Y(m)')
%     title ('CONTROL CINEMATICO SERPIENTE CON 4 GDL')
%     grid; 

%Sistema 3D
close(sis3D);
sis3D=vrworld('SNAKE2.wrl','new');
open(sis3D);
fig=vrfigure(sis3D);%cargando Mundo VRML
set(fig,'Viewpoint','Superior');
set(fig,'Viewpoint','Atras');
set(fig,'Viewpoint','Frente');
set(fig,'Name','SNAKE ROBOT')
set(fig,'ZoomFactor',1);
set(fig,'NavMode','Examine');
   
                
                
% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Tbx_longitud_Callback(hObject, eventdata, handles)
% hObject    handle to Tbx_longitud (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tbx_longitud as text
%        str2double(get(hObject,'String')) returns contents of Tbx_longitud as a double


% --- Executes during object creation, after setting all properties.
function Tbx_longitud_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tbx_longitud (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tbx_angulo_inicial_Callback(hObject, eventdata, handles)
% hObject    handle to Tbx_angulo_inicial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tbx_angulo_inicial as text
%        str2double(get(hObject,'String')) returns contents of Tbx_angulo_inicial as a double


% --- Executes during object creation, after setting all properties.
function Tbx_angulo_inicial_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tbx_angulo_inicial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider_velocidad_Callback(hObject, eventdata, handles)
global velocidad
global t;

%timer


%RECOJER EL VALOR DEL SLIDER
    vel=get(hObject,'Value') %returns position of slider
    if vel== 0  
     velocidad=0.010
    else
        velocidad=vel ;
    end
stop(t);
t=timer('TimerFcn',{@user_timercallback,hObject},...
                    'ExecutionMode','fixedRate',...
                    'Period',velocidad);
start(t);
%MOSTRAR EL VALOR DEL SLIDER
set(handles.Lbl_velocidad,'String',velocidad);
  


% --- Executes during object creation, after setting all properties.
function slider_velocidad_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_velocidad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



function Tbx_arti_1_Callback(hObject, eventdata, handles)
% hObject    handle to Tbx_arti_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tbx_arti_1 as text
%        str2double(get(hObject,'String')) returns contents of Tbx_arti_1 as a double


% --- Executes during object creation, after setting all properties.
function Tbx_arti_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tbx_arti_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tbx_arti_2_Callback(hObject, eventdata, handles)
% hObject    handle to Tbx_arti_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tbx_arti_2 as text
%        str2double(get(hObject,'String')) returns contents of Tbx_arti_2 as a double


% --- Executes during object creation, after setting all properties.
function Tbx_arti_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tbx_arti_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function Tbx_trama_Callback(hObject, eventdata, handles)
% hObject    handle to Tbx_trama (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tbx_trama as text
%        str2double(get(hObject,'String')) returns contents of Tbx_trama as a double


% --- Executes during object creation, after setting all properties.
function Tbx_trama_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tbx_trama (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tbx_servo_8_Callback(hObject, eventdata, handles)
% hObject    handle to Tbx_servo_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tbx_servo_8 as text
%        str2double(get(hObject,'String')) returns contents of Tbx_servo_8 as a double


% --- Executes during object creation, after setting all properties.
function Tbx_servo_8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tbx_servo_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tbx_servo_7_Callback(hObject, eventdata, handles)
% hObject    handle to Tbx_servo_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tbx_servo_7 as text
%        str2double(get(hObject,'String')) returns contents of Tbx_servo_7 as a double


% --- Executes during object creation, after setting all properties.
function Tbx_servo_7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tbx_servo_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tbx_servo_6_Callback(hObject, eventdata, handles)
% hObject    handle to Tbx_servo_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tbx_servo_6 as text
%        str2double(get(hObject,'String')) returns contents of Tbx_servo_6 as a double


% --- Executes during object creation, after setting all properties.
function Tbx_servo_6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tbx_servo_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tbx_servo_5_Callback(hObject, eventdata, handles)
% hObject    handle to Tbx_servo_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tbx_servo_5 as text
%        str2double(get(hObject,'String')) returns contents of Tbx_servo_5 as a double


% --- Executes during object creation, after setting all properties.
function Tbx_servo_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tbx_servo_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tbx_servo_4_Callback(hObject, eventdata, handles)
% hObject    handle to Tbx_servo_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tbx_servo_4 as text
%        str2double(get(hObject,'String')) returns contents of Tbx_servo_4 as a double


% --- Executes during object creation, after setting all properties.
function Tbx_servo_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tbx_servo_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tbx_servo_3_Callback(hObject, eventdata, handles)
% hObject    handle to Tbx_servo_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tbx_servo_3 as text
%        str2double(get(hObject,'String')) returns contents of Tbx_servo_3 as a double


% --- Executes during object creation, after setting all properties.
function Tbx_servo_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tbx_servo_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tbx_servo_2_Callback(hObject, eventdata, handles)
% hObject    handle to Tbx_servo_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tbx_servo_2 as text
%        str2double(get(hObject,'String')) returns contents of Tbx_servo_2 as a double


% --- Executes during object creation, after setting all properties.
function Tbx_servo_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tbx_servo_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tbx_servo_1_Callback(hObject, eventdata, handles)
% hObject    handle to Tbx_servo_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tbx_servo_1 as text
%        str2double(get(hObject,'String')) returns contents of Tbx_servo_1 as a double


% --- Executes during object creation, after setting all properties.
function Tbx_servo_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tbx_servo_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tbx_arti_8_Callback(hObject, eventdata, handles)
% hObject    handle to Tbx_arti_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tbx_arti_8 as text
%        str2double(get(hObject,'String')) returns contents of Tbx_arti_8 as a double


% --- Executes during object creation, after setting all properties.
function Tbx_arti_8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tbx_arti_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tbx_arti_7_Callback(hObject, eventdata, handles)
% hObject    handle to Tbx_arti_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tbx_arti_7 as text
%        str2double(get(hObject,'String')) returns contents of Tbx_arti_7 as a double


% --- Executes during object creation, after setting all properties.
function Tbx_arti_7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tbx_arti_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tbx_arti_6_Callback(hObject, eventdata, handles)
% hObject    handle to Tbx_arti_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tbx_arti_6 as text
%        str2double(get(hObject,'String')) returns contents of Tbx_arti_6 as a double


% --- Executes during object creation, after setting all properties.
function Tbx_arti_6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tbx_arti_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tbx_arti_5_Callback(hObject, eventdata, handles)
% hObject    handle to Tbx_arti_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tbx_arti_5 as text
%        str2double(get(hObject,'String')) returns contents of Tbx_arti_5 as a double


% --- Executes during object creation, after setting all properties.
function Tbx_arti_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tbx_arti_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tbx_arti_4_Callback(hObject, eventdata, handles)
% hObject    handle to Tbx_arti_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tbx_arti_4 as text
%        str2double(get(hObject,'String')) returns contents of Tbx_arti_4 as a double


% --- Executes during object creation, after setting all properties.
function Tbx_arti_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tbx_arti_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tbx_arti_3_Callback(hObject, eventdata, handles)
% hObject    handle to Tbx_arti_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tbx_arti_3 as text
%        str2double(get(hObject,'String')) returns contents of Tbx_arti_3 as a double


% --- Executes during object creation, after setting all properties.
function Tbx_arti_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tbx_arti_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Bt_iniciar.
function Bt_iniciar_Callback(hObject, eventdata, handles)
%progamacion  de boton inicio
%variables definidas globales
global fase_inicial;
% global rad  ;
% global grad;
% global do;

%variables globales
global d ; % longitud
global M; % cantidad de modulos
global k;% ciclos
global angini; %angulo iicial
global fase; %fase inicial
global t;
global velocidad;
global conectar;


if conectar==1
% global puerto_serial;
dato=str2double(get(handles.Tbx_longitud, 'string'));
dato2=str2double(get(handles.Tbx_angulo_inicial, 'string'));
dato3= str2double(get(handles.Tbx_fase_inicial, 'string'));
dato4=str2double(get(handles.Tbx_modulos, 'string'));
dato5=str2double(get(handles.Tbx_ciclos, 'string'));
if dato==4
 errordlg('Ingrese un valor mayor a 4 modulos','Error')
else
if isnan(dato) || isnan(dato2)|| isnan(dato3)|| isnan(dato4)|| isnan(dato5)
errordlg('Error algún dato inválido  o vacío, solo acepta valores numéricos en el campos Longitud,Angulo inicial,Fase inicial,Modulos y Ciclos','Error')
else

%coversio a numero de las cajas de texto ingresadas por el usuario
longitud= str2double(get(handles.Tbx_longitud, 'string'));
angulo_inicial= str2double(get(handles.Tbx_angulo_inicial, 'string'));
fase_inicial= str2double(get(handles.Tbx_fase_inicial, 'string'));
modulos= str2double(get(handles.Tbx_modulos, 'string'));
k_ciclos= str2double(get(handles.Tbx_ciclos, 'string'));


%asignacion de valores a las variables globales
d=longitud;
M=modulos;
k=k_ciclos;
angini=angulo_inicial;
fase=fase_inicial;

% %GRAFICA
%  xlabel('EJE X(m)')
%  ylabel('EJE Y(m)')
%  title ('CONTROL CINEMATICO SERPIENTE CON 4 GDL')
%  grid; 

%timer
t=timer('TimerFcn',{@user_timercallback,hObject},...
                    'ExecutionMode','fixedRate',...
                    'Period',velocidad);
                
 %INICIAR FUNCION TIMER
start(t);
 MENSAJE =strcat('Serpiente caminando..') 
end
end
else
errordlg('Error no a conectado ningún puerto.','Error')
end


%FUNCION DEL TIMER
function user_timercallback(obj,event,hObject)
handles=guidata(hObject);
%VARIABLES GLOBALES
global rad  ;
%global grad;
global do;
%global l;
%variables globales
global d ; % longitud
global M; % cantidad de modulos
global k;% ciclos
global angini; %angulo iicial
global fase; %fase inicial
%global fase_inicial; 
global trama; 
global adelante_sp; 
global atras_sp; 
global puerto_serial;
global puerto;
global velocidad;
global conectar;
global sis3D;
%CALCULO DE MOVIMIENTO Y POSICIONES DE LA SERPIENTE
    for i=1:1:(M+1)
        ang(i)= angini*cos(fase*rad+(((2*pi*k)/M)*(i-1)));
        angdob(i)=-(2*angini*sin(pi*k/M)*sin(fase*rad+((2*pi*k)/M)*((i-1)+(do/d))));
        servo(i)=round(((200/18)*angdob(i))+(1500));
        
        if i==1
           x(i)= do*cos(angini*rad);
           y(i)= do*sin(angini*rad);
        elseif i==(M+1)
           x(i)= x(i-1)+do*cos(ang(i)*rad);
           y(i)= y(i-1)+do*sin(ang(i)*rad);
        else
           x(i)= x(i-1)+d*cos(ang(i)*rad);
           y(i)= y(i-1)+d*sin(ang(i)*rad);     
        end
    end
   
    if min(y)<0
       
        y = [y+abs(min(y))];
     
    else
      
        y = [y-abs(min(y))];
    
    end
    %MOSTRAR LOS VALORES OBTENIDO EN PANTALLA
    set(handles.Tbx_arti_1,'String',angdob(1));
    set(handles.Tbx_arti_2,'String',angdob(2));
    set(handles.Tbx_arti_3,'String',angdob(3));
    set(handles.Tbx_arti_4,'String',angdob(4));
    set(handles.Tbx_arti_5,'String',angdob(5));
    set(handles.Tbx_arti_6,'String',angdob(6));
%     set(handles.Tbx_arti_7,'String',angdob(7));
%     set(handles.Tbx_arti_8,'String',angdob(8));
    set(handles.Tbx_servo_1,'String',servo(1));
    set(handles.Tbx_servo_2,'String',servo(2));
    set(handles.Tbx_servo_3,'String',servo(3));
    set(handles.Tbx_servo_4,'String',servo(4));
    set(handles.Tbx_servo_5,'String',servo(5));
    set(handles.Tbx_servo_6,'String',servo(6));
%     set(handles.Tbx_servo_7,'String',servo(7));
%     set(handles.Tbx_servo_8,'String',servo(8));
    
    %ARMAR LA TRAMA
    a='<';
    c='>';
    cero='0';
   
 
    s1= get(handles.Tbx_servo_1, 'string');
    if servo(1)<1000
    s1 = [cero s1] 
    end
    s2= get(handles.Tbx_servo_2, 'string');
     if servo(2)<1000
    s2 = [cero s2] ;
    end
    s3= get(handles.Tbx_servo_3, 'string');
     if servo(3)<1000
    s3 = [cero s3] ;
    end
    s4= get(handles.Tbx_servo_4, 'string');
     if servo(4)<1000
    s4 = [cero s4] ;
    end
    s5= get(handles.Tbx_servo_5, 'string');
     if servo(5)<1000
    s5 = [cero s5] ;
    end
    s6= get(handles.Tbx_servo_6, 'string');
    if servo(6)<1000
    s6 = [cero s6]; 
    end
    trama =strcat(a,s1,s2,s3,s4,s5,s6,c) 
    
    %Actualizamos VRML
    Grado_0=vrnode(sis3D,'SNAKE');
    Grado_0.translation=[0 10 0];
%     if miny < 0
%         Grado_0.translation=[0 (miny*5) 0];
%     else
%         Grado_0.translation=[0 -(miny*5) 0];
%     end
    Grado_0.rotation=[0 0 1 ((ang(2)-angdob(1))*rad)];
    Grado_1=vrnode(sis3D,'ARTICULACION1');
    Grado_1.rotation=[0 0 1 (angdob(1)*rad)];
    Grado_2=vrnode(sis3D,'ARTICULACION2');
    Grado_2.rotation=[0 0 1 (angdob(2)*rad)];
    Grado_3=vrnode(sis3D,'ARTICULACION3');
    Grado_3.rotation=[0 0 1 (angdob(3)*rad)];
    Grado_4=vrnode(sis3D,'ARTICULACION4');
    Grado_4.rotation=[0 0 1 (angdob(4)*rad)];
    Grado_5=vrnode(sis3D,'ARTICULACION5');
    Grado_5.rotation=[0 0 1 (angdob(5)*rad)];
    Grado_6=vrnode(sis3D,'ARTICULACION6');
    Grado_6.rotation=[0 0 1 (angdob(6)*rad)];
    Grado_6=vrnode(sis3D,'ARTICULACION7');
    Grado_6.rotation=[0 0 1 (angdob(7)*rad)];
   
    vrdrawnow;
    
    %SE ENVIA LA TRAMA POR EL COM EXISTENTE
    if conectar ==1
    if velocidad >0.010
    instrfind({'port'},{puerto});
    fprintf(puerto_serial,'%s',trama);
    instrfind({'port'},{puerto});
    MENSAJE =strcat('enviando normal la trama') 
    end
    
    if velocidad <0.001
        mensaje='Volocidades menores que 0.001, no enviarán datos por el puerto serial. '
        set(handles.Lbl_mensaje,'String',mensaje);
   
    else
      mensaje='Enviando datos al puerto serial... '
      set(handles.Lbl_mensaje,'String',mensaje);
     
    end
    else
     mensaje='Solo esta graficando..., elija un COM y dele conectar para enviar movimientos'
     set(handles.Lbl_mensaje,'String',mensaje);
    end

    %MOVIMIENTO DE LA SERPIENTE DEPENDIENDO DE LA FASE
     if adelante_sp==1
       
      fase= fase+10;
     end
     if atras_sp==1
       
      fase= fase-10;
    end
  
    
    %GRAFICANDO LOS PUNTOS
    plot(handles.pantalla,x,y,'b','marker','o','LineWidth',3,'MarkerEdgeColor','r','MarkerfaceColor','r','MarkerSize',5);
    %x
    %y
    clear x
    clear y
    


   
   
  
   
    
% --- Executes on button press in Btn_parar.
function Btn_parar_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_parar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global t;
stop(t);
 MENSAJE =strcat('Serpiente detenida...') 

% --- Executes on selection change in Cbo_puerto.
function Cbo_puerto_Callback(hObject, eventdata, handles)
% hObject    handle to Cbo_puerto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global puerto
% Hints: contents = cellstr(get(hObject,'String')) returns Cbo_puerto contents as cell array
%puerto= contents{get(hObject,'Value')} %returns selected item from Cbo_puerto


% --- Executes during object creation, after setting all properties.
function Cbo_puerto_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Cbo_puerto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Btn_conectar.
function Btn_conectar_Callback(hObject, eventdata, handles)

%conexion serial con arduino
global puerto
global conectar;
%SE RECOJE EL DATO
numero= get(handles.Cbo_puerto, 'Value');
com='COM';
puerto = [com num2str(numero)] ;
%SE CONFIGURA LA CONEXION
global puerto_serial
delete(instrfind({'port'},{puerto}));
puerto_serial=serial(puerto);
puerto_serial.BaudRate=9600;
warning('off','MATLAB:serial:fscanf:unsuccessfulRead');
% SE HABRE EL PUERTO
 fopen(puerto_serial);
 conectar=1;
 MENSAJE =strcat('Conexion correcta , ya se pueden enviar datos') 
 set(handles.foto_conexion, 'BackgroundColor', 'g');


% --- Executes on button press in Btn_desconectar.
function Btn_desconectar_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_desconectar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global puerto_serial
global conectar;
%SE CIERRA LA CONEXION
fclose(puerto_serial);
delete(puerto_serial);
conectar=0;
MENSAJE =strcat('Conexion cerrada') 
 set(handles.foto_conexion, 'BackgroundColor', 'r');


function Tbx_fase_inicial_Callback(hObject, eventdata, handles)
% hObject    handle to Tbx_fase_inicial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tbx_fase_inicial as text
%        str2double(get(hObject,'String')) returns contents of Tbx_fase_inicial as a double


% --- Executes during object creation, after setting all properties.
function Tbx_fase_inicial_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tbx_fase_inicial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tbx_modulos_Callback(hObject, eventdata, handles)
global M;
dato=str2double(get(hObject,'String'));
if dato==4
 errordlg('Ingrese un valor mayor a 4 modulos','Error')
else
if isnan(dato)
errordlg('Error algún dato inválido  o vacío, solo acepta valores numéricos','Error')
else
M=str2double(get(hObject,'String')); %returns contents of Tbx_modulos as a double 
end
end

    




% --- Executes during object creation, after setting all properties.
function Tbx_modulos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tbx_modulos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tbx_ciclos_Callback(hObject, eventdata, handles)
% hObject    handle to Tbx_ciclos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tbx_ciclos as text
%        str2double(get(hObject,'String')) returns contents of Tbx_ciclos as a double


% --- Executes during object creation, after setting all properties.
function Tbx_ciclos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tbx_ciclos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tbx_dato_Callback(hObject, eventdata, handles)
% hObject    handle to Tbx_dato (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tbx_dato as text
%        str2double(get(hObject,'String')) returns contents of Tbx_dato as a double


% --- Executes during object creation, after setting all properties.
function Tbx_dato_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tbx_dato (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Btn_enviar.
function Btn_enviar_Callback(hObject, eventdata, handles)
global puerto_serial;
global puerto;
%SE TOMA LA TRAMA DE DATOS
trama= get(handles.Tbx_trama, 'string')

 %SE ENVIA LA TRAMA POR EL COM EXISTENTE
instrfind({'port'},{puerto})
fprintf(puerto_serial,'%s',trama)
instrfind({'port'},{puerto})






function Tbx_puerto_Callback(hObject, eventdata, handles)
% hObject    handle to Tbx_puerto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tbx_puerto as text
%        str2double(get(hObject,'String')) returns contents of Tbx_puerto as a double


% --- Executes during object creation, after setting all properties.
function Tbx_puerto_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tbx_puerto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on mouse press over axes background.
function pantalla_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pantalla (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pantalla_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pantalla (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate pantalla


% --- Executes on button press in Btn_atras.
function Btn_atras_Callback(hObject, eventdata, handles)
global atras_sp;
global adelante_sp;

adelante_sp=0;
atras_sp=1;
MENSAJE =strcat('Serpiente caminando hacia atras..') 

% --- Executes on button press in Btn_adelante.
function Btn_adelante_Callback(hObject, eventdata, handles)
global atras_sp;
global adelante_sp;

adelante_sp=1;
atras_sp=0;
 MENSAJE =strcat('Serpiente caminando hacia adelante..') 


% --- Executes on button press in Btn_borrar.
function Btn_borrar_Callback(hObject, eventdata, handles)
clc


% --- Executes on button press in Btn_segir.
function Btn_segir_Callback(hObject, eventdata, handles)
global t;
 %INICIAR FUNCION TIMER
start(t);
 MENSAJE =strcat('Serpiente caminando..') 


% --- Executes on button press in Btn_graficar.
function Btn_graficar_Callback(hObject, eventdata, handles)
%progamacion  de boton GRAFICAR
%variables definidas globales
global fase_inicial;

%variables globales
global d ; % longitud
global M; % cantidad de modulos
global k;% ciclos
global angini; %angulo iicial
global fase; %fase inicial
global t;
global velocidad;
global conectar;

conectar=0;
% global puerto_serial;
dato=str2double(get(handles.Tbx_longitud, 'string'));
dato2=str2double(get(handles.Tbx_angulo_inicial, 'string'));
dato3= str2double(get(handles.Tbx_fase_inicial, 'string'));
dato4=str2double(get(handles.Tbx_modulos, 'string'));
dato5=str2double(get(handles.Tbx_ciclos, 'string'));
if dato==4
 errordlg('Ingrese un valor mayor a 4 modulos','Error')
else
if isnan(dato) || isnan(dato2)|| isnan(dato3)|| isnan(dato4)|| isnan(dato5)
errordlg('Error algún dato inválido  o vacío, solo acepta valores numéricos en el campos Longitud,Angulo inicial,Fase inicial,Modulos y Ciclos','Error')
else

%coversio a numero de las cajas de texto ingresadas por el usuario
longitud= str2double(get(handles.Tbx_longitud, 'string'));
angulo_inicial= str2double(get(handles.Tbx_angulo_inicial, 'string'));
fase_inicial= str2double(get(handles.Tbx_fase_inicial, 'string'));
modulos= str2double(get(handles.Tbx_modulos, 'string'));
k_ciclos= str2double(get(handles.Tbx_ciclos, 'string'));


%asignacion de valores a las variables globales
d=longitud;
M=modulos;
k=k_ciclos;
angini=angulo_inicial;
fase=fase_inicial;

%timer
t=timer('TimerFcn',{@user_timercallback,hObject},...
                    'ExecutionMode','fixedRate',...
                    'Period',velocidad);
                
 %INICIAR FUNCION TIMER
start(t);
MENSAJE =strcat('Serpiente caminando..') 
end
end


% --- Executes during object creation, after setting all properties.
function foto_conexion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to foto_conexion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in BTN_3D.
function BTN_3D_Callback(hObject, eventdata, handles)
global sis3D
%Sistema 3D
close(sis3D);
sis3D=vrworld('SNAKE2.wrl','new');
open(sis3D);
fig=vrfigure(sis3D);%cargando Mundo VRML
set(fig,'Viewpoint','Superior');
set(fig,'Viewpoint','Atras');
set(fig,'Viewpoint','Frente');
set(fig,'Name','SNAKE ROBOT')
set(fig,'ZoomFactor',1);
set(fig,'NavMode','Examine');
   
