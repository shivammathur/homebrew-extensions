# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class XhprofAT80 < AbstractPhpExtension
  init
  desc "Hierarchical Profiler for PHP"
  homepage "https://github.com/longxinH/xhprof"
  url "https://pecl.php.net/get/xhprof-2.3.10.tgz"
  sha256 "251aee99c2726ebc6126e1ff0bb2db6e2d5fd22056aa335e84db9f1055d59d95"
  head "https://github.com/longxinH/xhprof.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/xhprof/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "a5de6442fe34ae303a53069eb17bdd565407ad392eebaf06ae97103e3c600f54"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b58a8b96692cc17a1b175e278155978a23fb6b7e66be2a655408067e927feca0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "90828d1760b04b5a1e2640569a61c4cabc4de3500c8512a45eb772b2487bab46"
    sha256 cellar: :any_skip_relocation, sonoma:        "fe2a3cd2a091d31cb31dfc8c39425cfcd28d275ca554f17c25cb042804129021"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "778a38ccf4efa3c239212e6b48bc13027d3d1d0c4390e20983d8208fa8dd4819"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d8f11d658389acd40399dafeb8e7ebff8d59cdb57dde807cff51df9905b985c8"
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
