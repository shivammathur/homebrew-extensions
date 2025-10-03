# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class XhprofAT84 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "145fc33f3854ebf2c83d7a39d725d1d8eaab93903e393d2b66ba6ca4520dfee9"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "10d3e29d88b607f70b2a11bf2052b89b86feba846826bd9642e0b11fdadfe12a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "677f37f2b08ab12ad98fc4faa2a7f1ba278d010466a7ea2d9d467e1bded353d0"
    sha256 cellar: :any_skip_relocation, sonoma:        "6691642cdd35a793b5742815be58878af6ce5c9fc94b6bfce56193fba3009648"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "527d91d10e0b32f8b7a59cbd41ad615b98c2c01e05374d5aba89603d1bbff30b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "18b21e7f34bb8aba0bd4597ce14097c0a4ab7e2b90e8b7c7fcf51a5f84402eed"
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
