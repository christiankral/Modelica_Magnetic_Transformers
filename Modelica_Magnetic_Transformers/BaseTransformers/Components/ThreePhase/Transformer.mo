within Modelica_Magnetic_Transformers.BaseTransformers.Components.ThreePhase;
model Transformer "General three phase transformer model"
  extends Interfaces.ThreePhase.PartialTransformer;

  parameter Modelica_Magnetic_Transformers.Types.ThreePhaseCore core=Modelica_Magnetic_Transformers.Types.ThreePhaseCore.noCore "Core type" annotation (Dialog(tab="Nominal resistances and inductances", group="Core"));
  parameter Modelica.SIunits.Inductance L1m = 0
  "Main field inductance per phase w.r.t. primary side"
    annotation(Dialog(
      tab="Nominal resistances and inductances",
      group = "Core",
      enable=core <> Transformers.Types.ThreePhaseCore.noCore));
  parameter Modelica.SIunits.Inductance L10 = 0
  "Zero inductance of primary side due to leakage, legs and back iron"
    annotation(Dialog(
      tab="Nominal resistances and inductances",
      group = "Core",
      enable=core == Transformers.Types.ThreePhaseCore.symmetricCoreBackIron));
  final parameter Modelica.SIunits.Reluctance R_mLegYoke=
      if core==Modelica_Magnetic_Transformers.Types.ThreePhaseCore.noCore
         then 0 else N1^2/L1m "Reluctance of legs"
    annotation(Evaluate=true);
  final parameter Modelica.SIunits.Permeance G_mBackIron=
      if core==Modelica_Magnetic_Transformers.Types.ThreePhaseCore.symmetricCoreBackIron
      then 1/(1/(L10-L1sigma)-1/L1m)*3/N1^2 else 0
  "Permeance of back iron"
      annotation(Evaluate=true);

Modelica.Magnetic.FluxTubes.Basic.Ground ground
  annotation (Placement(transformation(extent={{60,-20},{80,0}})));
  Modelica.Magnetic.FluxTubes.Basic.ConstantReluctance legYoke1(
    final R_m=R_mLegYoke) "Leg and yoke of phase 1"
    annotation (Placement(transformation(extent={{-50,-30},{-70,-10}})));
  Modelica.Magnetic.FluxTubes.Basic.ConstantReluctance legYoke2(
    final R_m=R_mLegYoke) "Leg and yoke of phase 2"
    annotation (Placement(transformation(extent={{-50,-10},{-70,10}})));
  Modelica.Magnetic.FluxTubes.Basic.ConstantReluctance legYoke3(
    final R_m=R_mLegYoke) "Leg and yoke of phase 3"
    annotation (Placement(transformation(extent={{-50,10},{-70,30}})));
  Modelica.Magnetic.FluxTubes.Basic.ConstantPermeance backIron(
    final G_m=G_mBackIron)
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
equation
  connect(legYoke3.port_p, winding1.port_p3) annotation (Line(
      points={{-50,20},{-50,10},{-40,10}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(legYoke2.port_p, winding1.port_p2) annotation (Line(
      points={{-50,0},{-40,0}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(legYoke1.port_p, winding1.port_p1) annotation (Line(
      points={{-50,-20},{-50,-10},{-40,-10}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(legYoke3.port_n, legYoke2.port_n) annotation (Line(
      points={{-70,20},{-70,0}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(legYoke2.port_n, legYoke1.port_n) annotation (Line(
      points={{-70,0},{-70,-20}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(winding3.port_n3, winding3.port_n2) annotation (Line(
      points={{40,10},{40,10},{50,10},{50,-2.22045e-16},{40,-2.22045e-16}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(winding3.port_n2, winding3.port_n1) annotation (Line(
      points={{40,0},{50,0},{50,-10},{40,-10}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(winding3.port_n2, ground.port) annotation (Line(
      points={{40,0},{70,0}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(backIron.port_p, legYoke3.port_n) annotation (Line(
      points={{-70,40},{-70,20}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(backIron.port_n, winding3.port_n3) annotation (Line(
      points={{-50,40},{0,40},{0,40},{50,40},{50,10},{40,10},{40,10}},
      color={255,127,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end Transformer;
