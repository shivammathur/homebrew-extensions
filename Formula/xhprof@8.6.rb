# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class XhprofAT86 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "fe158399d387842a9be3e0e00254e46ce0900e014cbb474c6a7c0ea9f9bf02bf"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "e612d13fab87cddec9e8387a62a8f163238e4a55c19c91f997a4535f5a065291"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "f63a9d00c139957e700cb9b5ce3bf144589a9580818367a3f353a42af041d9fb"
    sha256 cellar: :any,                 arm64_linux:       "bb0c2475b764ed7df76463775f7fde82487a8d3c953cba2acd905949f9fe5870"
    sha256 cellar: :any,                 x86_64_linux:      "ba525ba4a9ea5c3acc1c292bc818bbe2c2860857030be66e59921c102fef5f2c"
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
