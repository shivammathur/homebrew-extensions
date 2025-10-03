# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class XhprofAT73 < AbstractPhpExtension
  init
  desc "Hierarchical Profiler for PHP"
  homepage "https://github.com/longxinH/xhprof"
  url "https://pecl.php.net/get/xhprof-2.3.10.tgz"
  sha256 "251aee99c2726ebc6126e1ff0bb2db6e2d5fd22056aa335e84db9f1055d59d95"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/xhprof/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "42d79ef37579599429ee0adaa20c482b1b09a8e135e3b7da3ce288221298c7b7"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fee949be528af51579852fb9735fc108d2ae373a3d6e09ff2e6dc7d4cae553dd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "969ec79cc57497c332cf942953ea78010072c0c134f1d39d229a9937a9e200f9"
    sha256 cellar: :any_skip_relocation, sonoma:        "317fbc8dd3eb83e8b229ac48d04f5baea6e9a344327c77205df5204135460bd1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3b2f31edc55ef6864270306c13bac8696790946860c05c45462839d0f255fd95"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bead77340092ae00bde2c7a86a76229dbbdf7e66bd7d329a833206396fa0c8f4"
  end

  def install
    Dir.chdir "xhprof-#{version}/extension"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xhprof"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
