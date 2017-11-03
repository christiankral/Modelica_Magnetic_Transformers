within Modelica_Magnetic_Transformers.Components.ThreePhase;
model ElectroMagneticConverter
"Three phase electro-magnetic energy conversion"

  Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m=m)
  "Positive electric plug"  annotation (Placement(transformation(extent={{-90,50},
          {-110,70}},       rotation=0), iconTransformation(extent={{-90,50},
          {-110,70}})));
  Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(final m=m)
  "Negative electric plug"  annotation (Placement(transformation(extent={{-110,
          -70},{-90,-50}},   rotation=0), iconTransformation(extent={{-110,
          -70},{-90,-50}})));

  constant Integer m = 3 "Number of phases";
  Modelica.SIunits.Voltage v[m] "Voltage";
  Modelica.SIunits.Current i[m](start=zeros(m), stateSelect=fill(StateSelect.prefer,m))
  "Current";
  Modelica.SIunits.MagneticPotentialDifference V_m[m]
  "Magnetic potential difference";
  Modelica.SIunits.MagneticFlux Phi[m]
  "Magnetic flux coupled into magnetic circuit";

  parameter Real N[m]=ones(m) "Number of turns";

  //for information only:
  Modelica.SIunits.MagneticFlux Psi[m]
  "Flux linkage for information only";
  Modelica.SIunits.Inductance L_stat[m]
  "Static inductance abs(Psi/i) for information only";

  Modelica.Magnetic.FluxTubes.Interfaces.PositiveMagneticPort port_p1
  "Positive magnetic port, leg 1"
                             annotation (Placement(transformation(extent={{-110,90},
          {-90,110}},         rotation=0), iconTransformation(extent={{-110,90},
          {-90,110}})));
  Modelica.Magnetic.FluxTubes.Interfaces.PositiveMagneticPort port_p2
  "Positive magnetic port, leg 2"
                             annotation (Placement(transformation(extent={{-10,90},
          {10,110}},          rotation=0), iconTransformation(extent={{-10,90},
          {10,110}})));
  Modelica.Magnetic.FluxTubes.Interfaces.PositiveMagneticPort port_p3
  "Positive magnetic port, leg 3"
                             annotation (Placement(transformation(extent={{90,90},
          {110,110}},         rotation=0), iconTransformation(extent={{90,90},
          {110,110}})));
  Modelica.Magnetic.FluxTubes.Interfaces.NegativeMagneticPort port_n1
  "Negative magnetic port, leg 1"
                             annotation (Placement(transformation(extent={{-90,
          -110},{-110,-90}},    rotation=0), iconTransformation(extent={{-90,
          -110},{-110,-90}})));
  Modelica.Magnetic.FluxTubes.Interfaces.NegativeMagneticPort port_n2
  "Negative magnetic port, leg 2"
                             annotation (Placement(transformation(extent={{10,-110},
          {-10,-90}},           rotation=0), iconTransformation(extent={{10,-110},
          {-10,-90}})));
  Modelica.Magnetic.FluxTubes.Interfaces.NegativeMagneticPort port_n3
  "Negative magnetic port, leg 3"
                             annotation (Placement(transformation(extent={{110,
          -110},{90,-90}},      rotation=0), iconTransformation(extent={{110,
          -110},{90,-90}})));
protected
  Real eps=100*Modelica.Constants.eps;
equation
  v = plug_p.pin.v - plug_n.pin.v;
  zeros(m) = plug_p.pin.i + plug_n.pin.i;
  i = plug_p.pin.i;

  V_m[1] = port_p1.V_m - port_n1.V_m;
  V_m[2] = port_p2.V_m - port_n2.V_m;
  V_m[3] = port_p3.V_m - port_n3.V_m;
  0 = port_p1.Phi + port_n1.Phi;
  0 = port_p2.Phi + port_n2.Phi;
  0 = port_p3.Phi + port_n3.Phi;
  Phi = {port_p1.Phi,port_p2.Phi,port_p3.Phi};

  //converter equations:
  V_m = i.*N;
  // Ampere's law
  N.*der(Phi) = -v;
  // Faraday's law

  //for information only:
  Psi = N.*Phi;
  //use of abs() for positive results; due to Modelica sign conventions for flow into connectors:
  for k in 1:m loop
    L_stat[k] = noEvent(if abs(i[k]) > eps then abs(Psi[k]/i[k]) else abs(Psi[k]/eps));
  end for;
  annotation (
    defaultComponentName="converter",
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}}), graphics={Polygon(
              points={{-134,63},{-124,60},{-134,57},{-134,63}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),Line(points={{-150,60},{-125,
          60}}, color={160,160,164}),
                                Line(points={{-150,-59},{-125,-59}}, color=
          {160,160,164}),Polygon(
              points={{-140,-56},{-150,-59},{-140,-62},{-140,-56}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),Text(
              extent={{-141,-56},{-124,-41}},
              lineColor={160,160,164},
              textString="i"),Text(
              extent={{-150,63},{-133,78}},
              lineColor={160,160,164},
              textString="i")}),
    Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}}), graphics={
      Ellipse(extent={{-76,0},{-56,20}}, lineColor={0,0,255}),
      Ellipse(extent={{-76,20},{-56,40}}, lineColor={0,0,255}),
      Ellipse(extent={{-76,-20},{-56,0}}, lineColor={0,0,255}),
      Ellipse(extent={{-76,-40},{-56,-20}}, lineColor={0,0,255}),
      Line(points={{-100,-40},{-100,-60}},
                                         color={0,0,255}),
      Rectangle(
        extent={{-78,40},{-64,-40}},
        lineColor={255,255,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Line(points={{-100,40},{-100,60}},
                                       color={0,0,255}),
      Text(
        extent={{-150,150},{150,110}},
        lineColor={0,0,255},
        textString="%name"),
      Line(points={{-90,30},{-90,-30}}, color={0,0,255}),
      Polygon(
        points={{-90,-30},{-84,-10},{-96,-10},{-90,-30}},
        lineColor={0,0,255},
        fillColor={0,0,255},
        fillPattern=FillPattern.Solid),
      Line(points={{-100,40},{-66,40}},color={0,0,255}),
      Line(points={{-66,-40},{-100,-40}},color={0,0,255}),
      Ellipse(extent={{-14,-40},{6,-20}},   lineColor={0,0,255}),
      Ellipse(extent={{-14,-20},{6,0}},   lineColor={0,0,255}),
      Ellipse(extent={{-14,0},{6,20}},   lineColor={0,0,255}),
      Ellipse(extent={{-14,20},{6,40}},   lineColor={0,0,255}),
      Rectangle(
        extent={{-16,40},{-2,-40}},
        lineColor={255,255,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Line(points={{-42,40},{-4,40}},  color={0,0,255}),
      Line(points={{-4,-40},{-42,-40}},  color={0,0,255}),
      Ellipse(extent={{46,-40},{66,-20}},   lineColor={0,0,255}),
      Ellipse(extent={{46,-20},{66,0}},   lineColor={0,0,255}),
      Ellipse(extent={{46,0},{66,20}},   lineColor={0,0,255}),
      Ellipse(extent={{46,20},{66,40}},   lineColor={0,0,255}),
      Rectangle(
        extent={{44,40},{58,-40}},
        lineColor={255,255,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Line(points={{18,40},{56,40}},   color={0,0,255}),
      Line(points={{56,-40},{18,-40}},   color={0,0,255}),
        Line(
          points={{0,80},{0,-120}},
          color={255,128,0},
          smooth=Smooth.None),
        Line(
          points={{-92,98},{-84,92},{-78,84},{-72,72},{-66,54},{-64,44},{
              -62,30},{-60,14},{-60,0}},
          color={255,128,0},
          smooth=Smooth.None),
        Line(
          points={{-92,-98},{-84,-92},{-78,-84},{-72,-72},{-66,-54},{-64,
              -44},{-62,-30},{-60,-14},{-60,0}},
          color={255,128,0},
          smooth=Smooth.None),
        Line(
          points={{90,98},{82,92},{76,84},{70,72},{64,54},{62,44},{60,30},{
              58,14},{58,0}},
          color={255,128,0},
          smooth=Smooth.None),
        Line(
          points={{90,-98},{82,-92},{76,-84},{70,-72},{64,-54},{62,-44},{60,
              -30},{58,-14},{58,0}},
          color={255,128,0},
          smooth=Smooth.None)}),
    Documentation(info="<html>
<p>
The electro-magnetic energy conversion is given by <i>Ampere</i>'s law and <i>Faraday</i>'s law respectively:
</p>

<pre>
    V_m = i * N
    N * d&Phi;/dt = -v
</pre>

<p>
V_m is the magnetomotive force that is supplied to the connected magnetic circuit, &Phi; is the magnetic flux through the associated branch of this magnetic circuit. The negative sign of the induced voltage v is due to <i>Lenz</i>'s law.
</p>

<p>
The flux linkage &Psi; and the static inductance L_stat = |&Psi;/i| are calculated for information only. Note that L_stat is set to |&Psi;/eps| if |i| &lt; eps
(= 100*Modelica.Constants.eps).
</p>
</html>"));
end ElectroMagneticConverter;
