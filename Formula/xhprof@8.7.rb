# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class XhprofAT87 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "9ecd55f9d58f3c5bc3f5ffe1c23826592990df909fd0a3f77d8633717479e7ed"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "4b23c1f5eae3cffce4d162568099e0f06df65a58f616add27259e91ddd56bc54"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "3a07f9667a6ba4ab1bb2310dc11e8532b9cba06cb60333393baff74385fcaca6"
    sha256 cellar: :any,                 arm64_linux:       "9cbca167d1a4bce2e974f42a36701971f1eca4541215329ceb3ca983a703e069"
    sha256 cellar: :any,                 x86_64_linux:      "f79e429157174e9e1f873f5f9b817e5385a0589433e4fdc9d6377ca088053ad1"
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
