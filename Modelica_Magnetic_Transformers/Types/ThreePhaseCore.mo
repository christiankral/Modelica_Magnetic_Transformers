within Modelica_Magnetic_Transformers.Types;
type ThreePhaseCore = enumeration(
    noCore
         "No core",
    symmetricCore
                "Symmetric core",
    symmetricCoreBackIron
                        "Symmetric core with back iron")
"Enumeration defining core type of three phase transformers"
  annotation (Documentation(
      info="<html>
<p>
Enumeration type of transformer cores.
</p>
</html>"));
