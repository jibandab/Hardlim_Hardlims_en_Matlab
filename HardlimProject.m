function varargout = HardlimProject(varargin)
%Codigo de la interfaz
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HardlimProject_OpeningFcn, ...
                   'gui_OutputFcn',  @HardlimProject_OutputFcn, ...
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



function HardlimProject_OpeningFcn(hObject, eventdata, handles, varargin)
%Codigo de la interfaz
handles.output = hObject;
guidata(hObject, handles);


%Centrar interfaz en la pantalla
scrsz=get(0,'ScreenSize');
pos_act=get(gcf,'Position');
xr=scrsz(3)-pos_act(3);
xp=round(xr/2);
yr=scrsz(4)-pos_act(4);
yp=round(yr/2);
set(gcf,'Position',[xp yp pos_act(3) pos_act(4)]);

%Desactivacion de componentes iniciales
set(handles.txt_P,'Enable','off');
set(handles.txt_T,'Enable','off');
set(handles.lbl_pum_entrenamiento,'Enable','off');
set(handles.pum_entrenamiento,'Enable','off');
set(handles.lbl_txt_capas,'Enable','off');
set(handles.txt_capas,'Enable','off');
set(handles.btn_capas,'Enable','off');
set(handles.btn_ejecutar,'Enable','off');
set(handles.btn_red_neuronal,'Enable','off');

%Guardar entrenamiento por defecto
handles.entrenam_guardado = 'traingd';
guidata(hObject,handles);


function varargout = HardlimProject_OutputFcn(hObject, eventdata, handles) 
%Codigo de la interfaz
varargout{1} = handles.output;




function pum_Func_Callback(hObject, eventdata, handles)

%Se obtine el valor del componete poupmenu 
%denominado pum_Func
valor=get(handles.pum_Func,'Value');

switch valor
case 1
    %La priemra opcion esta en blanco, 
    %mantiene componentes desactivados
    set(handles.txt_P,'Enable','off');
    set(handles.txt_T,'Enable','off');
    set(handles.lbl_pum_entrenamiento,'Enable','off');
    set(handles.pum_entrenamiento,'Enable','off');
    set(handles.lbl_txt_capas,'Enable','off');
    set(handles.txt_capas,'Enable','off');
    set(handles.btn_capas,'Enable','off');
    set(handles.btn_ejecutar,'Enable','off');
    set(handles.btn_red_neuronal,'Enable','off');

case 2
    %Activacion de todos los componentes 
    set(handles.txt_P,'Enable','on');
    set(handles.txt_T,'Enable','on');
    set(handles.lbl_pum_entrenamiento,'Enable','on');
    set(handles.pum_entrenamiento,'Enable','on');
    set(handles.lbl_txt_capas,'Enable','on');
    set(handles.txt_capas,'Enable','on');
    set(handles.btn_capas,'Enable','on');

    %El boton graficar y ver red neuronal se
    %mantienen desactivados
    set(handles.btn_ejecutar,'Enable','off');
    set(handles.btn_red_neuronal,'Enable','off');

    %En caso de seleccionar un nuevo tipo de 
    %funcion se borra el campo de capas para que 
    %sean ingresadas nuevamente
    set(handles.txt_capas,'String','');

    %Se guarda el nombre de la funcion 'hardlim'
    %en func_activ_guardada para ser utilizada luego
    handles.func_activ_guardada = 'hardlim';
    guidata(hObject,handles);



case 3
    %Activacion de todos los componentes 
    set(handles.txt_P,'Enable','on');
    set(handles.txt_T,'Enable','on');
    set(handles.lbl_pum_entrenamiento,'Enable','on');
    set(handles.pum_entrenamiento,'Enable','on');
    set(handles.lbl_txt_capas,'Enable','on');
    set(handles.txt_capas,'Enable','on');
    set(handles.btn_capas,'Enable','on');

    %El boton graficar y ver red neuronal se
    %mantienen desactivados
    set(handles.btn_ejecutar,'Enable','off');
    set(handles.btn_red_neuronal,'Enable','off');

    %En caso de seleccionar un nuevo tipo de 
    %funcion se borra el campo de capas para que 
    %sean ingresadas nuevamente
    set(handles.txt_capas,'String','');

    %Se guarda el nombre de la funcion 'hardlims' 
    %en la misma variable func_activ_guardada 
    %para ser utilizada luego
    handles.func_activ_guardada = 'hardlims';
    guidata(hObject,handles);

end



function pum_entrenamiento_Callback(hObject, eventdata, handles)
%Se obtiene el valor del componente popupmenu 
%denominado pum_entrenamiento
valor_entrenam = get(handles.pum_entrenamiento,'Value');

switch valor_entrenam
    case 1
       %Guarda valor 'traingd' en entrenam_guardado
       handles.entrenam_guardado = 'traingd';
       guidata(hObject,handles);
    case 2
       %Guarda valor 'raingdm' en entrenam_guardado
       handles.entrenam_guardado = 'traingdm';
       guidata(hObject,handles);
    case 3
       %Guarda valor 'traingdx' en entrenam_guardado
       handles.entrenam_guardado = 'traingdx';
       guidata(hObject,handles);
end



function btn_capas_Callback(hObject, eventdata, handles)

%Obtenemos el numero de capas ingresadas por el usuario 
%y se lo transforma a numerico
temp_1 = get(handles.txt_capas,'String');
temp_2 = str2num(temp_1);

%Entrada del numero de neuronas por capa, Se utiliza una matriz
vector_capas=[];

%La funcion que tendra cada capa, igual numero de capas
%y de funciones. Se utiliza un array
vector_func_por_capa={};

%Se recupera la funcion de activacion seleccionada
% por el usuario
funcion_recuperada = handles.func_activ_guardada;

for n=1:1:temp_2
    
    %Mediante un inputdlg se ingresa el numero de 
    %neuronas para cada capa
    texto_1='Numero de neuronas para la capa ';
    texto_2=num2str(n);
    texto_completo = [texto_1 texto_2];
    prompt = {texto_completo};
    dlg_title = 'Numero de neuronas por capa';
    num_lines = 1;
    def = {'1'};
    answer = inputdlg(prompt,dlg_title,num_lines,def);
    
    %Se crea el vector con las capas y la cantidad de 
    %neuronas para cada capa
    vector_capas=[vector_capas str2num(answer{1,1})];
    
    %Se crea el array con el numero de funciones necesarias
    vector_func_por_capa(n)={funcion_recuperada};
end

%Se guardan los resultados para integrarlos en la funcion newff
handles.num_capas = vector_capas;
guidata(hObject,handles);

handles.vector_func_por_capa_guardada = vector_func_por_capa;
guidata(hObject,handles);

%Se activa el boton para ejecutar
set(handles.btn_ejecutar,'Enable','on');
set(handles.btn_red_neuronal,'Enable','off');
 

function btn_ejecutar_Callback(hObject, eventdata, handles)

valor = get(handles.txt_capas,'String');
valor = str2double(valor)

%verificacion para asegurar que se 
%hayan ingresado las capas

if ~isnan(valor)

    %Se obtienen los valores de las entradas
    %transformando de cadena a numero para realizar 
    %operaciones con los mismos
    P=str2num(get(handles.txt_P,'String'));
    T=str2num(get(handles.txt_T,'String'));


    %De igual manera con el entrenamiento
    entrenam_recuperado = handles.entrenam_guardado;

    %Recuperar las funciones para cada una de las capas. 
    %Cada capa tiene una funcion es decir si existen 5 capas
    %entonces existiran 5 funciones hardlim o hardlims para cada
    %capa de la red
    func_por_capa = handles.vector_func_por_capa_guardada;

    %Recuperar numero de capas con sus neuronas
    capas_y_neuronas = handles.num_capas;

    %Creacion de la red neuronal utilizando neff
    net = newff(minmax(P),capas_y_neuronas,func_por_capa,entrenam_recuperado);
    net.trainParam.epoch=200;
    %pesos
    net.IW(1);
    
    %bias
    net.b(1);
 
    
    %simulacion de la red
    Y = sim(net,P);   
    %Grafica
    plot(handles.axis_grafica,P,T,P,Y,'o');
    
    %Se guarda el estado actual de la red
    %para uso posterior
    handles.net_guardada = net;
    guidata(hObject,handles);

    %se activa el boton presentar red neuronal
    set(handles.btn_red_neuronal,'Enable','on');
else
    %Mensaje de error en caso de no ingresar capas
    errordlg('Debe ingresar un numero de capas válido para la red');
end


function btn_red_neuronal_Callback(hObject, eventdata, handles)

valor = get(handles.txt_capas,'String');
valor = str2double(valor)

%verificacion para asegurar que se 
%hayan ingresado las capas
if ~isnan(valor)

    %Se recupera el estado de la red y se presenta la 
    %vista con la red neuronal y sus componentes
    net_recuperada = handles.net_guardada;
    view(net_recuperada);
    
else
    %Mensaje de error en caso de no ingresar capas
    errordlg('Debe ingresar un numero de capas válido para la red');
end





function pum_Func_CreateFcn(hObject, eventdata, handles)
%Codigo de la interfaz
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txt_P_CreateFcn(hObject, eventdata, handles)
%Codigo de la interfaz
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txt_T_CreateFcn(hObject, eventdata, handles)
%Codigo de la interfaz
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pum_entrenamiento_CreateFcn(hObject, eventdata, handles)
%Codigo de la interfaz
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txt_muestra_CreateFcn(hObject, eventdata, handles)
%Codigo de la interfaz
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txt_train_CreateFcn(hObject, eventdata, handles)
%Codigo de la interfaz
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txt_vector_CreateFcn(hObject, ~, handles)
%Codigo de la interfaz
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txt_capas_CreateFcn(hObject, eventdata, handles)
%Codigo de la interfaz
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txt_prueba_capas_CreateFcn(hObject, eventdata, handles)
%Codigo de la interfaz
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function frame_hardlims_CreateFcn(hObject, eventdata, handles)

function txt_P_Callback(hObject, eventdata, handles)

function txt_T_Callback(hObject, eventdata, handles)

function txt_muestra_Callback(hObject, eventdata, handles)

function txt_train_Callback(hObject, eventdata, handles)

function txt_vector_Callback(hObject, eventdata, handles)

function txt_capas_Callback(hObject, eventdata, handles)

function txt_prueba_capas_Callback(hObject, eventdata, handles)



function btn_limpiar_Callback(hObject, eventdata, handles)
set(handles.txt_P,'String','')
set(handles.txt_T,'String','')
set(handles.btn_ejecutar,'Enable','off');
set(handles.btn_red_neuronal,'Enable','off');


function btn_limpiar_capas_Callback(hObject, eventdata, handles)
set(handles.txt_capas,'String','')
set(handles.btn_ejecutar,'Enable','off');
set(handles.btn_red_neuronal,'Enable','off');
