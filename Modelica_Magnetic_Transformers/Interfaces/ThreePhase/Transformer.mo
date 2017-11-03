within Modelica_Magnetic_Transformers.Interfaces.ThreePhase;
partial model Transformer "Partial three phase transformer"
  extends Modelica_Magnetic_Transformers.Icons.ThreePhaseTransformer;
  final parameter Integer m(min=1) = 3 "Number of phases";
  constant String VectorGroup="Yy00";
  parameter Real N1 = 1 "Number of primary turns";
  parameter Real n = 1
  "Ratiom primary to secondary number of turns, N1/N2";
  parameter Modelica.SIunits.Resistance R1(start=5E-3/(if C1 == "D" then 1
         else 3)) "Primary resistance per phase at TRef"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Temperature T1Ref(start=293.15)
  "Reference temperature of primary resistance"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter
  Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
    alpha20_1(start=0)
  "Temperature coefficient of primary resistance at 20 degC"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Inductance L1sigma(start=78E-6/(if C1 == "D"
         then 1 else 3)) "Primary stray inductance per phase"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Resistance R2(start=5E-3/(if C2 == "d" then 1
         else 3)) "Secondary resistance per phase at TRef"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Temperature T2Ref(start=293.15)
  "Reference temperature of secondary resistance"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter
  Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
    alpha20_2(start=0)
  "Temperature coefficient of secondary resistance at 20 degC"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Inductance L2sigma(start=78E-6/(if C2 == "d"
         then 1 else 3)) "Secondary stray inductance per phase"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Boolean useThermalPort=false
  "Enable / disable (=fixed temperatures) thermal port"
    annotation (Evaluate=true);
  parameter Modelica.SIunits.Temperature T1Operational(start=293.15)
  "Operational temperature of primary resistance"   annotation (Dialog(
        group="Operational temperatures", enable=not useThermalPort));
  parameter Modelica.SIunits.Temperature T2Operational(start=293.15)
  "Operational temperature of secondary resistance"   annotation (Dialog(
        group="Operational temperatures", enable=not useThermalPort));
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
  final parameter Modelica.SIunits.Reluctance R_mCore=
      if core==Modelica_Magnetic_Transformers.Types.ThreePhaseCore.noCore
      then 0 else N1^2/L1m "Reluctance of legs"
    annotation(Evaluate=true);
  final parameter Modelica.SIunits.Permeance G_mBackIron=
      if core==Modelica_Magnetic_Transformers.Types.ThreePhaseCore.symmetricCoreBackIron
      then (L1m+L1sigma+L10)/N1^2 else 0 "Permeance of back iron"
      annotation(Evaluate=true);

  output Modelica.SIunits.Voltage v1[m]=plug1.pin.v "Primary voltage";
  output Modelica.SIunits.Current i1[m]=plug1.pin.i "Primary current";
  output Modelica.SIunits.Voltage v2[m]=plug2.pin.v "Secondary voltage";
  output Modelica.SIunits.Current i2[m]=plug2.pin.i "Secondary current";
protected
  constant String C1=Modelica.Utilities.Strings.substring(
          VectorGroup,
          1,
          1);
  constant String C2=Modelica.Utilities.Strings.substring(
          VectorGroup,
          2,
          2);
  parameter Real ni=n*(if C2 == "z" then sqrt(3) else 2)*(if C2 == "d"
       then 1 else sqrt(3))/(if C1 == "D" then 1 else sqrt(3));
public
  Modelica.Electrical.Machines.Interfaces.ThermalPortTransformer thermalPort(final m=m) if
       useThermalPort
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Electrical.Machines.Thermal.ThermalAmbientTransformer thermalAmbient(
    final useTemperatureInputs=false,
    final T1=T1Operational,
    final T2=T2Operational,
    final m=m) if not useThermalPort annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,80})));
protected
  Modelica.Electrical.Machines.Interfaces.ThermalPortTransformer internalThermalPort(final m=m)
    annotation (Placement(transformation(extent={{-4,76},{4,84}})));
public
  Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug1(final m=m)
  "Electric plug of primary side"   annotation (Placement(transformation(extent=
           {{-90,-10},{-110,10}}, rotation=0)));
  Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug2(final m=m)
  "Electric plug of secondary side"   annotation (Placement(transformation(
          extent={{90,-10},{110,10}}, rotation=0)));
BaseTransformers.Components.ThreePhase.Transformer transformer(
  final N1=N1,
  final n=n,
  final R1=R1,
  final T1Ref=T1Ref,
  final L1sigma=L1sigma,
  final R2=R2,
  final T2Ref=T2Ref,
  final L2sigma=L2sigma,
  final useThermalPort=true,
  final T1Operational=T1Operational,
  final T2Operational=T2Operational,
  final VectorGroup=VectorGroup,
  final alpha20_1=alpha20_1,
  final alpha20_2=alpha20_2,
  final core=core,
  final L1m=L1m,
  final L10=L10) "Internal transformer"
  annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(thermalPort, internalThermalPort) annotation (Line(
      points={{0,100},{0,80}},
      color={199,0,0},
      smooth=Smooth.None));
  connect(thermalAmbient.thermalPort, internalThermalPort) annotation (Line(
      points={{-20,80},{0,80}},
      color={199,0,0},
      smooth=Smooth.None));

  connect(transformer.thermalPort, internalThermalPort) annotation (Line(
      points={{0,10},{0,80}},
      color={199,0,0},
      smooth=Smooth.None));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
              extent={{0,-60},{0,-100}},
              lineColor={0,0,255},
              textString="%VectorGroup"),Text(
              extent={{0,100},{0,60}},
              lineColor={0,0,255},
              textString="%name")}), Documentation(info="<html>
Partial model of a three-phase transformer, containing primary and secondary resistances and stray inductances, as well as the iron core.
Circuit layout (vector group) of primary and secondary windings have to be defined.
<br><b>Default values for transformer's parameters (a realistic example) are:</b><br>
<table>
<tr>
<td valign=\"top\">turns ratio n</td>
<td valign=\"top\">1</td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">nominal frequency fNominal</td>
<td valign=\"top\">50</td><td valign=\"top\">Hz</td>
</tr>
<tr>
<td valign=\"top\">nominal voltage per phase</td>
<td valign=\"top\">100</td><td valign=\"top\">V RMS</td>
</tr>
<tr>
<td valign=\"top\">nominal current per phase</td>
<td valign=\"top\">100</td><td valign=\"top\">A RMS</td>
</tr>
<tr>
<td valign=\"top\">nominal apparent power</td>
<td valign=\"top\">30</td><td valign=\"top\">kVA</td>
</tr>
<tr>
<td valign=\"top\">primary resistance R1</td>
<td valign=\"top\">0.005</td><td valign=\"top\">Ohm per phase at reference temperature</td>
</tr>
<tr>
<td valign=\"top\">reference temperature T1Ref</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">temperature coefficient alpha20_1 </td>
<td valign=\"top\">0</td><td valign=\"top\">1/K</td>
</tr>
<tr>
<td valign=\"top\">primary stray inductance L1sigma</td>
<td valign=\"top\">78E-6</td><td valign=\"top\">H per phase</td>
</tr>
<tr>
<td valign=\"top\">secondary resistance R2</td>
<td valign=\"top\">0.005</td><td valign=\"top\">Ohm per phase at reference temperature</td>
</tr>
<tr>
<td valign=\"top\">reference temperature T2Ref</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">temperature coefficient alpha20_2 </td>
<td valign=\"top\">0</td><td valign=\"top\">1/K</td>
</tr>
<tr>
<td valign=\"top\">secondary stray inductance L2sigma</td>
<td valign=\"top\">78E-6</td><td valign=\"top\">H per phase</td>
</tr>
<tr>
<td valign=\"top\">operational temperature T1Operational</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">operational temperature T2Operational</td>
<td valign=\"top\">20</td><td valign=\"top\">&deg;C</td>
</tr>
<tr>
<td valign=\"top\">These values give the operational parameters:</td>
<td valign=\"top\"> </td><td valign=\"top\"> </td>
</tr>
<tr>
<td valign=\"top\">nominal voltage drop</td>
<td valign=\"top\">0.05</td><td valign=\"top\">p.u.</td>
</tr>
<tr>
<td valign=\"top\">nominal copper losses</td>
<td valign=\"top\">300</td><td valign=\"top\">W</td>
</tr>
</table>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),      graphics));
end Transformer;
