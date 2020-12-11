function varargout = Brain_GUI(varargin)
% BRAIN_GUI MATLAB code for Brain_GUI.fig
%      BRAIN_GUI, by itself, creates a new BRAIN_GUI or raises the existing
%      singleton*.
%
%      H = BRAIN_GUI returns the handle to a new BRAIN_GUI or the handle to
%      the existing singleton*.
%
%      BRAIN_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BRAIN_GUI.M with the given input arguments.
%
%      BRAIN_GUI('Property','Value',...) creates a new BRAIN_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Brain_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Brain_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Brain_GUI

% Last Modified by GUIDE v2.5 01-Dec-2020 00:31:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Brain_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Brain_GUI_OutputFcn, ...
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


% --- Executes just before Brain_GUI is made visible.
function Brain_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Brain_GUI (see VARARGIN)

% Choose default command line output for Brain_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Brain_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Brain_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Load_Image.
function Load_Image_Callback(hObject, eventdata, handles)
% hObject    handle to Load_Image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global im im2
[path, user_cancel] = imgetfile();
if user_cancel
    msgbox(sprintf('Invalid Selection'),'Error','Error');
    return
end
im = imread(path);
im = im2double(im);
im2 = im;
axes(handles.axes1);
imshow(im)
title('\fontsize(18)\color[rgb]{0.635, 0.078, 0.184} Patient''s Brain')

% --- Executes on button press in Detect.
function Detect_Callback(hObject, eventdata, handles)
% hObject    handle to Detect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im

axes(handles.axes2);
bw = im2bw(im,0.7);
label = bwlabel(bw);
stats=regionprops(label,'Solidity','Area');
density=[stats.Solidity];
area=[stats.Area];
high_dense_area=density>0.5;
max_area=max(area(high_dense_area));
tumor_label=find(area==max_area);
tumor=ismember(label,tumor_label);
se=strel('square',5);
tumor=imdilate(tumor,se);

B = bwboundaries(tumor,'noholes');

imshow(im);
hold on
for i=1:length(B)
    plot(B{i}(:,2),B{1}(:,1), 'y' ,'linewidth',1.75);
    
    
    
end

title('\fontsize(18)\color[rgb]{0.635, 0.078, 0.184} Detected Tumor');
hold off;


% --------------------------------------------------------------------
function about_Callback(hObject, eventdata, handles)
% hObject    handle to about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function author_Callback(hObject, eventdata, handles)
% hObject    handle to author (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox(sprintf('Name: Sanskruti\nRoll No:TEETA164'),'Author');
