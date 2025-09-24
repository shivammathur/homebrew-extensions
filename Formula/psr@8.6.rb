# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT86 < AbstractPhpExtension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-1.2.0.tgz"
  sha256 "9c3d2a0d9770916d86e2bc18dfe6513ad9b2bfe00f0d03c1531ef403bee38ebe"
  head "https://github.com/jbboehr/php-psr.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/psr/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "aaf0b5e3f54d822432aa2a6a0c9141c7840df466f89fc74db2af487dd1fe963f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8239e9db989b055b2670ed34063e10198c0c19f826c87f6b3de3c456a2b93502"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b581810a74a95708ce3c92b687b5777610348196a1517cf86368ea4688d42761"
    sha256 cellar: :any_skip_relocation, sonoma:        "d8ed970cd0ecf5691393fca63cee0149bfb4deaedbb291a7a0aba57afffcc6e9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "07db4c99224c784f7c21995adef68fd5a9478a7ff791373ce88cf31c4c94db8c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1a39850c47c81a5c2447eb0434c3fafde4620e146360b1b79ee438026e9af9b0"
  end

  depends_on "pcre"

  def install
    Dir.chdir "psr-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-psr"
    system "make"
    prefix.install "modules/psr.so"
    write_config_file
  end
end
