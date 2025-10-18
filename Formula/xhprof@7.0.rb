# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class XhprofAT70 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "01fdee5fbc1f2e03dc770201e014b9a51d1c796c618c7290b4fc0bc917199c8c"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "eef6307a972aa4c74c55a539cc1c58912abc15e9032b01fedcaafe705e525eb1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "700f48c59f4a43c07bad023e24f400b7c52881bb6d9d8099fa3a85234adc9d48"
    sha256 cellar: :any_skip_relocation, sonoma:        "a0d74e710a7dc29cfd6aaf7c261fa749d8b97ba6e663f5e2ee6d43c630fd22bb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4f018d4b3b1892d9c147e1472c17f1e0b7299934f3ac5b7d2169a57364cd7db3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "75eb47f5c5a69e236602cb56d53a827c7a501ee49fb8057413df10a4363aa8be"
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
