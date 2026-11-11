# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class XhprofAT86 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "fc94175022dc7d619584da8e810bdc74c016a3b112f97a1b7d34eea33970b474"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "f7013e0f6b243dfaaf28473adc4193cea465f22bd5d1d042bb5b0e818ca887a3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "98fa89ba98c9987e6287323397b54c5f20d6c4622111bd0a1b871e11fbc741fb"
    sha256 cellar: :any,                 arm64_linux:       "0ea8aca03e5e397232595a29f8330161cf0b8c047bac972b228fb632740675f6"
    sha256 cellar: :any,                 x86_64_linux:      "6994bc33700579193212e164b63fdd61fbaf8cbed5ea5e5b9d3fd1e971b33459"
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
