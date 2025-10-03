# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class XhprofAT71 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "910c09ceb8ee419a709a8773447a90b5d056bb422c70c62a081c72a6f2be8469"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "360dc9116727b880cf0c2f4bd3f01223223e6f4e35af58922bf76487f0fe6925"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "270f16a020cf2e2757905dc6d9e2d55af6a3380d12d1ca8ea553be18a98213fd"
    sha256 cellar: :any_skip_relocation, sonoma:        "4fd1507be4fcd8ffc425fd3d469f7d1d220b10d7ec3d24fd9be23b4e87893bab"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8f09581822d5830344cf7ac246ca0624148733f4a0f87f90924e70fda9db12f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c48d8929bcb3d35c685b9793b531fb641738628549ea6693ad74a40b4fcfc4be"
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
