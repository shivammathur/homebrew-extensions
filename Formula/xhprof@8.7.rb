# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class XhprofAT87 < AbstractPhpExtension
  init
  desc "Hierarchical Profiler for PHP"
  homepage "https://github.com/longxinH/xhprof"
  url "https://pecl.php.net/get/xhprof-2.3.10.tgz"
  sha256 "251aee99c2726ebc6126e1ff0bb2db6e2d5fd22056aa335e84db9f1055d59d95"
  revision 2
  head "https://github.com/longxinH/xhprof.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/xhprof/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "a9ce3156bfe2ffe7a2662e17bdd93f1f9508ee130d8d259edf4b9619c5203542"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "95a3cf6b32ef19497c4ef50764f14a884e7e78d98a0e40d48dac37a64e104672"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "e05a60ca1d478f086afe6f85aa341f1d82c0c551aa35ff87169aa6fee4f14e22"
    sha256 cellar: :any,                 arm64_linux:       "63b91aab22490387419054061cc7fc0fb64991a4cd8edcb9f554043ca80fcd4c"
    sha256 cellar: :any,                 x86_64_linux:      "4e256b69f89d2f6ac817e2c721d88f3356ae16f3769253c19dda9e97cfecd27d"
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
