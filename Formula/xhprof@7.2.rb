# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class XhprofAT72 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "bf89c44fc2653974622ba79e2a29cc653513a84983c5ff315892f7484da0b0fc"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2025c965c722b1725a9699b5a78b756f891a647d33072f88e173c288f2398f4c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2b5df60b8e7c4bf8483b007eb6095af3c953b1fd9b60933ba95b929e0fda3e31"
    sha256 cellar: :any_skip_relocation, sonoma:        "5b8d74964c9e7876babbf1a3bb57e3665c098e541d896144e5f04e258c55096e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7e16ba0818716f6ec3af60311f552501f3a97e320a44d7d510a8c8d484de1a55"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "60da46b40403439f5dd8a50530ce51b00e8e596a59e7ebe03e34ac65e0d188bb"
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
