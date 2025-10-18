# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class XhprofAT83 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c740973df3625a087ecc6d27a1c1563f0be9bdd72cd4d6b01a2f82d224e51294"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3e417a29a95a613bb92621a20cda9089cbcb3218b8ecbce5eb98418e2fcbb292"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "bbdeaebc0b5c274c586f474e4cdac58f87ca5edcf38319861c8fc7e7f699a9d4"
    sha256 cellar: :any_skip_relocation, sonoma:        "e1f5aff937b436363ae2677094ca35104890352b05fa5ef09bafb140b763b643"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "667c242ff2a5f5cf5c060812e95f4617c1aeee5d6316fcabdfc1723904380535"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ee1da1576b6efca32e2961bb9c7b18ac949a7e5c852fc01aaf3c498f79fc2a7f"
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
