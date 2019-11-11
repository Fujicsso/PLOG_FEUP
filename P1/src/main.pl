:- include('menu.pl').
:- include('display.pl').
:- include('utils.pl').
:- include('playerPlay.pl').
:- use_module(library(clpfd)).
:- use_module(library(lists)).
% :- use_module(library(between)).
:- use_module(library(aggregate)).
:- use_module(library(random)).
:- use_module(library(system)).

:- dynamic state/3.

play:- mainMenu.
