# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class XhprofAT87 < AbstractPhpExtension
  init
  desc "Hierarchical Profiler for PHP"
  homepage "https://github.com/longxinH/xhprof"
  url "https://pecl.php.net/get/xhprof-2.3.10.tgz"
  sha256 "251aee99c2726ebc6126e1ff0bb2db6e2d5fd22056aa335e84db9f1055d59d95"
  revision 1
  head "https://github.com/longxinH/xhprof.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/xhprof/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "b8449da1279821e77c67a27fa846b21457141b03b7904059cced633936fae111"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "9c39ab6f73511309a6c913d666449cd9a955e3626897f8517c2173b31a4cfd5a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "cbf37d38ffb3148ee575a2a36b6494b92155906b47a2620ea72d9526c379c258"
    sha256 cellar: :any,                 arm64_linux:       "a585094d5a19defdca02ac8644f2324bf7a2cb58f82ebcc01211851a15fd7601"
    sha256 cellar: :any,                 x86_64_linux:      "237e5c38a7783e6af554260b166e72905cf7278ea47f37a7a0b724314e6a4fa2"
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
