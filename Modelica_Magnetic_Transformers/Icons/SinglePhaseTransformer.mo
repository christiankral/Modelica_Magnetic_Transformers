within Modelica_Magnetic_Transformers.Icons;
model SinglePhaseTransformer "Single phase transformer"

  annotation (Icon(graphics={Polygon(
              points={{-50,60},{-30,40},{-30,-40},{-50,-60},{-50,60}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={135,135,135},
              fillPattern=FillPattern.VerticalCylinder),Polygon(
              points={{50,60},{30,40},{30,-40},{50,-60},{50,60}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={135,135,135},
              fillPattern=FillPattern.VerticalCylinder),
                                       Polygon(
              points={{-50,60},{50,60},{30,40},{10,40},{0,40},{-10,40},{-30,
            40},{-50,60}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              smooth=Smooth.None,
              fillColor={135,135,135}),Polygon(
              points={{-50,-60},{50,-60},{30,-40},{10,-40},{0,-40},{-10,-40},
            {-30,-40},{-50,-60}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              smooth=Smooth.None,
              fillColor={135,135,135}),Rectangle(
              extent={{-58,36},{-22,-36}},
              lineColor={128,0,255},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={128,0,255}),Rectangle(
          extent={{-64,28},{-16,-28}},
          lineColor={255,128,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0}),    Rectangle(
              extent={{22,36},{58,-36}},
              lineColor={128,0,255},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={128,0,255}),Rectangle(
          extent={{16,28},{64,-28}},
          lineColor={255,128,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0})}),     Documentation(info="<html>
<p>
This icon is designed for a <b>transient transformer</b> model.
</p>
</html>"));
end SinglePhaseTransformer;
