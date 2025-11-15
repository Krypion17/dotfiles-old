{ services, lib, buildPythonPackage,
  setuptools,
  zeroconf,
  python-uinput,
  pyudev
}:

buildPythonPackage rec {
  pname = "yoke";
  version = "master";
  pyproject = true;

  permitUserSite = true;

  src = fetchGit {
    url = "file:///home/krypion17/Downloads/git/yoke/";
    name = pname;
    ref = "master";
    rev = "98c9635d78eed41054bfb9e95adaf837c982c6b4";
    shallow = true;
  };

  build-system = [
    setuptools
  ];

  dependencies = [
    setuptools
    zeroconf
    python-uinput
    pyudev
  ];

  pipInstallFlags = [
    "-e"
  ];

  preShellHook = "export PYTHONPATH = /home/krypion17/test/:$PYTHONPATH";
  postPatch = "echo $PYTHONPATH";

}
