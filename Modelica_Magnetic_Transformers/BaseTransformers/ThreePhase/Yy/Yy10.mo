within Modelica_Magnetic_Transformers.BaseTransformers.ThreePhase.Yy;
partial model Yy10 "Transformer Yy10"
  extends Modelica_Magnetic_Transformers.Interfaces.ThreePhase.Transformer(final VectorGroup="Yy10");
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
  Modelica.Electrical.MultiPhase.Basic.Delta rot2(final m=m)
    annotation (Placement(transformation(extent={{40,-10},{60,10}},
          rotation=0)));
equation
  connect(star1.pin_n, starpoint1) annotation (Line(points={{-10,-90},{
        -10,-100},{-50,-100}},   color={0,0,255}));
  connect(star2.pin_n, starpoint2) annotation (Line(points={{10,-90},{
        10,-100},{50,-100}},   color={0,0,255}));
  connect(transformer.plug_n3,rot2. plug_p) annotation (Line(
      points={{10,-10},{10,-10},{20,-10},{20,-10},{30,-10},{30,6.66134e-16},
          {40,6.66134e-16}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(rot2.plug_n, plug2) annotation (Line(
      points={{60,6.66134e-16},{100,6.66134e-16},{100,4.44089e-16}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(transformer.plug_n1, star1.plug_p) annotation (Line(
      points={{-10,-6},{-10,-70}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(transformer.plug_p1, plug1) annotation (Line(
      points={{-10,6},{-100,6},{-100,4.44089e-16}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(transformer.plug_n2, transformer.plug_p3) annotation (Line(
      points={{10,4},{16,4},{16,-4},{10,-4}},
      color={0,0,255},
      smooth=Smooth.None));
connect(transformer.plug_p2, star2.plug_p) annotation (Line(
    points={{10,10},{20,10},{20,-40},{10,-40},{10,-70}},
    color={0,0,255},
    smooth=Smooth.None));
  annotation (defaultComponentName="transformer", Documentation(info="<html>
Transformer Yy10
<br>Typical parameters see:
<a href=\"modelica://Transformers.Interfaces.PartialSymmetricTwoWindingTransformer\">PartialBasicTransformer</a>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
          -100},{100,100}}),
                    graphics));
end Yy10;
