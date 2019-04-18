pro ufo

readcol,'chile2009-2011.txt',yy1,mm1,dd1,f='(X,X,X)',/silent
date_chile = julday(mm1,dd1,yy1)

readcol,'brazil2010-2011.txt',yy,mm,dd,f='(X,X,X)',/silent
date_brazil = julday(mm,dd,yy)

;print,min(date_chile,xc)-min(date_brazil,xb)

jd2009 = julday(1,1,2009)

plotstuff,/set,/silent
loadct,39,/silent

set_plot,'ps'

device,filename='years.eps',/encapsul,/color
plothist,yy,/half,xrange=[2008.01,2011.99],/xsty,yrange=[0,30],ytitle='!6# Sightings',thick=5
plothist,/overplot,yy1,/half,thick=5,color=50,linestyle=2
legend,['Brazil','Chile'],linestyle=[0,2],color=[0,50],charsize=1.2,thick=5,box=0
device,/close

;; plothist,mm,/half,thick=5,bin=2
;; plothist,mm1,/half,/overplot,thick=5,color=50,bin=2


; do a silly back-of-envelope calculation of # UFOs detected
; the detection manifold is a function of two unknowns that we really
; have no data on: the angular extent of UFOs, and the Frequency of
; UFOs. The Frequency can be written in many quantities...


; whole sky is observed for 30 seconds every 3 days
; assume a pure random pointing

ang = findgen(360)+1 ; UFO size ranges from 1 arcsec to 1 degree
dur = findgen(360)*10.+1 ; UFO duration ranges from 1sec to 1 hour

fov = 9.6 ; sq degree LSST FOV
exp = 15. ; 15 second LSST exposures

day = 60.*60.*24./2. ; half the day (in seconds)

tot = 4d0*!dpi/!dtor^2. / 2d0 ; (half) total area of sky

N_lsst = 200000. ; number of LSST exposures in 10 years
N_UFO = 50.      ; number of UFOs in 10 years

prob = fltarr(360,360)
for n=0L,360-1 do prob[n,*] = fov/tot * ang[n]/tot * dur/day * exp/day



device,filename='prob.eps',/encapsul,/color
contour,(prob * N_lsst * N_ufo),ang,dur/60.,xtitle='!6Angular Size (deg!u2!n)',ytitle='!6Duration (min)',/xsty,/ysty,nlev=10,c_labels=replicate(1,10);,c_charsize=1.3
device,/close

print,max(prob * N_lsst * N_ufo)* 100.

N_ufo2 = 1000.
print,max(prob * N_lsst * N_ufo2)* 100.



set_plot,'X'
stop
end
