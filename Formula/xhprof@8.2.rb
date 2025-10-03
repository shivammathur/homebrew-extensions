# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class XhprofAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "2154db78df40f87896eeb07ac12674554e8eb9a219858f29a895518a23edc479"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7d348d52cb2c6099601a5ab13293a4c10b7104b9a4d2a23fef9b5e3ab53b2c4b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c291c3dd8edf43c55eadf237663137149c4d81971baa64c98faf13a27979b17b"
    sha256 cellar: :any_skip_relocation, sonoma:        "6768ef79fa09981991a6fde2143856b9750e0215dc2ee1952107fcdfc4681637"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b914c2b9dacc03c3e81e4229c97035e519d17b10898e7c69298d4c6973b6c2ef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6492816a443e7d6a41ebd8df2c4cb9301af46aabcc4925f5745adb59603c5997"
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
