# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class XhprofAT74 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "b3ff4810265d93b99863bf4fad48c68bac5d34178584377539a692c6383ee95a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "73cf11100d22980484384177648c947f0a725d764de0f2d0d346588b62e4c921"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c1c01ada12b064f1ccc5d6eff959efd8626d47a214506122769d6a7a5a2c9c86"
    sha256 cellar: :any_skip_relocation, sonoma:        "ff003859c5c60e3cda35b43f775b9a95cbe38d5291f9272e067341e2d4bbf90a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4860c84eacfa0831362ad6485b5183ccbd673f62a5329efb14aeeb3ed1916dc3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "066a33f958ba9b9e3d2ed7c259f765060fb08d419dfce80b8e375d11876e524a"
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
