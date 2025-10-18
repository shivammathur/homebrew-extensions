# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class XhprofAT81 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "9b661f3d0a379db3af13cebcf15db5f78c6d0cf07703e6114038cd547e854632"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1cdc19f76a962d3eaf421c860f687bb1cf0156e9e3825132c86d97f8afa3e412"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f5d28754878db5d284955c14078cd17584982c5e25b3ed8f501591b32c28520f"
    sha256 cellar: :any_skip_relocation, sonoma:        "6edaa1a2afea538cf7ec94078100c9494519c8601c42e0a4efe6bb49763629da"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7d1887825f4f39d2c21f00285e7d634286b7f4335b3648fc73f405b20bc658f8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "349a8ec33c87e1433dcb24462a5a1cdf6403cd3246a5a43f639607bc44d672d7"
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
