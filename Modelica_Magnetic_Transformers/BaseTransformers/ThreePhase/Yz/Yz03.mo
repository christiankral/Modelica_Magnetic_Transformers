within Modelica_Magnetic_Transformers.BaseTransformers.ThreePhase.Yz;
model Yz03 "Transformer Yz3"
  extends Modelica_Magnetic_Transformers.Interfaces.ThreePhase.Transformer(final VectorGroup="Yz03");
  Modelica.Electrical.MultiPhase.Basic.Star star1(final m=m)
    annotation (Placement(transformation(
        origin={-10,-80},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Interfaces.NegativePin starpoint1
    annotation (Placement(transformation(extent={{-60,-110},{-40,-90}},
          rotation=0)));
  Modelica.Electrical.MultiPhase.Basic.Star star2(final m=m)
    annotation (Placement(transformation(
        origin={10,-80},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Interfaces.NegativePin starpoint2
    annotation (Placement(transformation(extent={{40,-110},{60,-90}},
          rotation=0)));
  Modelica.Electrical.MultiPhase.Basic.Delta Rot21(final m=m)
    annotation (Placement(transformation(
        origin={50,0},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Electrical.MultiPhase.Basic.Delta Rot22(final m=m)
    annotation (Placement(transformation(
        origin={50,-40},
        extent={{-10,10},{10,-10}},
        rotation=180)));
equation
  connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
        -10,-100},{-50,-100}},   color={0,0,255}));
  connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
        10,-100},{50,-100}},   color={0,0,255}));
connect(transformer.plug_p1, plug1) annotation (Line(
    points={{-10,6},{-20,6},{-20,0},{-100,0}},
    color={0,0,255},
    smooth=Smooth.None));
connect(transformer.plug_n1, star1.plug_p) annotation (Line(
    points={{-10,-6},{-10,-70}},
    color={0,0,255},
    smooth=Smooth.None));
connect(transformer.plug_p2, Rot21.plug_p) annotation (Line(
    points={{10,10},{50,10}},
    color={0,0,255},
    smooth=Smooth.None));
connect(Rot21.plug_n, transformer.plug_p3) annotation (Line(
    points={{50,-10},{30,-10},{30,-4},{10,-4}},
    color={0,0,255},
    smooth=Smooth.None));
connect(transformer.plug_n2, Rot22.plug_n) annotation (Line(
    points={{10,4},{20,4},{20,-40},{40,-40}},
    color={0,0,255},
    smooth=Smooth.None));
connect(Rot22.plug_p, plug2) annotation (Line(
    points={{60,-40},{100,-40},{100,4.44089e-16}},
    color={0,0,255},
    smooth=Smooth.None));
connect(transformer.plug_n3, star2.plug_p) annotation (Line(
    points={{10,-10},{10,-70}},
    color={0,0,255},
    smooth=Smooth.None));
  annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yz3
<br>Typical parameters see:
<a href=\"modelica://Modelica.Electrical.Machines.Interfaces.PartialBasicTransformer\">PartialBasicTransformer</a>
</html>"),
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
          -100},{100,100}}), graphics));
end Yz03;
