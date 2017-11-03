within Modelica_Magnetic_Transformers.BaseTransformers.SinglePhase;
model TwoWinding "Two windings single phase transformer"
  extends Modelica_Magnetic_Transformers.Interfaces.SinglePhase.PartialTransformer;

  parameter Modelica_Magnetic_Transformers.Types.SinglePhaseCore core=Modelica_Magnetic_Transformers.Types.SinglePhaseCore.noCore "Core type" annotation (Dialog(tab="Nominal resistances and inductances", group="Core"));
  parameter Modelica.SIunits.Inductance L1m = 0
  "Main field inductance per phase w.r.t. primary side"
    annotation(Dialog(
      tab="Nominal resistances and inductances",
      group = "Core",
      enable=core <> Transformers.Types.SinglePhaseCore.noCore));
  final parameter Modelica.SIunits.Reluctance R_mLegsYokes=
      if core==Modelica_Magnetic_Transformers.Types.SinglePhaseCore.noCore
         then 0 else N1^2/L1m "Reluctance of core"
         annotation(Evaluate=true);
  Modelica.Magnetic.FluxTubes.Basic.ConstantReluctance coreLegsYokes(final R_m=R_mLegsYokes)
  "Total reluctance of primary and secondary legs and yokes"
    annotation (Placement(transformation(extent={{-40,-10},{-60,10}})));
Modelica.Magnetic.FluxTubes.Basic.Ground ground
  annotation (Placement(transformation(extent={{60,-20},{80,0}})));
equation
  connect(ground.port, winding2.port_n) annotation (Line(
      points={{70,0},{30,0}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(winding1.port_p, coreLegsYokes.port_p) annotation (Line(
      points={{-30,0},{-40,0}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(coreLegsYokes.port_n, winding2.port_n) annotation (Line(
      points={{-60,0},{-70,0},{-70,40},{50,40},{50,0},{30,0}},
      color={255,127,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end TwoWinding;
