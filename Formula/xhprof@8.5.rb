# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class XhprofAT85 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "cc8c7ea18e52881d24c8bdb9dd6891be842bd2e58647ef56d1fd8fe156340d33"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e21845205cf96efc38462e3974e316516ea0d6aea807822521771b64eb0c4930"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9d1d269320c2f32c07c8fbb43ab48624c7114c558cec6930a8ce4118811d24c6"
    sha256 cellar: :any_skip_relocation, sonoma:        "5b42822f15994259125d99febeec79b13deca8d260fcab73a8853e86b67947da"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "69578d4a0834c6800416ef14321bb64ef015f13067b3dd51b3042aea6d40afe8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "78c51b8a313cb0722d115c15ffd8de169b16eac0ef225546b69e62a31635bfe5"
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
