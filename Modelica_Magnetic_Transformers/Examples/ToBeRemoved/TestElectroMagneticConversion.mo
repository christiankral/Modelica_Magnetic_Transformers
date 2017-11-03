within Modelica_Magnetic_Transformers.Examples.ToBeRemoved;
model TestElectroMagneticConversion
extends Modelica.Icons.Example;
Components.ThreePhase.Winding symmetricWinding(RRef=1, Lsigma=0.01)
  annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(V=fill(1,
      3), freqHz=fill(50, 3)) annotation (Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=270,
      origin={-40,0})));
Modelica.Electrical.MultiPhase.Basic.Star star annotation (Placement(
      transformation(
      extent={{-10,-10},{10,10}},
      rotation=270,
      origin={-40,-30})));
Modelica.Electrical.Analog.Basic.Ground ground
  annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
Modelica.Magnetic.FluxTubes.Basic.ConstantPermeance constantPermeance
  annotation (Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=90,
      origin={-20,30})));
Modelica.Magnetic.FluxTubes.Basic.ConstantPermeance constantPermeance1
  annotation (Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=90,
      origin={0,30})));
Modelica.Magnetic.FluxTubes.Basic.ConstantPermeance constantPermeance2
  annotation (Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=90,
      origin={20,30})));
Modelica.Magnetic.FluxTubes.Basic.Ground ground1
  annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
equation
connect(sineVoltage.plug_p, symmetricWinding.plug_p) annotation (Line(
    points={{-40,10},{-26,10},{-26,6},{-10,6}},
    color={0,0,255},
    smooth=Smooth.None));
connect(sineVoltage.plug_n, symmetricWinding.plug_n) annotation (Line(
    points={{-40,-10},{-26,-10},{-26,-6},{-10,-6}},
    color={0,0,255},
    smooth=Smooth.None));
connect(sineVoltage.plug_n, star.plug_p) annotation (Line(
    points={{-40,-10},{-40,-20}},
    color={0,0,255},
    smooth=Smooth.None));
connect(star.pin_n, ground.p) annotation (Line(
    points={{-40,-40},{-40,-60}},
    color={0,0,255},
    smooth=Smooth.None));
connect(constantPermeance.port_p, symmetricWinding.port_p1) annotation (
    Line(
    points={{-20,20},{-16,20},{-16,10},{-10,10}},
    color={255,127,0},
    smooth=Smooth.None));
connect(constantPermeance1.port_p, symmetricWinding.port_p2) annotation (
    Line(
    points={{0,20},{0,10}},
    color={255,127,0},
    smooth=Smooth.None));
connect(constantPermeance2.port_p, symmetricWinding.port_p3) annotation (
    Line(
    points={{20,20},{16,20},{16,10},{10,10}},
    color={255,127,0},
    smooth=Smooth.None));
connect(constantPermeance.port_n, constantPermeance1.port_n) annotation (
    Line(
    points={{-20,40},{0,40}},
    color={255,127,0},
    smooth=Smooth.None));
connect(constantPermeance1.port_n, constantPermeance2.port_n) annotation (
   Line(
    points={{0,40},{20,40}},
    color={255,127,0},
    smooth=Smooth.None));
connect(symmetricWinding.port_n1, symmetricWinding.port_n2) annotation (
    Line(
    points={{-10,-10},{-10,-20},{0,-20},{0,-10},{4.44089e-16,-10}},
    color={255,127,0},
    smooth=Smooth.None));
connect(symmetricWinding.port_n2, symmetricWinding.port_n3) annotation (
    Line(
    points={{0,-10},{0,-20},{10,-20},{10,-10}},
    color={255,127,0},
    smooth=Smooth.None));
connect(ground1.port, symmetricWinding.port_n2) annotation (Line(
    points={{0,-40},{0,-10}},
    color={255,127,0},
    smooth=Smooth.None));
annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
          -100,-100},{100,100}}), graphics));
end TestElectroMagneticConversion;
