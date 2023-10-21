%%
%% this is file `gost7184.bst',
%% generated with the docstrip utility.
%%
%% ----------------------------------------
%% *** GOST 7.1-84 (1986-01-01) ***
%%
%% This bibliography style attempts
%% to format bibliography according to
%% GOST 7.1-84 and GOST 7.80-00
%%
%% For the Ukrainian|Russian bibliographic entries
%% you need to create field
%% language = {ukrainian|russian}.
%% Default language is English.
%% Field numpages for books must contain number of pages.
%% Optional field url will format url (using hyperref, if loaded).
%% 
%%---------------------------------------------------------------------
%% This bibliography style file requires a file named gost7184.sty
%%   containing the definitions of word commands like \bbleditor, etc.
%% This is a numerical citation style, and as such is standard LaTeX.
%% It requires no extra package to interface to the main text.
%% The form of the \bibitem entries is
%%   \bibitem{key}...
%% Usage of \cite is as follows:
%%   \cite{key} ==>>          [#]
%%   \cite[chap. 2]{key} ==>> [#, chap. 2]
%% where # is a number determined by the ordering in the reference list.
%% The order in the reference list is alphabetical by authors.
%%---------------------------------------------------------------------


ENTRY
  { address
    annote
    author
    booktitle
    bookauthor
    chapter
    comment
    compiler
    edition
    editor
    howpublished
    institution
    isbn
    issn
    issue
    journal
    key
    language
    booklanguage
    month
    note
    number
    organization
    pages
    numpages
    publisher
    school
    series
    title
    type
    url
    volume
    year
    translit
    doi
  }
  {}
  { label }

INTEGERS { output.state before.all mid.sentence after.sentence after.block
after.dblslash after.slash after.column after.semicolumn}

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
  #4 'after.dblslash :=
  #5 'after.slash :=
  #6 'after.column :=
  #7 'after.semicolumn :=
}

STRINGS { s t }

% %%%--
% FUNCTION {block.delim}
% {
%         { add.period$ write$
% %          newline$
% %           "\newblock " write$
%           "~--- " write$
%         }
% }
% %%%

%FUNCTION {output.nonnull}
%{ 's :=
%  output.state mid.sentence =
%  { " " * write$ }  
%%     { ", " * write$ }
%    { output.state after.block =
%        { add.period$ write$
%%          newline$
%%           "\newblock " write$
%          "~--- " write$
%        }
%        { output.state before.all =
%            'write$
%            { add.period$ " " * write$ }
%          if$
%        }
%      if$
%      mid.sentence 'output.state :=
%    }
%  if$
%  s
%}

FUNCTION {showstack}
{"STACK================================================================"
top$
stack$
"ENDSTACK============================================================="
top$
}


FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block =
        { 
          add.period$ write$
%          " " quote$ "--- " * *  write$
%          newline$
%          "\newblock " write$
          "~--- " write$
        }
        { output.state before.all =
            'write$
            { output.state after.dblslash =
                { "~/\!/ " * write$ }
                { output.state after.slash =
                    { "~/ " * write$ }
                    { output.state after.column =
                       { ": " * write$ }
                       { output.state after.semicolumn =
                           { "; " * write$ }
                   { add.period$ " " * write$ }
                     if$
    }
                    if$
                  }
                  if$
                }
              if$
            }
          if$
        }
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}


FUNCTION {output}
{ 
  duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}

FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}

FUNCTION {begin.selectlanguage}
{
%  duplicate$ empty$
%  'pop$
%  { 
    language empty$
      'skip$
      {"\begin{otherlanguage*}{" language * "}" * write$}
%      {"{\selectlanguage{" language * "}" * write$}
    if$
%  } 
%  if$
}

FUNCTION {end.selectlanguage}
{
%  duplicate$ empty$
%  'pop$
%  { 
    language empty$
      'skip$
      {newline$ "\end{otherlanguage*}" write$}
%      {"}%selectlanguage" write$}
    if$
%  } 
%  if$
}


FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
  if$
}

FUNCTION {new.dblslash}
{ output.state before.all =
    'skip$
    { after.dblslash 'output.state := }
  if$
}

FUNCTION {new.slash}
{ output.state before.all =
    'skip$
    { after.slash 'output.state := }
  if$
}

FUNCTION {new.column}
{ output.state before.all =
    'skip$
    { after.column 'output.state := }
  if$
}

FUNCTION {new.semicolumn}
{ output.state before.all =
    'skip$
    { after.semicolumn 'output.state := }
  if$
}

FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
        'skip$
        { after.sentence 'output.state := }
      if$
    }
  if$
}

FUNCTION {add.blank}
{  " " * before.all 'output.state :=
}

FUNCTION {date.block}
{
  new.block
}

FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}

FUNCTION {new.block.checka}
{ empty$
    'skip$
    'new.block
  if$
}

FUNCTION {new.block.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.block
  if$
}

FUNCTION {new.sentence.checka}
{ empty$
    'skip$
    'new.sentence
  if$
}

FUNCTION {new.sentence.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.sentence
  if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "\emph{" swap$ * "}" * }
  if$
}

FUNCTION {bolden}
{ duplicate$ empty$
    { pop$ "" }
    { "\textbf{" swap$ * "}" * }
  if$
}

FUNCTION {bib.name.font}
{ duplicate$ empty$
  { pop$ "" }
  { "\bibnamefont{" swap$ * "}" * }
  if$
}

FUNCTION {bib.fname.font}
{ bib.name.font }

FUNCTION {capitalize}
{ "\capitalize" swap$ * }

FUNCTION {space.word}
{ " " swap$ * " " * }

% Here are the language-specific definitions for explicit words.
% Each function has a name bbl.xxx where xxx is the English word.
% The BABEL language selection is made here; definitions in babelbst.tex.
FUNCTION {bbl.and}
{ "\bbland{}"}

FUNCTION {bbl.etal}
{ "\bbletal{}."}

FUNCTION {bbl.editors}
{ "\bbleds{}" }

FUNCTION {bbl.editor}
{ "\bbled{}" }

FUNCTION {bbl.edby}
{ "\bbledby{}" }

FUNCTION {bbl.edition}
{ "\bbledn{}" }

FUNCTION {bbl.volume}
{ "\bblvol{}" }

FUNCTION {bbl.issue}
{ "\bblissue{}" }

FUNCTION {bbl.issue.first}
{ "\bblissuefirst{}" }

FUNCTION {bbl.of}
{ "\bblof{}" }

FUNCTION {bbl.number}
{ "\bblno{}" }

FUNCTION {bbl.number.first}
{ "\bblnofirst{}" }

FUNCTION {bbl.nr}
{ "\bblno{}" }

FUNCTION {bbl.in}
{ "\bblin{}" }

FUNCTION {bbl.pages}
{ "\bblpp{}" }

FUNCTION {bbl.page}
{ "\bblp{}" }

FUNCTION {bbl.numpages}
{ "\bblnump{}" }

FUNCTION {bbl.chapter}
{ "\bblchap{}" }

FUNCTION {bbl.techrep}
{ "\bbltechrep{}" }

FUNCTION {bbl.mthesis}
{ "\bblmthesis{}" }

FUNCTION {bbl.phdthesis}
{ "\bblphdthesis{}" }

FUNCTION {bbl.cmplr}
{ "\bblcompiler{}" }

FUNCTION {jan} {"\bbljan{}" }

FUNCTION {feb} {"\bblfeb{}" }

FUNCTION {mar} {"\bblmar{}" }

FUNCTION {apr} {"\bblapr{}" }

FUNCTION {may} {"\bblmay{}" }

FUNCTION {jun} {"\bbljun{}" }

FUNCTION {jul} {"\bbljul{}" }

FUNCTION {aug} {"\bblaug{}" }

FUNCTION {sep} {"\bblsep{}" }

FUNCTION {oct} {"\bbloct{}" }

FUNCTION {nov} {"\bblnov{}" }

FUNCTION {dec} {"\bbldec{}" }

%-------------------------------------------------------------------
% Begin module:
% \ProvidesFile{physjour.mbs}[1999/02/24 2.0d (PWD)]
MACRO {aa}{"Astronomy and Astrophysics"}
MACRO {aasup}{"Astronomy and Astrophysics, Supplement Series"}
MACRO {aph} {"Acta Physica"}
MACRO {advp} {"Advances in Physics"}
MACRO {ajp} {"American Journal of Physics"}
MACRO {ajm} {"American Journal of Mathematics"}
MACRO {amsci} {"American Scientist"}
MACRO {anofd} {"Annals of Fluid Dynamics"}
MACRO {am} {"Annals of Mathematics"}
MACRO {ap} {"Annals of Physics"}
MACRO {adp} {"Annalen der Physik"}
MACRO {ao} {"Applied Optics"}
MACRO {apl} {"Applied Physics Letters"}
MACRO {app} {"Astroparticle Physics"}
MACRO {apj} {"Astrophysical Journal"}
MACRO {apjsup} {"Astrophysical Journal, Supplement Series"}
MACRO {baps} {"Bulletin of the American Physical Society"}
MACRO {cmp} {"Communications in Mathematical Physics"}
MACRO {cpam} {"Communications on Pure and Applied Mathematics"}
MACRO {cppcf} {"Comments on Plasma Physics and Controlled Fusion"}
MACRO {cpc} {"Computer Physics Communications"}
MACRO {cqg} {"Classical and Quantum Gravity"}
MACRO {cra} {"Comptes Rendus des S{\'e}ances de l'Acad{\'e}mie des Sciences A"}
MACRO {fed} {"Fusion Engineering and Design"}
MACRO {ft} {"Fusion Technology"}
MACRO {grg} {"General Relativity and Gravitation"}
MACRO {ieeens} {"IEEE Transactions on Nuclear Science"}
MACRO {ieeeps} {"IEEE Transactions on Plasma Science"}
MACRO {ijimw} {"International Journal of Infrared and Millimeter Waves"}
MACRO {ip} {"Infrared Physics"}
MACRO {irp} {"Infrared Physics"}
MACRO {jap} {"Journal of Applied Physics"}
MACRO {jasa} {"Journal of the Acoustical Society of America"}
MACRO {jcp} {"Journal of Computational Physics"}
MACRO {jetp} {"Soviet Physics--JETP"}
MACRO {jfe} {"Journal of Fusion Energy"}
MACRO {jfm} {"Journal of Fluid Mechanics"}
MACRO {jmp} {"Journal of Mathematical Physics"}
MACRO {jne} {"Journal of Nuclear Energy"}
MACRO {jnec} {"Journal of Nuclear Energy, Part C: Plasma Physics, Accelerators, Thermonuclear Research"}
MACRO {jnm} {"Journal of Nuclear Materials"}
MACRO {jpc} {"Journal of Physical Chemistry"}
MACRO {jpp} {"Journal of Plasma Physics"}
MACRO {jpsj} {"Journal of the Physical Society of Japan"}
MACRO {jsi} {"Journal of Scientific Instruments"}
MACRO {jvst} {"Journal of Vacuum Science and Technology"}
MACRO {nat} {"Nature"}
MACRO {nature} {"Nature"}
MACRO {nedf} {"Nuclear Engineering and Design/Fusion"}
MACRO {nf} {"Nuclear Fusion"}
MACRO {nim} {"Nuclear Instruments and Methods"}
MACRO {nimpr} {"Nuclear Instruments and Methods in Physics Research"}
MACRO {np} {"Nuclear Physics"}
MACRO {npb} {"Nuclear Physics B"}
MACRO {nt/f} {"Nuclear Technology/Fusion"}
MACRO {npbpc} {"Nuclear Physics B (Proceedings Suppluments)"}
MACRO {inc} {"Il Nuovo Cimento"}
MACRO {nc} {"Nuovo Cimento"}
MACRO {pf} {"Physics of Fluids"}
MACRO {pfa} {"Physics of Fluids A: Fluid Dynamics"}
MACRO {pfb} {"Physics of Fluids B: Plasma Physics"}
MACRO {pl} {"Physics Letters"}
MACRO {pla} {"Physics Letters A"}
MACRO {plb} {"Physics Letters B"}
MACRO {prep} {"Physics Reports"}
MACRO {pnas} {"Proceedings of the National Academy of Sciences of the USA"}
MACRO {pp} {"Physics of Plasmas"}
MACRO {ppcf} {"Plasma Physics and Controlled Fusion"}
MACRO {phitrsl} {"Philosophical Transactions of the Royal Society of London"}
MACRO {prl} {"Physical Review Letters"}
MACRO {pr} {"Physical Review"}
MACRO {physrev} {"Physical Review"}
MACRO {pra} {"Physical Review A"}
MACRO {prb} {"Physical Review B"}
MACRO {prc} {"Physical Review C"}
MACRO {prd} {"Physical Review D"}
MACRO {pre} {"Physical Review E"}
MACRO {ps} {"Physica Scripta"}
MACRO {procrsl} {"Proceedings of the Royal Society of London"}
MACRO {rmp} {"Reviews of Modern Physics"}
MACRO {rsi} {"Review of Scientific Instruments"}
MACRO {science} {"Science"}
MACRO {sciam} {"Scientific American"}
MACRO {sam} {"Studies in Applied Mathematics"}
MACRO {sjpp} {"Soviet Journal of Plasma Physics"}
MACRO {spd} {"Soviet Physics--Doklady"}
MACRO {sptp} {"Soviet Physics--Technical Physics"}
MACRO {spu} {"Soviet Physics--Uspeki"}
% End module: physjour.mbs
%-------------------------------------------------------------------
% Begin module:
% \ProvidesFile{geojour.mbs}[1999/02/24 2.0e (PWD)]
MACRO {aisr} {"Advances in Space Research"}
MACRO {ag} {"Annales Geophysic\ae"}
MACRO {anigeo} {"Annali di Geofisica"}
MACRO {angl} {"Annals of Glaciology"}
MACRO {andmet} {"Annalen der Meteorologie"}
MACRO {andgeo} {"Annales de Geophysique"}
MACRO {andphy} {"Annales de Physique"}
MACRO {afmgb} {"Archiv f\^^b{u}r Meteorologie, Geophysik und Bioklimatologie"}
MACRO {ass}{"Astrophysics and Space Science"}
MACRO {atph} {"Atm\'osphera"}
MACRO {aao} {"Atmosphere-Ocean"}
MACRO {atenv} {"Atmospheric Environment"}
MACRO {aujag} {"Australian Journal of Agricultural Research"}
MACRO {aumet} {"Australian Meteorological Magazine"}
MACRO {blmet} {"Boundary-Layer Meteorology"}
MACRO {bams} {"Bulletin of the American Meteorological Society"}
MACRO {cch} {"Climatic Change"}
MACRO {cdyn} {"Climate Dynamics"}
MACRO {cbul} {"Climatological Bulletin"}
MACRO {cap} {"Contributions to Atmospheric Physics"}
MACRO {dsr} {"Deep-Sea Research"}
MACRO {dhz} {"Deutsche Hydrographische Zeitschrift"}
MACRO {dao} {"Dynamics of Atmospheres and Oceans"}
MACRO {eco} {"Ecology"}
MACRO {empl}{"Earth, Moon and Planets"}
MACRO {envres} {"Environmental Research"}
MACRO {envst} {"Environmental Science and Technology"}
MACRO {ecms} {"Estuarine and Coastal Marine Science"}
MACRO {expa}{"Experimental Astronomy"}
MACRO {geoint} {"Geofisica Internationale"}
MACRO {geopub} {"Geofysiske Publikasjoner"}
MACRO {geogeo} {"Geologiya i Geofizika"}
MACRO {gafd} {"Geophysical and Astrophysical Fluid Dynamics"}
MACRO {gfd} {"Geophysical Fluid Dynamics"}
MACRO {geomag} {"Geophysical Magazine"}
MACRO {georl} {"Geophysical Research Letters"}
MACRO {grl} {"Geophysical Research Letters"}
MACRO {ga} {"Geophysica"}
MACRO {gs} {"Geophysics"}
MACRO {ieeetap} {"IEEE Transactions on Antennas and Propagation"}
MACRO {ijawp} {"International Journal of Air and Water Pollution"}
MACRO {ijc} {"International Journal of Climatology"}
MACRO {ijrs} {"International Journal of Remote Sensing"}
MACRO {jam} {"Journal of Applied Meteorology"}
MACRO {jaot} {"Journal of Atmospheric and Oceanic Technology"}
MACRO {jatp} {"Journal of Atmospheric and Terrestrial Physics"}
MACRO {jce} {"Journal of Climate"}
MACRO {jcam} {"Journal of Climate and Applied Meteorology"}
MACRO {jcm} {"Journal of Climate Meteorology"}
MACRO {jcy} {"journal of Climatology"}
MACRO {jgr} {"Journal of Geophysical Research"}
MACRO {jga} {"Journal of Glaciology"}
MACRO {jh} {"Journal of Hydrology"}
MACRO {jmr} {"Journal of Marine Research"}
MACRO {jmrj} {"Journal of Meteorological Research, Japan"}
MACRO {jm} {"Journal of Meteorology"}
MACRO {jpo} {"Journal of Physical Oceanography"}
MACRO {jra} {"Journal de Recherches Atmospheriques"}
MACRO {jaes} {"Journal of the Aeronautical Sciences"}
MACRO {japca} {"Journal of the Air Pollution Control Association"}
MACRO {jas} {"Journal of the Atmospheric Sciences"}
MACRO {jmts} {"Journal of the Marine Technology Society"}
MACRO {jmsj} {"Journal of Meteorological Society of Japan"}
MACRO {josj} {"Journal of the Oceanographical Society of Japan"}
MACRO {jwm} {"Journal of Weather Modification"}
MACRO {lao} {"Limnology and Oceanography"}
MACRO {mwl} {"Mariners Weather Log"}
MACRO {mau} {"Mausam"}
MACRO {meteor} {"``Meteor'' Forschungsergebnisse"}
MACRO {map} {"Meteorology and Atmospheric Physics"}
MACRO {metmag} {"Meteorological Magazine"}
MACRO {metmon} {"Meteorological Monographs"}
MACRO {metrun} {"Meteorologische Rundschau"}
MACRO {metzeit} {"Meteorologische Zeitschrift"}
MACRO {metgid} {"Meteorologiya i Gidrologiya"}
MACRO {mwr} {"Monthly Weather Review"}
MACRO {nwd} {"National Weather Digest"}
MACRO {nzjmfr} {"New Zealand Journal of Marine and Freshwater Research"}
MACRO {npg} {"Nonlinear Processes in Geophysics"}
MACRO {om} {"Oceanography and Meteorology"}
MACRO {ocac} {"Oceanologica Acta"}
MACRO {oceanus} {"Oceanus"}
MACRO {paleoc} {"Paleoceanography"}
MACRO {pce} {"Phys. Chem. Earth"}
MACRO {pmg} {"Papers in Meteorology and Geophysics"}
MACRO {ppom} {"Papers in Physical Oceanography and Meteorology"}
MACRO {physzeit} {"Physikalische Zeitschrift"}
MACRO {pps} {"Planetary and Space Science"}
MACRO {pss} {"Planetary and Space Science"}
MACRO {pag} {"Pure and Applied Geophysics"}
MACRO {qjrms} {"Quarterly Journal of the Royal Meteorological Society"}
MACRO {quatres} {"Quaternary Research"}
MACRO {rsci} {"Radio Science"}
MACRO {rse} {"Remote Sensing of the Environment"}
MACRO {rgeo} {"Reviews of Geophysics"}
MACRO {rgsp} {"Reviews of Geophysics and Space Physics"}
MACRO {rdgeo} {"Revista de Geofisica"}
MACRO {revmeta} {"Revista Meteorologica"}
MACRO {sgp}{"Surveys in Geophysics"}
MACRO {sp} {"Solar Phys."}
MACRO {ssr} {"Space Science Review"}
MACRO {tellus} {"Tellus"}
MACRO {tac} {"Theoretical and Applied Climatology"}
MACRO {tagu} {"Transactions, American Geophysical Union (EOS)"}
MACRO {wrr} {"Water Resources Research"}
MACRO {weather} {"Weather"}
MACRO {wafc} {"Weather and Forecasting"}
MACRO {ww} {"Weatherwise"}
MACRO {wmob} {"World Meteorological Organization Bulletin"}
MACRO {zeitmet} {"Zeitschrift f\^^b{u}r Meteorologie"}
% End module: geojour.mbs
%-------------------------------------------------------------------
% Begin module:
% \ProvidesFile{photjour.mbs}[1999/02/24 2.0b (PWD)]
MACRO {appopt} {"Applied Optics"}
MACRO {bell} {"Bell Systems Technical Journal"}
MACRO {ell} {"Electronics Letters"}
MACRO {jasp} {"Journal of Applied Spectroscopy"}
MACRO {jqe} {"IEEE Journal of Quantum Electronics"}
MACRO {jlwt} {"Journal of Lightwave Technology"}
MACRO {jmo} {"Journal of Modern Optics"}
MACRO {josa} {"Journal of the Optical Society of America"}
MACRO {josaa} {"Journal of the Optical Society of America~A"}
MACRO {josab} {"Journal of the Optical Society of America~B"}
MACRO {jdp} {"Journal de Physique"}
MACRO {oc} {"Optics Communications"}
MACRO {ol} {"Optics Letters"}
MACRO {phtl} {"IEEE Photonics Technology Letters"}
MACRO {pspie} {"Proceedings of the Society for Photo-Optical Instruments Engineers"}
MACRO {sse} {"Solid-State Electronics"}
MACRO {sjot} {"Soviet Journal of Optical Technology"}
MACRO {sjqe} {"Soviet Journal of Quantum Electronics"}
MACRO {sleb} {"Soviet Physics--Lebedev Institute Reports"}
MACRO {stph} {"Soviet Physics--Technical Physics"}
MACRO {stphl} {"Soviet Technical Physics Letters"}
MACRO {vr} {"Vision Research"}
MACRO {zph} {"Zeitschrift f\^^b{u}r Physik"}
MACRO {zphb} {"Zeitschrift f\^^b{u}r Physik~B"}
MACRO {zphd} {"Zeitschrift f\^^b{u}r Physik~D"}

MACRO {CLEO} {"Conf. on Lasers and Electro-Optics"}
MACRO {ASSL} {"Advanced Solid State Lasers"}
MACRO {OSA}  {"Optical Society of America"}
% End module: photjour.mbs
%% Copyright 1994-1999 Patrick W Daly
MACRO {acmcs} {"ACM Computing Surveys"}

MACRO {acta} {"Acta Informatica"}

MACRO {cacm} {"Communications of the ACM"}

MACRO {ibmjrd} {"IBM Journal of Research and Development"}

MACRO {ibmsj} {"IBM Systems Journal"}

MACRO {ieeese} {"IEEE Transactions on Software Engineering"}

MACRO {ieeetc} {"IEEE Transactions on Computers"}

MACRO {ieeetcad}
 {"IEEE Transactions on Computer-Aided Design of Integrated Circuits"}

MACRO {ipl} {"Information Processing Letters"}

MACRO {jacm} {"Journal of the ACM"}

MACRO {jcss} {"Journal of Computer and System Sciences"}

MACRO {scp} {"Science of Computer Programming"}

MACRO {sicomp} {"SIAM Journal on Computing"}

MACRO {tocs} {"ACM Transactions on Computer Systems"}

MACRO {tods} {"ACM Transactions on Database Systems"}

MACRO {tog} {"ACM Transactions on Graphics"}

MACRO {toms} {"ACM Transactions on Mathematical Software"}

MACRO {toois} {"ACM Transactions on Office Information Systems"}

MACRO {toplas} {"ACM Transactions on Programming Languages and Systems"}

MACRO {tcs} {"Theoretical Computer Science"}


INTEGERS { nameptr namesleft numnames }

%<*gost7184|gost7184u>

FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
  { namesleft #0 > }
  { s nameptr
    language "english" = 
      {"{vv~}{ll}{~jj}{~f.}"}
      {"{vv~}{ll}{~jj}{~f.}"} % we cannot use f. here due to BibTeX limitations... so the user should care himself
    if$
    format.name$ 't :=
    nameptr #1 >
      {
        nameptr #4 =
        numnames #4 > and
          { "others" 't :=
            #1 'namesleft := }
          'skip$
        if$
        namesleft #1 >
          { ", " * t * }
          {
            t "others" =
            t "~others" =
            or
              { " " * bbl.etal * }
              { ", " * t * }
            if$
          }
        if$
      }
      't
    if$
    nameptr #1 + 'nameptr :=
    namesleft #1 - 'namesleft :=
  }
  while$
  bib.name.font
}

%</gost7184|gost7184u>
%<*gost7802000|gost7802000u>

%FUNCTION {format.names}
%{
%  #1 "{vv~}{ll}{~jj}{,~f.}" format.name$ bib.name.font
%}

%</gost7802000|gost7802000u>

%FUNCTION {format.names}
%{ 's :=
%  "" 't :=
%  #1 'nameptr :=
%  s num.names$ 'numnames :=
%  numnames 'namesleft :=
%    { namesleft #0 > }
%    { s nameptr
%%%      "{vv~}{ll}{, jj}{, f.}" format.name$
%%%      "{ll}{~ff}{~vv}{, jj}" format.name$ 
%      "{ll}{~f.}{~vv}{, jj}" format.name$       
%    't :=
%      nameptr #1 >
%        {
%          nameptr #1
%          #1 + =
%          numnames #2
%          > and
%            { "others" 't :=
%              #1 'namesleft := }
%            'skip$
%          if$
%          namesleft #1 >
%            { ", " * t * }
%            {
%              "," *
%              s nameptr "{ll}" format.name$ duplicate$ "others" =
%                { 't := }
%                { pop$ }
%              if$
%              t "others" =
%                {
%                  " " * bbl.etal *
%                  bib.name.font
%                }
%                { " " * t * }
%              if$
%            }
%          if$
%        }
%        't
%      if$
%      nameptr #1 + 'nameptr :=
%      namesleft #1 - 'namesleft :=
%    }
%  while$
%  t "others" =
%    'skip$
%    { bib.name.font }
%  if$
%}

FUNCTION {format.names.rev}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr
      language "english" =
        {"{f.}{~vv}{~ll}{, jj}"}
        {"{f.}{~vv}{~ll}{, jj}"}
      if$
      format.name$ 't :=
      nameptr #1 >
        {
          nameptr #4 =
          numnames #4 > and
            { "others" 't :=
              #1 'namesleft := }
            'skip$
          if$
          namesleft #1 >
            { ", " * t * }
            {
              t "others" =
      t "~others" =
      or
                { " " * bbl.etal * }
                { ", " * t * }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}


FUNCTION {format.names.resp}
{ 's :=
  "" 't :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr
%       "{vv~}{ll}{, jj}{, f.}" format.name$
%       "{ll}{~ff}{~vv}{, jj}" format.name$ 
      "{ff}{~vv}{~ll}{, jj}" format.name$ 
    't :=
      nameptr #1 >
        {
          nameptr #1
          #1 + =
          numnames #2
          > and
            { "others" 't :=
              #1 'namesleft := }
            'skip$
          if$
          namesleft #1 >
            { ", " * t * }
            {
              "," *
              s nameptr "{ll}" format.name$ duplicate$ "others" =
                { 't := }
                { pop$ }
              if$
              t "others" =
                {
                  " " * bbl.etal *
                  bib.name.font
                }
                { " " * t * }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
  t "others" =
    'skip$
    { bib.name.font }
  if$
}

FUNCTION {format.names.ed}
{ 's :=
  "" 't :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr
      "{f.~}{vv~}{ll}{, jj}"
      format.name$
      't :=
      nameptr #1 >
        {
          namesleft #1 >
            { ", " * t * }
            {
              "," *
              s nameptr "{ll}" format.name$ duplicate$ "others" =
                { 't := }
                { pop$ }
              if$
              t "others" =
                {

                  " " * bbl.etal *
                }
                { " " * t * }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.authors}
{ author empty$
    { "" }
    { author format.names }
  if$
}

FUNCTION {format.authors.resp}
{ author empty$
    { "" }
    { author format.names.resp }
  if$
}

FUNCTION {format.authors.after}
{ author empty$
    { "" }
    { author format.names.rev}
  if$
}

FUNCTION {format.bookauthors}
{ bookauthor empty$
    { "" }
    { bookauthor format.names}
  if$
}

FUNCTION {format.bookauthors.after}
{ bookauthor empty$
    { "" }
    { bookauthor format.names.rev}
  if$
}

FUNCTION {format.editors.after}
{ editor empty$
    { "" }
    { bbl.edby "~" editor format.names.rev * *
    }
  if$
}

FUNCTION {format.compiler.after}
{ compiler empty$
    { "" }
    { bbl.cmplr compiler format.names.rev *
    }
  if$
}

FUNCTION {author.before}
{
  author empty$
    'skip$
    {author num.names$ #4 <
      {format.authors output
       new.sentence}
      'skip$
    if$}
  if$
}

FUNCTION {bookauthor.before}
{
  bookauthor empty$
    'skip$
    {bookauthor num.names$ #4 <
      {format.bookauthors output
       new.sentence}
      'skip$
    if$}
  if$
}

%<*gost7184|gost7184u>

FUNCTION {author.after}
{
  author empty$
    'skip$
    {author num.names$ #3 >
      {format.authors.after output
       new.semicolumn }
      'skip$
    if$}
  if$
}
FUNCTION {bookauthor.after}
{
  bookauthor empty$ 
    'skip$
    {bookauthor num.names$ #3 >
      {format.bookauthors.after output
       new.semicolumn }
      'skip$
    if$}
  if$    
}

%</gost7184|gost7184u>
%<*gost7802000|gost7802000u>

%FUNCTION {author.after}
%{
%  author empty$ 
%    'skip$
%    {format.authors.after output
%       new.semicolumn }
%  if$    
%}
%FUNCTION {bookauthor.after}
%{
%  bookauthor empty$ 
%    'skip$
%    {format.bookauthors.after output
%       new.semicolumn }
%  if$    
%}

%</gost7802000|gost7802000u>

FUNCTION {format.editors}
{ editor empty$
    { "" }
    { editor format.names
      ", " *
      editor num.names$ #1 >
        'bbl.editors
        'bbl.editor
      if$
      *
    }
  if$
}

FUNCTION {format.in.editors}
{ editor empty$
    { "" }
    { editor format.names.ed
    }
  if$
}

FUNCTION {editor.organization.after}
{
  compiler empty$
    {}
    { format.compiler.after  output
    new.semicolumn
    }
  if$
  editor empty$
    {}
    { format.editors.after  output
    new.semicolumn
    }
  if$
  organization empty$
    {}
    {organization output
    new.semicolumn
    }
  if$
}

FUNCTION {format.isbn}
{ isbn empty$
    { "" }
    {
      new.block
      "ISBN~" isbn * }
  if$
}

FUNCTION {format.issn}
{ issn empty$
    { "" }
    {
      new.block
      "ISSN~" issn * }
  if$
}

FUNCTION {format.doi}
{ doi empty$
    { "" }
    { new.block
      "DOI:~" doi * }
  if$
}

FUNCTION {select.language}
{ duplicate$ empty$
    'pop$
    { language empty$
        'skip$
        {"{\selectlanguage{" language * "}" * swap$ * "}" * }
      if$
    }
    if$
}

FUNCTION {format.note}
{
 note empty$
    { "" }
    { note #1 #1 substring$
      duplicate$ "{" =
        'skip$
        { output.state mid.sentence =
          { "l" }
          { "u" }
        if$
        change.case$
        }
      if$
      note #2 global.max$ substring$ *
    }
  if$
}

FUNCTION {format.title}
{ title empty$
    { "" }
    { title
      % select.language
    }
  if$
}

FUNCTION {fin.entry}
{
  format.doi output
  add.period$
  write$
%{{{ translit entry
    translit empty$
'skip$
{newline$
    "\begin{bibtranslit}" write$
    newline$
    translit write$
    newline$
    "\end{bibtranslit}" write$
}
    if$
%}}}
  end.selectlanguage
  newline$
}


FUNCTION {output.my}
{ 's :=
  output.state mid.sentence =
  { " " * write$ }  
%     { ", " * write$ }
    { output.state after.block =
        { 
          write$    
%         add.period$ write$
%          newline$
%           "\newblock " write$
%          "~--- " write$
          "}" write$    
%         "}{%" write$            
        }
        { output.state before.all =
            'write$
            { add.period$ " " * write$ }
          if$
        }
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

FUNCTION {output.bibitem}
{ newline$
% duplicate$ empty$
%    'pop$
%  { language empty$
%      'skip$
%      {"\begin{otherlanguage*}{" write$ 
%       language * write$
%       "}" write$ 
%      }
%    if$
%  } 
%  if$
  "\bibitem{" write$
  cite$ write$
  "}" write$
%%
  newline$
  begin.selectlanguage
%%  
  newline$
  ""
  before.all 'output.state :=
}

FUNCTION {n.dashify}
{
  't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
        { t #1 #2 substring$ "--" = not
            { "--" *
              t #2 global.max$ substring$ 't :=
            }
            {   { t #1 #1 substring$ "-" = }
                { "-" *
                  t #2 global.max$ substring$ 't :=
                }
              while$
            }
          if$
        }
        { t #1 #1 substring$ *
          t #2 global.max$ substring$ 't :=
        }
      if$
    }
  while$
}

FUNCTION {word.in}
{ "" }

FUNCTION {format.date}
{ year empty$
    { "" }
      'year
  if$
}

%FUNCTION {format.date}
%{ year empty$
%    { month empty$
%        { "" }
%        { "there's a month but no year in " cite$ * warning$
%          month
%        }
%      if$
%    }
%    { month empty$
%        'year
%        { year ". " quote$ "--- " month * * * * }
%      if$
%    }
%  if$
%}

FUNCTION {output.address.publisher.date}
{
      address empty$
        'skip$
        { address output
          publisher empty$
            'skip$
            { new.column
            }
          if$
        }
        if$
        publisher output
        format.date output
}


FUNCTION{format.year}
{ year duplicate$ empty$
    { "empty year in " cite$ * warning$ pop$ "" }
%%    { " (" swap$ * ")" * }
    { "" swap$ * }    
%%    { ".~--- " swap$ * }    
  if$
}

FUNCTION {format.btitle}
{ title
  % select.language
}

%FUNCTION {tie.or.space.connect}
%{ duplicate$ text.length$ #3 <
%    { "~" }
%    { " " }
%  if$
%  swap$ * *
%}

FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #3 <
    { "~" }
    { "~" }
  if$
  swap$ * *
}

FUNCTION {either.or.check}
{ empty$
    'pop$
    { "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}

FUNCTION {format.bvolume}
{ volume empty$
    { "" }
    { bbl.volume volume tie.or.space.connect
      series empty$
        'skip$
        { bbl.of space.word * series emphasize * }
      if$
      "volume and number" number either.or.check
    }
  if$
}

FUNCTION {format.number.series}
{ volume empty$
    { number empty$
        { series field.or.null }
        { series empty$
            { number }
        { output.state mid.sentence =
            { bbl.number }
            { bbl.number capitalize }
          if$
          number tie.or.space.connect
          bbl.in space.word * series *
        }
      if$
    }
      if$
    }
    { "" }
  if$
}


FUNCTION {format.edition}
{ edition empty$
    { "" }
    { output.state mid.sentence =
        { edition "l" change.case$ " " * bbl.edition * }
        { edition "t" change.case$ " " * bbl.edition * }
      if$
    }
  if$
}

INTEGERS { multiresult }

FUNCTION {multi.page.check}
{ 't :=
  #0 'multiresult :=
    { multiresult not
      t empty$ not
      and
    }
    { t #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
        { #1 'multiresult := }
        { t #2 global.max$ substring$ 't := }
      if$
    }
  while$
  multiresult
}

FUNCTION {format.pages}
{ pages empty$
    { "" }
    { pages multi.page.check
        { bbl.pages pages n.dashify tie.or.space.connect }
%         { bbl.page pages tie.or.space.connect }
%       { pages bbl.page tie.or.space.connect }
        { bbl.page pages tie.or.space.connect } 
      if$
    }
  if$
}

FUNCTION {format.pages.numpages}
{ pages empty$
    { numpages empty$
      { "" }
      { numpages bbl.numpages tie.or.space.connect }
    if$}
    { format.pages}
  if$
}

FUNCTION {format.pages.page}
{ pages empty$
    { numpages empty$
      { "" }
      { numpages bbl.pages tie.or.space.connect }
    if$}
    { format.pages}
  if$
}


%FUNCTION {format.book.pages}
%{ pages empty$
%    { "" }
%%     { pages " " * bbl.pages * }
%    { pages " " * bbl.page * }
%  if$
%}

FUNCTION {format.book.pages}
{ pages empty$
    { format.pages.numpages }
    { format.pages}
  if$
}    

FUNCTION {format.journal.pages}
{ 
  pages empty$
    'skip$
    { duplicate$ empty$
        { pop$ format.pages }
        {
%%        ", " *
          ".~--- " *
          pages multi.page.check
           { bbl.pages }
           { bbl.page }
          if$
          "~" * *
          pages n.dashify *
        }
      if$
    }
  if$
}

FUNCTION {format.vol.num.year}
{ 
% volume field.or.null
  volume empty$
%    'skip$
  { "" }
%     { bbl.volume "~" * swap$ * }
    { bbl.volume "~" * volume * }
  if$
%    bolden
  number empty$
    'skip$
    {
      volume empty$
      {"\No~" number * *}
      {",~\No~" number * *}
      if$
    }
%     {
% %       "(" number * ")" * *
%       ",~\No~" number * *
%       volume empty$
%       {"\No~" number * *}
%         { "there's a number but no volume in " cite$ * warning$ }
% %        'skip$
%         { "" }
%         if$
%     }
  if$
  issue empty$
    'skip$
    {
      volume empty$
      {
        number empty$
        {bbl.issue  "~" *  issue * * }
        { ",~" bbl.issue * "~" *  issue * * }
        if$
      }
      { ",~" bbl.issue * "~" *  issue * * }
      if$
    }  
%     { ",~" bbl.issue * "~" *  issue * * }
  if$
  output.nonnull
  format.year *
}

%% "

FUNCTION {format.vol.num}
{ 
  volume empty$
    { "" }
    { bbl.volume "~" * volume * }
  if$
  number empty$
    'skip$
    {
      volume empty$
      {bbl.number.first "~" number * * *}
      {",~" bbl.number "~" number * * * *}
      if$
    }
  if$
  issue empty$
    'skip$
    {
      volume empty$
        {
          number empty$
            {bbl.issue.first  "~" *  issue * * }
            { ",~" bbl.issue * "~" *  issue * * }
          if$
        }
        { ",~" bbl.issue * "~" *  issue * * }
      if$
    }  
  if$
}


FUNCTION {format.chapter.pages}
{ chapter empty$
    { "" }
    { type empty$
        { bbl.chapter }
        { type "l" change.case$ }
      if$
      chapter tie.or.space.connect
    }
  if$
}

FUNCTION {format.in.ed.booktitle}
{ booktitle empty$
    { "" }
    { editor empty$
        { "~/\!/ " word.in *  booktitle * }
        { "~/\!/ " word.in *  booktitle *
          ", " *
          bbl.edby
          * " " *
          format.in.editors *
        }
      if$
    }
  if$
}

FUNCTION {empty.misc.check}
{ author empty$ title empty$ howpublished empty$
  month empty$ year empty$ note empty$
  and and and and and
  key empty$ not and
    { "all relevant fields are empty in " cite$ * warning$ }
    'skip$
  if$
}

FUNCTION {format.thesis.type}
{ type empty$
    'skip$
    { pop$
      type "t" change.case$
    }
  if$
}

FUNCTION {format.tr.number}
{ type empty$
    { bbl.techrep }
    'type
  if$
  number empty$
    { "t" change.case$ }
    { number tie.or.space.connect }
  if$
}

FUNCTION {format.article.crossref}
{
  key empty$
    { journal empty$
        { "need key or journal for " cite$ * " to crossref " * crossref *
          warning$
          ""
        }
        { word.in journal emphasize * }
      if$
    }
    { word.in key * " " *}
  if$
  " \cite{" * crossref * "}" *
}

FUNCTION {format.crossref.editor}
{ editor #1 "{vv~}{ll}" format.name$
  editor num.names$ duplicate$
  #2 >
    { pop$
      " " * bbl.etal *
    }
    { #2 <
        'skip$
        { editor #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
            {
              " " * bbl.etal *
            }
            { bbl.and space.word * editor #2 "{vv~}{ll}" format.name$
              * }
          if$
        }
      if$
    }
  if$
}

FUNCTION {format.book.crossref}
{ volume empty$
    { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
      word.in
    }
    { bbl.volume capitalize
      volume tie.or.space.connect
      bbl.of space.word *
    }
  if$
  editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
        { series empty$
            { "need editor, key, or series for " cite$ * " to crossref " *
              crossref * warning$
              "" *
            }
            { series emphasize * }
          if$
        }
        { key * }
      if$
    }
    { format.crossref.editor * }
  if$
  " \cite{" * crossref * "}" *
}

FUNCTION {format.incoll.inproc.crossref}
{
  editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
        { booktitle empty$
            { "need editor, key, or booktitle for " cite$ * " to crossref " *
              crossref * warning$
              ""
            }
            { word.in booktitle * }
          if$
        }
        { word.in key * " " *}
      if$
    }
    { word.in format.crossref.editor * " " *}
  if$
  " \cite{" * crossref * "}" *
}

FUNCTION {format.org.or.pub}
{ 't :=
  ""
  address empty$ t empty$ and
    'skip$
    {
      address empty$
        'skip$
        { address * }
      if$
      t empty$
        'skip$
        { address empty$
            'skip$
            { ": " * }
          if$
          t *
        }
      if$
    }
  if$
}

FUNCTION {format.publisher.address}
{ publisher empty$
    { "empty publisher in " cite$ * warning$
      ""
    }
    { publisher }
  if$
  format.org.or.pub
}

FUNCTION {format.organization.address}
{ organization empty$
    { "" }
    { organization }
  if$
  format.org.or.pub
}

FUNCTION {format.url}
{ url empty$
    { "" }
    { "\urlprefix\url{" url * "}" * }
  if$
}

%FUNCTION {format.url}
%{ url empty$
%    { "" }
%    { after.sentence 'output.state :=
%      "\BibUrl{ " url * "}" *
%    }
%  if$
%}

%FUNCTION {format.annote}
%{ annote empty$
%    { "" }
%{ after.sentence 'output.state :=
%  "\BibAnnote{" annote add.period$ * "}" *
%}
%  if$
%}

FUNCTION {format.annote}
{ annote empty$
    { "" }
{ after.sentence 'output.state :=
  annote add.period$
}
  if$
}


%%%---------------------------------------------------------------------

FUNCTION {article}
{
  output.bibitem
  author.before
%  format.authors "author" output.check
  format.title "title" output.check
  new.slash
  author.after
%  new.dblslash
%  new.block
  crossref missing$
    {
      new.dblslash
      journal "journal" output.check
%      "~/\!/ " write$
      new.block
      format.year output.nonnull
      new.block
      format.vol.num output
    }
    {
      format.article.crossref output.nonnull
      new.block
      format.pages output
    }
  if$
  new.block
  format.pages output
%  format.journal.pages output
  format.issn output
  new.block
  format.url output
  new.block
  format.note output
  fin.entry
}


FUNCTION {book}
{ 
  output.bibitem
  %% Desctription's title
  author.before    
  %% Title's domain
  format.btitle "title" output.check
% %%%% Respons
%   author empty$
%     {"~/~" format.authors.resp "author" output.check}
%     {""}
%   if$ 
  new.slash
  author.after
  editor.organization.after  
  crossref missing$
    { 
      new.sentence      
      format.number.series output  
      new.block
      format.edition output
      new.block
      output.address.publisher.date
      new.block
      format.bvolume output
    }
    {
      new.block
      format.book.crossref output.nonnull
    }
  if$
  format.isbn output
  format.book.pages output
  new.block
  format.url output
  new.block
  format.note output
  fin.entry
}

FUNCTION {booklet}
{ output.bibitem
  author.before
%  format.authors output
  format.date output
  date.block
  format.title "title" output.check
  new.slash
  author.after
  editor.organization.after
  new.block
  howpublished output
  address output
  format.isbn output
  format.book.pages output
  new.block
  format.url output
  new.block
  format.note output
  fin.entry
}

FUNCTION {inbook}
{ 
  output.bibitem
  author.before
  format.btitle "title" output.check
  new.slash
  author.after
  new.dblslash
  bookauthor.before
  booktitle "booktitle" output.check
  new.slash
  bookauthor.after  
  editor.organization.after
  new.block
  format.edition output
  new.block
  format.number.series output
  new.sentence
  output.address.publisher.date
  new.block
  format.vol.num output
  new.block
  format.pages.numpages output
  new.block
  note output
  new.sentence
  format.url output
  format.note output
  fin.entry
}


%FUNCTION {inbook}
%{ output.bibitem
%  author.before
%  format.btitle "title" output.check
%  new.slash
%  author.after
%  new.dblslash
%  bookauthor.before
%  booktitle "booktitle" output.check
%  new.slash
%  bookauthor.after  
%  editor.organization.after
%  new.block
%  format.edition output
%  new.block
%  format.number.series output
%  new.sentence
%  output.address.publisher.date
%  new.block
%  format.bvolume output
%  new.block
%  format.pages.numpages output
%  new.block
%  note output
%  new.sentence
%  format.url output
%  new.block
%  format.note output
%  format.annote output
%  fin.entry
%}


% FUNCTION {incollection}
% { output.bibitem
%     author.before
% %  format.authors "author" output.check
%   format.date "year" output.check
%   date.block
%   format.title "title" output.check
%   new.slash
%   author.after
%   new.block
%   crossref missing$
%     { 
%       format.in.ed.booktitle "booktitle" output.check
%       format.bvolume output
%       format.number.series output
%       format.edition output
%       format.chapter.pages output
%       new.sentence
%       format.publisher.address output
%       format.isbn output
%     }
%     { format.incoll.inproc.crossref output.nonnull
%       format.chapter.pages output
%     }
%   if$
%   format.pages "pages" output.check
%   new.block
%   format.url output
%   new.block
%   format.note output
%   fin.entry
% }

FUNCTION {incollection}
{ output.bibitem
  author.before
  new.sentence
  format.title "title" output.check
  new.slash
  author.after
  new.dblslash
  booktitle "booktitle" output.check
  new.slash
  editor.organization.after
  new.block
  output.address.publisher.date
  new.block
  format.bvolume output
  format.number.series output
  new.block
  format.pages.page output
  new.block
  note output
  new.sentence
  format.url output
  format.annote output
  fin.entry
}


%FUNCTION {inproceedings}
%{ 
%  output.bibitem
%  author.before
%  new.sentence
%  format.title "title" output.check
%  new.slash
%  author.after
%  new.dblslash
%  crossref missing$
%    { 
%      booktitle "booktitle" output.check
%      new.slash
%      editor.organization.after
%      new.block
%%      output.address.publisher.date
%%      new.block
%%      format.in.ed.booktitle "booktitle" output.check
%      format.bvolume output
%      format.number.series output
%      new.sentence
% %%
%      new.block
% %%      
%      publisher empty$
%        { format.organization.address output }
%        { 
%          organization output
%          format.publisher.address output
%        }
%      if$
%    format.isbn output
%    format.issn output
%    }
%    { 
%      format.incoll.inproc.crossref output.nonnull
%      format.pages.numpages output
%    }
%  if$
%%  new.block
%  format.date "year" output.check
%  date.block
%  format.url output
%  new.block
%  format.note output
%  fin.entry
%}

FUNCTION {inproceedings}
{ output.bibitem
  author.before
  new.sentence
  format.title "title" output.check
  new.slash
  author.after
  new.dblslash
  booktitle "booktitle" output.check
  new.slash
  editor.organization.after
  new.block
  format.vol.num output
%  format.bvolume output
  format.number.series output
  new.block
  address empty$
    { publisher output
      format.date "year" output.check
    }
    { address output.nonnull
      new.column
      publisher output
      format.date "year" output.check
    }
  if$
  new.block
  format.pages.numpages output
  new.block
  note output
  new.sentence
  format.url output
  format.annote output
  fin.entry
}


FUNCTION {conference} { inproceedings }

FUNCTION {manual}
{ output.bibitem
  author empty$
    { organization empty$
        'skip$
        { organization output.nonnull
          address output
        }
      if$
    }
    { format.authors output.nonnull }
  if$
  format.date output
  date.block
  format.btitle "title" output.check
  author empty$
    { organization empty$
    {
          address new.block.checka
          address output
        }
        'skip$
      if$
    }
    {
      organization address new.block.checkb
      organization output
      address output
    }
  if$
  format.edition output
  new.block
  format.url output
  new.block
  format.note output
  fin.entry
}

%FUNCTION {mastersthesis}
%{ output.bibitem
%  format.authors "author" output.check
%  format.date "year" output.check
%  date.block
%  format.btitle "title" output.check
%  new.block
%  bbl.mthesis format.thesis.type output.nonnull
%  school "school" output.check
%  address output
%  new.block
%  format.url output
%  new.block
%  format.note output
%  fin.entry
%}

FUNCTION {mastersthesis}
{ 
  output.bibitem
  format.authors "author" output.check
  new.block
  format.btitle "title" output.check
  new.block
  bbl.mthesis format.thesis.type output.nonnull
  school "school" output.check
  address output
  format.date "year" output.check
  new.block
  format.url output
  new.block
  format.note output
  format.note output
  fin.entry
}

FUNCTION {misc}
{ 
  output.bibitem
  format.authors output
  title howpublished new.sentence.checkb
  format.title output
  howpublished new.block.checka
  howpublished output
  new.block
  format.date output
  new.block
  note output
  new.sentence
  format.url output
  format.note output
  fin.entry
  empty.misc.check
}


FUNCTION {phdthesis}
{ 
  output.bibitem
  format.authors "author" output.check
  new.sentence
  format.btitle "title" output.check
  new.column
  bbl.phdthesis format.thesis.type output.nonnull
  new.slash
  school "school" output.check
  new.block
  output.address.publisher.date
  new.block
  format.pages.page output
  note output
  new.sentence
  format.url output
  format.note output
  fin.entry
}

%FUNCTION {phdthesis}
%{ output.bibitem
%  format.authors "author" output.check
%  format.date "year" output.check
%  date.block
%  format.btitle "title" output.check
%  new.block
%  bbl.phdthesis format.thesis.type output.nonnull
%  school "school" output.check
%  address output
%  new.block
%  format.url output
%  new.block
%  format.note output
%  fin.entry
%}

FUNCTION {proceedings}
{ output.bibitem
  editor empty$
    { organization output }
    { format.editors output.nonnull }
  if$
  format.date "year" output.check
  date.block
  format.btitle "title" output.check
  format.bvolume output
  format.number.series output
  editor empty$
    { publisher empty$
        'skip$
        {
          new.sentence
          format.publisher.address output
        }
      if$
    }
    { publisher empty$
        {
          new.sentence
          format.organization.address output }
        {
          new.sentence
          organization output
          format.publisher.address output
        }
      if$
     }
  if$
  format.isbn output
  format.issn output
  new.block
  format.url output
  new.block
  format.note output
  fin.entry
}

FUNCTION {techreport}
{ 
  output.bibitem
  author.before
  new.sentence
  format.title "title" output.check
  new.column
  format.tr.number output.nonnull
  new.slash
  author.after  
  editor.organization.after  
  new.slash
  institution "institution" output.check
  new.block
  address output
  format.date "year" output.check
  new.block
  note output
  new.sentence
  format.url output
  format.annote output
  fin.entry
}


%FUNCTION {techreport}
%{ output.bibitem
%  format.authors "author" output.check
%  format.date "year" output.check
%  date.block
%  format.title "title" output.check
%  new.block
%  format.tr.number output.nonnull
%  institution "institution" output.check
%  address output
%  new.block
%  format.url output
%  new.block
%  format.note output
%  fin.entry
%}

FUNCTION {unpublished}
{ output.bibitem
  format.authors "author" output.check
  format.date output
  date.block
  format.title "title" output.check
  new.block
  format.url output
  new.block
  format.note "note" output.check
  fin.entry
}

FUNCTION {default.type} { misc }

READ

%<*gost7184|gost7802000>

FUNCTION {sortify}
{ purify$
  "l" change.case$
}

INTEGERS { len }

FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}

FUNCTION {sort.format.names}
{ 's :=
  #1 'nameptr :=
  ""
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr
      "{ll{ }}{  f{ }}{  jj{ }}"
      format.name$ 't :=
      nameptr #1 >
        {
          nameptr #1
          #1 + =
          numnames #2
          > and
            { "others" 't :=
              #1 'namesleft := }
            'skip$
          if$
          "   "  *
          namesleft #1 = t "others" = and
            { "zzzzz" * }
            { t sortify * }
          if$
        }
        { t sortify * }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {sort.format.title}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  sortify
  #1 global.max$ substring$
}

FUNCTION {author.sort}
{ author empty$
    { key empty$
        { "to sort, need author or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.editor.sort}
{ author empty$
    { editor empty$
        { key empty$
            { "to sort, need author, editor, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { editor sort.format.names }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.organization.sort}
{ author empty$
    { organization empty$
        { key empty$
            { "to sort, need author, organization, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { "The " #4 organization chop.word sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {editor.organization.sort}
{ editor empty$
    { organization empty$
        { key empty$
            { "to sort, need editor, organization, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { "The " #4 organization chop.word sortify }
      if$
    }
    { editor sort.format.names }
  if$
}

FUNCTION {presort}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.sort
    { type$ "proceedings" =
        'editor.organization.sort
        { type$ "manual" =
            'author.organization.sort
            'author.sort
          if$
        }
      if$
    }
  if$
  "    "
  *
  year field.or.null sortify
  *
  "    "
  *
  title field.or.null
  sort.format.title
  *
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {presort}

SORT

%</gost7184|gost7802000>

STRINGS { longest.label }

INTEGERS { number.label longest.label.width }

FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  #1 'number.label :=
  #0 'longest.label.width :=
}

FUNCTION {longest.label.pass}
{ number.label int.to.str$ 'label :=
  number.label #1 + 'number.label :=
  label width$ longest.label.width >
    { label 'longest.label :=
      label width$ 'longest.label.width :=
    }
    'skip$
  if$
}

EXECUTE {initialize.longest.label}

ITERATE {longest.label.pass}

FUNCTION {begin.bib}
{  "\begin{thebibliography}{"  longest.label  * "}" *  write$ newline$
  "\expandafter\ifx\csname bibnamefont\endcsname\relax"
  write$ newline$
  "  \def\bibnamefont#1{#1}\fi"
  write$ newline$
  "\expandafter\ifx\csname url\endcsname\relax"
  write$ newline$
  "  \def\url#1{\texttt{#1}}\fi"
  write$ newline$
%  "\makeatletter  \renewcommand{\@biblabel}[1]{#1.\hfill} \makeatother"
%  write$ newline$
%  "\expandafter\ifx\csname urlprefix\endcsname\relax\def\urlprefix{URL }\fi"
  "\expandafter\ifx\csname urlprefix\endcsname\relax\def\urlprefix{}\fi"
  write$ newline$
%  "\expandafter\ifx\csname selectlanguage\endcsname\relax"
%  write$ newline$
%  "  \def\selectlanguage#1{\relax}\fi"
%  write$ newline$
%  "\input gost7184.sty" write$ newline$
  "\newcommand{\Capitalize}[1]{\uppercase{#1}}" write$ newline$
  "\newcommand{\capitalize}[1]{\expandafter\Capitalize#1}" write$ newline$
  preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}

%% End of customized bst file
%%
%% End of file `gost7184.bst'.
